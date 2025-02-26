FROM ghcr.io/identicum/alpine-jdk17-maven:latest as builder
WORKDIR /app
COPY . .
RUN mvn install -DskipTests

# ############################################################################
FROM ghcr.io/identicum/alpine-jre17-tomcat9:latest

COPY --from=builder /app/target/saml-demoapp-java.war /tmp/

ENV ONELOGIN_SAML2_DEBUG=true
ENV ONELOGIN_SAML2_STRICT=true
ENV IDP_ENTITY_DESCRIPTOR=""
ENV ONELOGIN_SAML2_SP_ENTITYID=""
ENV ONELOGIN_SAML2_SP_ASSERTION_CONSUMER_SERVICE_URL=""
ENV ONELOGIN_SAML2_SP_SINGLE_LOGOUT_SERVICE_URL=""
ENV ONELOGIN_SAML2_SP_NAMEIDFORMAT="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"

RUN rm -rf /usr/local/tomcat/webapps/ROOT/* && \
    unzip -qq /tmp/saml-demoapp-java.war -d /usr/local/tomcat/webapps/ROOT && \
    rm -f /tmp/saml-demoapp-java.war && \
    ln -sf /dev/stdout /tmp/demo-app-saml.log
