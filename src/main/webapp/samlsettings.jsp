<%@page import="java.util.Properties,
				com.onelogin.saml2.settings.IdPMetadataParser,
				java.io.File,
				java.io.FileInputStream,
				java.io.FileOutputStream,
				java.net.URL,
				java.util.Arrays,
				java.util.List,
				java.util.Map,
				org.apache.commons.lang3.StringUtils" %>
<%@ page import="java.util.stream.Collectors" %>
<%!
public Properties getSamlSettings() throws Exception {

    Properties properties = new Properties();
    File file = new File(this.getClass().getClassLoader().getResource("onelogin.saml.properties").getFile());

    FileInputStream inputStream = new FileInputStream(file);
    properties.load(inputStream);
    FileOutputStream outputStream = new FileOutputStream(file);

    properties.forEach((key,value) -> {
        String envProperty = System.getProperty(key.toString());
        if(envProperty != null){
            properties.setProperty(key.toString(), envProperty);
        }
    });

    String idpEntityDescriptor = properties.getProperty("idp.entity.descriptor");
    if(StringUtils.isNotBlank(idpEntityDescriptor)){
        List<String> idpProperties = Arrays.asList("onelogin.saml2.idp.entityid", "onelogin.saml2.idp.x509cert", "onelogin.saml2.idp.single_sign_on_service.url");
        URL url = new URL(properties.getProperty("idp.entity.descriptor"));

        Map<String, Object> idpMetadata = IdPMetadataParser.parseRemoteXML(url);
        idpMetadata = idpMetadata
                .entrySet()
                .stream()
                .filter(property -> idpProperties.contains(property.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
        properties.putAll(idpMetadata);
    }

    properties.store(outputStream, null);
    outputStream.close();
    inputStream.close();

    return properties;
}
%>