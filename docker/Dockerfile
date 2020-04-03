FROM identicum/centos-java-maven:latest AS build-env

RUN git clone https://github.com/Identicum/saml-demoapp-java.git .
RUN /usr/bin/mvn package

# ############################################################################
# Build runtime image
FROM identicum/centos-tomcat:latest
LABEL maintainer="Gustavo J Gallardo <ggallard@identicum.com>"

RUN yum -y install unzip
COPY --from=build-env /source/target/saml-demoapp-java.war /tmp/
RUN unzip -qq /tmp/saml-demoapp-java.war -d /usr/local/tomcat/webapps/saml-demoapp-java && \
    rm -f /tmp/saml-demoapp-java.war && \
    echo "<% response.sendRedirect(\"/saml-demoapp-java/\"); %>" > webapps/ROOT/index.jsp

RUN ln -sf /dev/stdout /tmp/demo-app-saml.log
