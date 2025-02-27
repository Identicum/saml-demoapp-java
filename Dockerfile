FROM ghcr.io/identicum/alpine-jdk17-maven:latest AS builder
WORKDIR /app
COPY . .
RUN mvn install -DskipTests

# ############################################################################
FROM ghcr.io/identicum/alpine-jre17-tomcat9:latest

COPY --from=builder /app/target/saml-demoapp-java.war /tmp/

ENV ONELOGIN_SAML2_DEBUG=true
ENV ONELOGIN_SAML2_STRICT=true
ENV ONELOGIN_SAML2_IDP_ENTITYID = ""
ENV ONELOGIN_SAML2_SP_ENTITYID=""
ENV ONELOGIN_SAML2_SP_ASSERTION_CONSUMER_SERVICE_URL=""
ENV ONELOGIN_SAML2_SP_SINGLE_LOGOUT_SERVICE_URL=""
ENV ONELOGIN_SAML2_SP_NAMEIDFORMAT="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"
ENV ONELOGIN_SAML2_SP_X509CERT="MIIElTCCAv2gAwIBAgIUdNaTo4f9R7Gbb0Us3W/SVDJW6CMwDQYJKoZIhvcNAQELBQAwWjELMAkGA1UEBhMCQVIxDTALBgNVBAgMBENBQkExFTATBgNVBAcMDEJ1ZW5vcyBBaXJlczESMBAGA1UECgwJSWRlbnRpY3VtMREwDwYDVQQDDAhkZW1vYXBwMTAeFw0yNTAyMDkyMzA4MjVaFw0zNTAyMDkyMzA4MjVaMFoxCzAJBgNVBAYTAkFSMQ0wCwYDVQQIDARDQUJBMRUwEwYDVQQHDAxCdWVub3MgQWlyZXMxEjAQBgNVBAoMCUlkZW50aWN1bTERMA8GA1UEAwwIZGVtb2FwcDEwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQDI+ffTp7+bBe76OBNLHOEIOlvfsIif5BV1Q2fj5/EUef/motU5/qjYGBhAfjdu/UyZrG6tBDT9KN6kN5dAcX4ovuAPD7iZp5xUyJcYWbBOkL7/i19RlPKuVKKYTcQsVaBsOnvAhHouo90UerbD/596i1tpyKnBa6n2wgKHi3RC0Zw23DfFv7ASyb/Xh93w6WkbrThJN5iEo+6Nkv9NCDbmCPwxcU6W6U9Lge059XkmlrLBbOC6hdv4bmRt6F8RK1mOU8MogUxWre0y7RB4UQg1KP1LQgMu6LMfq44PLcJFNft2hgoBzSpUV7h/2za+ecWTCb9WL7xm7TQlPrR8KhqzmPZKYOs3mqmqLGWC4e0ysge2vOvsl6/NJtvHqePaBxmSFZaUQhF7YoOr6SkzxhbJL79+KOr58LYua2oj1LBLMC+l6Vs491bTGGxatuGqIYX3zbRKiAgY4TiZpKC9nIt8sz4ikyOQL+ELLk3DIPtY2ZNwQGleRDLsEGwtNtXcnQMCAwEAAaNTMFEwHQYDVR0OBBYEFNmATtxpPELt+t9Za+OGPzKZQ1FbMB8GA1UdIwQYMBaAFNmATtxpPELt+t9Za+OGPzKZQ1FbMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggGBAICkA+9eTPakvnjJoM3vUIlTurCtFYCmSgf62kUGw56Xwza9dtJ0e4P1ZIDvQoN/AO2GKsyIYFmY1zz2yXaUwU3lHQ3a7GZPI6cWZn2UjPLKrtY/KCyN00qaaFr/44bTictsUVoUPpS931xJucpKGgQ+DXNyCtdhCxW8SoyPKbHIc3WrjeYz1lfp8GV+TyGsRu/bwLHRcxHETd46BqYbavEX7SiBTscm++iw9+RzSFgrpwtGXH0gOW8FgNhLHyF/ngFUXRyXmaoxDnaWLnGO4a4QKXulqY6jpTt7YIau7dsOIbyjJQfn/kes/BWyhCyTgN5ntXcYBXsBmH4aComBWiA/SUY1IfAryV1/C3P9qhIvF4HYb4QVhbDiAiKKTnob6/wXWG013DSbsDmQW97zLCXPzlqMNqYh+hWJqdrHZCHJh8SAKpmpWhEjEtE9UieTWW8ihecjY+nxw/8vUH9rKJJaGiSw51E97cROwxKJKjXNpYn/5AQbsLqL5hY3fHhryw=="
ENV ONELOGIN_SAML2_SP_PRIVATEKEY="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"
ENV ONELOGIN_SAML2_SECURITY_AUTHNREQUEST_SIGNED=false
ENV ONELOGIN_SAML2_SECURITY_LOGOUTREQUEST_SIGNED=false
ENV ONELOGIN_SAML2_SECURITY_LOGOUTRESPONSE_SIGNED=false
ENV ONELOGIN_SAML2_SECURITY_WANT_MESSAGES_SIGNED=false
ENV ONELOGIN_SAML2_SECURITY_WANT_ASSERTIONS_SIGNED=false
ENV ONELOGIN_SAML2_SECURITY_WANT_ASSERTIONS_ENCRYPTED=false
ENV ONELOGIN_SAML2_SECURITY_WANT_NAMEID_ENCRYPTED=false
ENV ONELOGIN_SAML2_SECURITY_SIGNATURE_ALGORITHM="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"
ENV ONELOGIN_SAML2_SECURITY_DIGEST_ALGORITHM="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"
ENV ONELOGIN_SAML2_SECURITY_ALLOW_DUPLICATED_ATTRIBUTE_NAME=false

RUN rm -rf /usr/local/tomcat/webapps/ROOT/* && \
    unzip -qq /tmp/saml-demoapp-java.war -d /usr/local/tomcat/webapps/ROOT && \
    rm -f /tmp/saml-demoapp-java.war && \
    ln -sf /dev/stdout /tmp/demo-app-saml.log
