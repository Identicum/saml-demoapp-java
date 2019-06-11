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
Run the image, binding associated ports, and mounting your custom onelogin.saml.properties:

    docker run -p 8080:8080 -v $(pwd)/onelogin.saml.properties:/usr/local/tomcat/webapps/saml-demoapp-java/WEB-INF/classes/onelogin.saml.properties identicum/saml-demoapp-java
