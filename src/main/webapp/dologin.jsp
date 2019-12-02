<%@page import="java.util.Properties,
				com.onelogin.saml2.Auth,
				java.io.File,
				java.io.FileInputStream,
				java.io.FileOutputStream,
				java.util.Optional"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<%
		Properties properties = new Properties();
		File file = new File(this.getClass().getClassLoader().getResource("onelogin.saml.properties").getFile());
		FileInputStream inputStream = new FileInputStream(file);	
		properties.load(inputStream);
		FileOutputStream outputStream = new FileOutputStream(file);
		
		properties.forEach((key,value) -> {
			String envProperty = System.getProperty(key.toString());
			if(envProperty != null){
				properties.setProperty(key.toString(), envProperty);
			}
		});

		properties.store(outputStream, null);
		outputStream.close();
		inputStream.close();
		
		Auth auth = new Auth(request, response);
	    auth.login(request.getContextPath() + "/attrs.jsp");
	%>
</body>
</html>
