# saml-demoapp-java
SAMLv2 demo app using OneLogin's SAML Java Toolkit.

## Configure

In order to deploy the demo application, you need to configure a number of parameters in the [configuration file](src/main/resources/onelogin.saml.properties).
Some of those parameters are endpoint URLs of your IdP.
Additionally, you need to create your trust relationship in your IdP and configure the certificate in the SP.
