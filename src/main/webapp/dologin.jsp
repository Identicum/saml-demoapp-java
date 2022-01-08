<%@page import="com.onelogin.saml2.Auth,
				com.onelogin.saml2.settings.SettingsBuilder,
				com.onelogin.saml2.settings.Saml2Settings"
	language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "samlsettings.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<%
		Saml2Settings settings = new SettingsBuilder().fromProperties(getSamlSettings()).build();
		Auth auth = new Auth(settings, request, response);
		auth.login(request.getContextPath() + "/attrs.jsp");
	%>
</body>
</html>
