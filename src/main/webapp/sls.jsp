<%@page import="com.onelogin.saml2.Auth,
				java.util.List"
		language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "samlsettings.jsp" %>
<!DOCTYPE html>
<html>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Identicum</title>
	<script src="./js/jquery-3.3.1.slim.min.js" ></script>
	<script src="./js/popper.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="./css/common.css" >
	<link rel="stylesheet" href="./css/bootstrap.min.css" >
	<link rel="stylesheet" href="./css/all.css">
	<%
		Auth auth = new Auth(request, response);
		auth.processSLO();
	%>
	<body>
		<div class="container text-center mt-5">
		<%
		List<String> errors = auth.getErrors();
			if (errors.isEmpty()) {
		%>
			<div class="alert alert-success">Sucessfully logged out</div>
			<a href="dologin.jsp" class="btn btn-secondary active text-center" role="button" aria-pressed="true">Log in again</a>
		<%
			} else {
				out.println("<p>");
				for(String error : errors) {
					out.println("Error: " + error + ".");
				}
				out.println("</p>");
			}
		%>
		</div>
	</body>
</html>