<%@page import="java.util.Base64,
				org.apache.commons.lang.StringEscapeUtils,
				com.onelogin.saml2.Auth,
				java.util.Collection,
				java.util.Enumeration,
				java.util.List,
				java.util.Map,
				org.apache.commons.lang3.StringUtils,
                org.slf4j.Logger,
	            org.slf4j.LoggerFactory" 
		language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			Logger logger = LoggerFactory.getLogger("attrs.jsp");
			String xmlResponse = null;
			String xmlAssertion = null;
			Auth auth = (Auth)session.getAttribute("auth");
			if(auth != null) {	
				xmlResponse = auth.getLastResponseXML();
				String samlTag = (StringUtils.containsIgnoreCase(xmlResponse, "<saml:Assertion")) ? "saml" : "saml2";
				int beginIndex = xmlResponse.indexOf("<" + samlTag + ":Assertion");
				int endIndex = xmlResponse.indexOf("</" + samlTag + ":Assertion>") + ("</" + samlTag + ":Assertion>").length();
				xmlAssertion = xmlResponse.substring(beginIndex, endIndex);
				logger.debug("xmlAssertion: {}", xmlAssertion);
			}
			String nameId = auth.getNameId();
			logger.debug("NameID: {}", nameId);
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
					<a class="navbar-brand" rel="assertionb64" href="#" title="Identicum">
						<img style="max-width:140px; margin-top: -7px;" src="imgs/logo.png">
					</a>
				</div>
				<div class="navbar-nav">
					<a class="nav-item" href="dologout.jsp" style="color:#ffffff">Logout</a>
				</div>
			</div>
		</div>
		<div class="container" style="margin-top:100px"> 
			<div>
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item">
						<a class="nav-link" id="assertionb64-tab" data-toggle="tab" href="#assertionb64" role="tab" aria-controls="assertionb64" aria-selected="true">Assertion b64</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="response-tab" data-toggle="tab" href="#response" role="tab" aria-controls="response" aria-selected="false">Assertion XML</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active" id="attributes-tab" data-toggle="tab" href="#attributes" role="tab" aria-controls="attributes" aria-selected="false">Asertion attributes</a>
					</li>
				</ul>
				<div class="tab-content" id="myTabContent">
				<!-- Tab panes -->
					<div class="tab-content" style="padding-top: 20px">
						<div class="tab-pane fade show active" id="attributes" role="tabpanel" aria-labelledby="attributes-tab">
				<%
					if(found)
					{
						logger.debug("attributes: {}", session.getAttribute("attributes"));
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
					out.println("<tr><td>NameID (" + auth.getNameIdFormat() + ")</td><td>" + nameId + "</td></tr>");
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
					<div class="tab-pane fade" id="response" role="tabpanel" aria-labelledby="response-tab">
						<h2>SAML Response</h2>
						<pre lang="xml"><%= StringEscapeUtils.escapeHtml(xmlResponse) %></pre>
					</div>
					<div class="tab-pane fade" id="assertionb64" role="tabpanel" aria-labelledby="assertionb64-tab">
						<a href="#" id="copy" class="btn btn-primary float-right">Copy to Clipboard</a>
						<h2>base64-encoded assertion</h2>
						<pre id="base64Assertion"><%= Base64.getEncoder().encodeToString(xmlAssertion.getBytes()) %></pre>
					</div>
				</div>
			</div>
		</div>
		<style>
			pre {
			white-space: pre-wrap;       /* css-3 */
			white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
			white-space: -pre-wrap;      /* Opera 4-6 */
			white-space: -o-pre-wrap;    /* Opera 7 */
			word-wrap: break-word;       /* Internet Explorer 5.5+ */
			}
		</style>
		<script>
			$("#copy").click(function(event){
				event.preventDefault();
				// Select the email link anchor text  
				var data = document.querySelector('#base64Assertion');
				var range = document.createRange();
				range.selectNode(data);
				window.getSelection().addRange(range);
				try
				{
					// Now that we've selected the anchor text, execute the copy command
					var successful = document.execCommand('copy');
					var msg = successful ? 'successful' : 'unsuccessful';
					console.log('Copy content command was ' + msg);
				} 
				catch (err)
				{
					console.log('Oops, unable to copy');
				}
				// Remove the selections - NOTE: Should use
				// removeRange(range) when it is supported
				window.getSelection().removeAllRanges();
			});
		</script>
	</body>
</html>
