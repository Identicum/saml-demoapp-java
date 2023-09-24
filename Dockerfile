FROM ghcr.io/identicum/alpine-jdk17-maven:latest as builder
WORKDIR /app
COPY . .
RUN mvn install -DskipTests

# ############################################################################
FROM ghcr.io/identicum/alpine-jre17-tomcat9:latest

COPY --from=builder /app/target/saml-demoapp-java.war /tmp/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/* && \
    unzip -qq /tmp/saml-demoapp-java.war -d /usr/local/tomcat/webapps/ROOT && \
    rm -f /tmp/saml-demoapp-java.war && \
    ln -sf /dev/stdout /tmp/demo-app-saml.log
