FROM ghcr.io/identicum/centos7-java11-maven:latest as builder
WORKDIR /app
COPY . .
RUN mvn install -DskipTests

# ############################################################################
FROM ghcr.io/identicum/centos7-java11-tomcat:latest

RUN yum -y install unzip
COPY --from=builder /app/target/saml-demoapp-java.war /tmp/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/* \
 && unzip -qq /tmp/saml-demoapp-java.war -d /usr/local/tomcat/webapps/ROOT \
 && rm -f /tmp/saml-demoapp-java.war

RUN ln -sf /dev/stdout /tmp/demo-app-saml.log
