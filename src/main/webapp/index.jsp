<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "samlsettings.jsp" %>
<!DOCTYPE html>
<html style="height: -webkit-fill-available; background-color: #eafcec;">
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
		<link rel="shortcut icon" href="/imgs/favicon.ico" type="image/x-icon">
		<% getSamlSettings(); %>
	</head>
	<body style="background: url(/imgs/logo.png) no-repeat center; height: -webkit-fill-available;">
		<div class="navbar" style="background: white;">
			<div class="container">
				<div class="navbar-header" style="height: fit-content; overflow: hidde;">
					<a class="navbar-brand" rel="home" href="#" title="Identicum">
						<img style="max-width:300px; height: 100px; margin-right: 0px;" src="imgs/logo.png"> <span style="color: #3fac40">| SAMLv2 DemoApp</span>
					</a>
				</div>
			</div>
		</div>
		<div style="height: 600px; text-align: center; display: grid;">
			<a id="login-button" class="btn btn-success" style="height: 3rem; width: 7rem; grid-column-start: 2; grid-row-end: 4; grid-row-start: 4; padding-top: 10px;" href="dologin.jsp">Login</a>
		</div>
	</body>
</html>
