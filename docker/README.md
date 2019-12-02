# saml-demoapp-java
SAMLv2 demo app using OneLogin's SAML Java Toolkit.

## Source
Source code can be found at: https://github.com/Identicum/saml-demoapp-java

## Usage

### Install

Pull `identicum/saml-demoapp-java` from the Docker repository:

    docker pull identicum/saml-demoapp-java


Or build `identicum/saml-demoapp-java` from source:

    git clone https://github.com/Identicum/saml-demoapp-java.git
    cd saml-demoapp-java/docker
    docker build -t identicum/saml-demoapp-java .

### Run

#### Customize your onelogin.saml.properties
* Get base file from https://github.com/Identicum/saml-demoapp-java/blob/master/src/main/resources/onelogin.saml.properties
* Customize to your environment

#### Run the container

#### Run the container with your custom variables as JAVA_OPTS environment variables

Run the image, binding associated ports, and defining your custom variables as environment variables:

    docker run -d \
	    -p 8080:8080 \
	    -e "JAVA_OPTS=-Donelogin.saml2.sp.entityid=sp-entityid -Donelogin.saml2.sp.assertion_consumer_service.url=http://demoapp/saml-demoapp-java/acs.jsp -Donelogin.saml2.idp.entityid=idp-entityid -Donelogin.saml2.idp.x509cert=idp-x509cert -Donelogin.saml2.idp.single_sign_on_service.url=idp-sso-url" \
        identicum/saml-demoapp-java


#### Or Run the container mounting your custom onelogin.saml.properties

Run the image, binding associated ports, and mounting your custom onelogin.saml.properties:

    docker run -d \
      -p 8080:8080 \
      -v $(pwd)/onelogin.saml.properties:/usr/local/tomcat/webapps/saml-demoapp-java/WEB-INF/classes/onelogin.saml.properties \
      identicum/saml-demoapp-java
