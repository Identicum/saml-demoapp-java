<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "samlsettings.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Identicum - SAMLv2 demo app</title>
		<script src="./js/jquery-3.3.1.slim.min.js" ></script>
		<script src="./js/popper.min.js"></script>
		<script src="./js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="./css/common.css" >
		<link rel="stylesheet" href="./css/bootstrap.min.css" >
		<link rel="stylesheet" href="./css/all.css">
		<% getSamlSettings(); %>
	</head>
	<body>
		<div class="navbar fixed-top">
			<div class="container">
				<div class="navbar-header">
					<a class="navbar-brand" rel="home" href="#" title="Identicum">
						<img style="max-width:140px; margin-top: -7px;" src="imgs/logo.png">
					</a>
				</div>
				<div class="navbar-nav">
					<a class="nav-item" href="dologin.jsp" style="color:#ffffff">Login</a>
				</div>
			</div>
		</div>
	</body>
</html>
