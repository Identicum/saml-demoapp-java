<%@page import="com.onelogin.saml2.Auth"
        language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<%
    Auth auth = new Auth(request, response);
    auth.logout(null,
            (String) session.getAttribute("nameId"),
            (String) session.getAttribute("sessionIndex"),
            (String) session.getAttribute("nameIdFormat"));
%>
</body>
</html>
