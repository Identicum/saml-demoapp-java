<%@page import="java.util.Base64,
				org.apache.commons.lang.StringEscapeUtils,
				java.util.Collection,
				java.util.Enumeration,
				java.util.List,
				java.util.Map,
				org.apache.commons.lang3.StringUtils,
                org.slf4j.Logger,
	            org.slf4j.LoggerFactory,
				javax.xml.parsers.DocumentBuilder,
                javax.xml.parsers.DocumentBuilderFactory,
                org.w3c.dom.*,
                org.xml.sax.InputSource,
				java.io.StringReader"
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

			String assertionB64 = (String)session.getAttribute("assertionB64");
			logger.debug("AssertionB64: {}", assertionB64);

			String assertionXML = (String)session.getAttribute("assertionXML");
			logger.debug("AssertionXML: {}", assertionXML);

			String nameId = session.getAttribute("nameId").toString();
			String nameIdFormat = session.getAttribute("nameIdFormat").toString();
			logger.debug("NameID: {} with format {}", nameId, nameIdFormat);

			String attributesXML = (String)session.getAttribute("attributesXML");
			logger.debug("attributesXML: {}", attributesXML);

			NodeList attributesList = null;
			DocumentBuilder builder = null;
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			try{
				builder = factory.newDocumentBuilder();
				if(attributesXML != null && !attributesXML.isEmpty()){
					Document attributesDOM = builder.parse(new InputSource(new StringReader(attributesXML)));
					Node rootNode = attributesDOM.getDocumentElement();
					logger.debug("Root Node: {}", rootNode);
					attributesList = rootNode.getChildNodes();	
				}
			}catch(Exception e){
				e.printStackTrace();
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
						<a class="nav-link active" id="assertionb64-tab" data-toggle="tab" href="#assertionb64" role="tab" aria-controls="assertionb64" aria-selected="true">Assertion b64</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="assertionxml-tab" data-toggle="tab" href="#assertionxml" role="tab" aria-controls="assertionxml" aria-selected="false">Assertion XML</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="attributes-tab" data-toggle="tab" href="#attributes" role="tab" aria-controls="attributes" aria-selected="false">Assertion attributes</a>
					</li>
				</ul>
				<div class="tab-content" id="myTabContent">
				<!-- Tab panes -->
					<div class="tab-content" style="padding-top: 20px">
						<div class="tab-pane fade show active" id="assertionb64" role="tabpanel" aria-labelledby="assertionb64-tab">
							<h2>base64-encoded assertion</h2>
							<pre id="base64Assertion"><%= assertionB64 %></pre>
						</div>
						<div class="tab-pane fade" id="assertionxml" role="tabpanel" aria-labelledby="assertionxml-tab">
							<h2>SAML Response</h2>
							<pre lang="xml"><%= StringEscapeUtils.escapeHtml(assertionXML) %></pre>
						</div>
						<div class="tab-pane fade" id="attributes" role="tabpanel" aria-labelledby="attributes-tab">
				<%
					if(nameId != null)
					{
						out.println("<tr><td>NameID (" + nameIdFormat + ")</td><td></td><td>" + nameId + "</td></tr>");
						if (attributesList == null)
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
										<th>Friendly Name</th>
										<th>Values</th>
									</tr>
								</thead>
								<tbody>
				<%
							for(int i = 0; i < attributesList.getLength(); i++){
								Node attribute = attributesList.item(i);
								NamedNodeMap elementAttributes = attribute.getAttributes();
								out.println("<tr><td>" + elementAttributes.getNamedItem("Name").getTextContent() + "</td><td>" + elementAttributes.getNamedItem("FriendlyName").getTextContent() + "</td><td>" + attribute.getTextContent() + "</td></tr>");
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
