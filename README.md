# saml-demoapp-java
SAMLv2 demo app using OneLogin's SAML Java Toolkit.

## Configure

In order to deploy the demo application, you need to configure a number of parameters in the [configuration file](src/main/resources/onelogin.saml.properties).
Some of those parameters are endpoint URLs of your IdP.
Additionally, you need to create your trust relationship in your IdP and configure the certificate in the SP.

## Build

The build process to compile the source code is based in Apache Maven.
To create the war file, go to the folder where you cloned the repository and run:
```sh
mvn clean package
```

## Run as Docker container

Run the image, binding associated ports, and defining your custom parameters as environment variables:

```sh
docker run -d \
    -p 8080:8080 \
    -e "JAVA_OPTS=-Donelogin.saml2.sp.entityid=sp-entityid -Donelogin.saml2.sp.assertion_consumer_service.url=http://demoapp/saml-demoapp-java/acs.jsp -Donelogin.saml2.idp.entityid=idp-entityid -Donelogin.saml2.idp.x509cert=idp-x509cert -Donelogin.saml2.idp.single_sign_on_service.url=idp-sso-url" \
    identicum/saml-demoapp-java
```