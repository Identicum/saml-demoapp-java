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
				java.io.StringReader,
				java.io.StringWriter,
				org.dom4j.Document,
				org.dom4j.DocumentHelper,
				org.dom4j.io.OutputFormat,
				org.dom4j.io.XMLWriter"
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
		<link rel="shortcut icon" href="/imgs/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="./css/common.css" >
		<link rel="stylesheet" href="./css/bootstrap.min.css" >
		<link rel="stylesheet" href="./css/all.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/styles/default.min.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/highlight.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/languages/go.min.js"></script>
		<style>
		li a{
                text-decoration: none;
                color: white;
            }
            .custom-menu {
            position: relative;
            display: inline-block;
            }
            .custom-menu-button {
                background-color: rgb(63, 172, 64);
                color: white;
                padding: 10px 20px;
                border: none;
                cursor: pointer;
            }
            .custom-menu-dropdown {
                position: absolute;
                width: max-content;
                top: 100%;
                padding: 0;
                background-color: rgb(63, 172, 64);
                color: white;
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.2s ease-in-out;
            }
            .custom-menu:hover .custom-menu-dropdown {
                opacity: 1;
                visibility: visible;
            }
            .custom-menu-item {
                padding: 10px;
                cursor: pointer;
            }
            .custom-menu-item:hover {
                border-radius: 10px;
            }
            .nav-link {
                color: #000;
            }
	</style>
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

			NodeList attributesList = (NodeList)session.getAttribute("attributesList");
			logger.debug("Attributes: {}", attributesList);
		%>
		<div class="navbar navbar-light bg-light fixed-top">
			<div class="container">
				<div class="navbar-header">
					<a class="navbar-brand" rel="assertionb64" href="#" title="Identicum">
						<img style="max-width:140px; margin-top: -7px;" src="imgs/logo.png">
					</a>
				</div>
				<div class="custom-menu">
                    <button class="custom-menu-button">Menu</button>
                    <ul class="custom-menu-dropdown">
						<li class="custom-menu-item" type="button"><a id="logout-button" href="dologout.jsp">Logout</a></li>
                    </ul>
                </div>
			</div>
		</div>

	<style>
		.nav-pills .nav-link.active {
			background-color: rgb(63, 172, 64);
		}
		a {
			color: rgb(63, 172, 64);
		}
	</style>

		<div class="container" style="margin-top:100px"> 
			<div>
				<ul class="nav nav-pills nav-fill" id="myTab" role="tablist">
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
							<a href="#" id="copy" class="btn btn-success float-right">Copy to Clipboard</a>
							<h2>base64-encoded assertion</h2>
							<pre id="base64Assertion"><%= assertionB64 %></pre>
						</div>
						<div class="tab-pane fade" id="assertionxml" role="tabpanel" aria-labelledby="assertionxml-tab">
							<h2>SAML Response</h2>
							<script>
								hljs.highlightAll();
							</script>
							<pre>
								<code class="language-xml hljs" style="white-space: pre;">
									<%
										StringEscapeUtils.escapeHtml(assertionXML);
										OutputFormat format = OutputFormat.createPrettyPrint();
										format.setIndentSize(3);
										format.setSuppressDeclaration(false);
										format.setEncoding("UTF-8");
										
										org.dom4j.Document document = DocumentHelper.parseText(assertionXML);
										StringWriter sw = new StringWriter();
										XMLWriter writer = new XMLWriter(sw, format);
										writer.write(document);
										out.println(StringEscapeUtils.escapeHtml(sw.toString()));
									%>
								</code>
						</pre>
						</div>
						<div class="tab-pane fade" id="attributes" role="tabpanel" aria-labelledby="attributes-tab">
				<%
					if(nameId != null)
					{
						out.println("<p><b>NameID</b> (" + nameIdFormat + ") = <b>" + nameId + "</b></p>");
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
