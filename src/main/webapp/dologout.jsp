<%@page import="com.onelogin.saml2.Auth,
                org.slf4j.Logger,
	            org.slf4j.LoggerFactory"
        language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<%
    Logger logger = LoggerFactory.getLogger("dologout.jsp");
    Auth auth = new Auth(request, response);
    logger.debug("Doing logout");
    String nameId = null;
    if (session.getAttribute("nameId") != null) {
            nameId = session.getAttribute("nameId").toString();
    }
    logger.debug("NameID: {}", nameId);
    String nameIdFormat = null;
    if (session.getAttribute("nameIdFormat") != null) {
            nameIdFormat = session.getAttribute("nameIdFormat").toString();
    }
    logger.debug("nameIdFormat: {}", nameIdFormat);
    String nameidNameQualifier = null;
    if (session.getAttribute("nameidNameQualifier") != null) {
            nameidNameQualifier = session.getAttribute("nameidNameQualifier").toString();
    }
    logger.debug("nameidNameQualifier: {}", nameidNameQualifier);
    String nameidSPNameQualifier = null;
    if (session.getAttribute("nameidSPNameQualifier") != null) {
            nameidSPNameQualifier = session.getAttribute("nameidSPNameQualifier").toString();
    }
    logger.debug("nameidSPNameQualifier: {}", nameidSPNameQualifier);
    String sessionIndex = null;
    if (session.getAttribute("sessionIndex") != null) {
            sessionIndex = session.getAttribute("sessionIndex").toString();
    }
    logger.debug("sessionIndex: {}", sessionIndex);
    auth.logout(null, nameId, sessionIndex, nameIdFormat, nameidNameQualifier, nameidSPNameQualifier);
%>
</body>
</html>
