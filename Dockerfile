FROM maven:3-openjdk-11 as builder
WORKDIR /app
COPY . .
RUN mvn install -DskipTests

# ############################################################################
FROM ghcr.io/identicum/centos-tomcat:latest
LABEL maintainer="Gustavo J Gallardo <ggallard@identicum.com>"

RUN yum -y install unzip
COPY --from=builder /app/target/saml-demoapp-java.war /tmp/
RUN unzip -qq /tmp/saml-demoapp-java.war -d /usr/local/tomcat/webapps/saml-demoapp-java && \
    rm -f /tmp/saml-demoapp-java.war && \
    echo "<% response.sendRedirect(\"/saml-demoapp-java/\"); %>" > webapps/ROOT/index.jsp

RUN ln -sf /dev/stdout /tmp/demo-app-saml.log
