<%@page import="com.onelogin.saml2.Auth"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.lang3.StringUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</head>
<body>
	<%
	    Boolean found = false;
		@SuppressWarnings("unchecked")
		Enumeration<String> elems = (Enumeration<String>) session.getAttributeNames();	
		Map<String, List<String>> attributes;
		while (elems.hasMoreElements() && !found) {
			String value = (String) elems.nextElement();
			if (value.equals("attributes") || value.equals("nameId")) {
				found = true;
			}
		}
	%>
	<div class="navbar fixed-top">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" rel="home" href="#" title="Identicum">
					<img style="max-width:140px; margin-top: -7px;" src="imgs/logo.png">
				</a>
			</div>
			<div class="navbar-nav">
				<a class="nav-item" href="dologout.jsp" style="color:#ffffff">Logout</a>
			</div>
		</div>
	</div>
	<div class="container">
	<%
		if(found)
		{	
			attributes = (Map<String, List<String>>) session.getAttribute("attributes");
			if (attributes.isEmpty()) 
			{
	%>
				<div class="alert alert-danger" role="alert">You don't have any attributes</div>
	<%
			}
			else 
			{
    %>
        		<table class="table">
      				<thead>
      					<tr>
        					<th>Name</th>
        					<th>Values</th>
        				</tr>
      				</thead>
      				<tbody>
    <%				
				Collection<String> keys = attributes.keySet();
				for(String name :keys)
				{
					out.println("<tr><td>" + name + "</td><td>");
					List<String> values = attributes.get(name);
					for(String value :values) {
						out.println("<li>" + value + "</li>");
					}
					
					out.println("</td></tr>");
				}
	%>
					</tbody>
				</table>
	<%
			}
		} 
		else 
		{
			out.println("<div class=\"alert alert-danger\" role=\"alert\">Not authenticated</div>");
		}
		
	%>
	</div>
</body>
</html>