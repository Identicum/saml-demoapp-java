<%@page import="java.util.Properties,
				com.onelogin.saml2.settings.IdPMetadataParser,
				java.io.File,
				java.io.FileInputStream,
				java.io.FileOutputStream,
				java.net.URL,
				java.util.Arrays,
				java.util.List,
				java.util.Map,
				org.apache.commons.lang3.StringUtils,
                org.slf4j.Logger,
	            org.slf4j.LoggerFactory" %>
<%@ page import="java.util.stream.Collectors" %>
<%!
public Properties getSamlSettings() throws Exception {

    Logger logger = LoggerFactory.getLogger("samlsettings.jsp");

    Properties properties = new Properties();

    File templateFile = new File(this.getClass().getClassLoader().getResource("onelogin.saml.template").getFile());
    FileInputStream inputStream = new FileInputStream(templateFile);
    properties.load(inputStream);
    inputStream.close();

    properties.forEach((key,value) -> {
        String envVariable = ((String) key).toUpperCase().replace('.', '_');
        String envValue = System.getenv(envVariable);

        if(envValue != null){
            logger.debug("Property \"{}\", setting value \"{}\" from environment.", key, envValue);
            properties.setProperty(key.toString(), envValue);
        }
        else{
            logger.debug("Property \"{}\", keeping value \"{}\" from template.", key, value);
        }
    });

    String idpEntityDescriptor = properties.getProperty("idp.entity.descriptor");
    if(StringUtils.isNotBlank(idpEntityDescriptor)){
        List<String> idpProperties = Arrays.asList("onelogin.saml2.idp.entityid", "onelogin.saml2.idp.x509cert", "onelogin.saml2.idp.single_sign_on_service.url", "onelogin.saml2.idp.single_logout_service.url");
        URL url = new URL(properties.getProperty("idp.entity.descriptor"));

        Map<String, Object> idpMetadata = IdPMetadataParser.parseRemoteXML(url);
        idpMetadata = idpMetadata
                .entrySet()
                .stream()
                .filter(property -> idpProperties.contains(property.getKey()))
                .peek(property -> logger.debug("Property {}, setting value \"{}\" from IDP metadata.", property.getKey(), property.getValue()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
        properties.putAll(idpMetadata);
    }

    logger.trace("Create File object.");
    File propertiesFile = new File(this.getClass().getClassLoader().getResource("onelogin.saml.properties").getFile());
    logger.trace("Open File object.");
    FileOutputStream outputStream = new FileOutputStream(propertiesFile);
    logger.debug("Persisting onelogin.saml.properties file.");
    properties.store(outputStream, null);
    logger.trace("Closing File object.");
    outputStream.close();

    logger.trace("Returning properties.");
    return properties;
}
%>