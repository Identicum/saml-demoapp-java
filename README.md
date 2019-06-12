# saml-demoapp-java
SAMLv2 demo app using OneLogin's SAML Java Toolkit.

## Configure
In order to deploy the demo application, you need to configure a number of parameters in the [configuration file](src/main/resources/onelogin.saml.properties).
Some of those parameters are endpoint URLs of your IdP.
Additionally, you need to create your client application in your IdP and configure the certificate in the SP.

## Build
The build process to compile the source code is based in Apache Maven.
To create the war file, go to the folder where you cloned the repository and run:

    mvn clean package

## Run

### WAR
To execute in a web container like Tomcat, simply copy the file to the webapps folder or deploy to your application server following standard procedures.

### Docker
The demo app can run a as Docker container.
Dockerfile and instructions documented [here](docker/)
