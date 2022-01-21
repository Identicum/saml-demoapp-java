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
    logger.debug("Doing login");
    auth.login(request.getContextPath() + "/attrs.jsp");
%>
</body>
</html>
