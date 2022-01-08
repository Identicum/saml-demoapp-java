<%@page import="java.util.Properties,
				com.onelogin.saml2.settings.IdPMetadataParser,
				java.io.File,
				java.io.FileInputStream,
				java.io.FileOutputStream,
				java.net.URL,
				org.apache.commons.lang3.StringUtils" %>
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

    properties.store(outputStream, null);
    outputStream.close();
    inputStream.close();

    String idpEntityDescriptor = properties.getProperty("idp.entity.descriptor");
    if(StringUtils.isNotBlank(idpEntityDescriptor)){
        URL url = new URL(properties.getProperty("idp.entity.descriptor"));
        properties.putAll(IdPMetadataParser.parseRemoteXML(url));
    }

    return properties;
}
%>