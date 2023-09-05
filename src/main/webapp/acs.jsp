<%@page import="com.onelogin.saml2.Auth,
                com.onelogin.saml2.servlet.ServletUtils,
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
                javax.xml.transform.TransformerFactory,
                javax.xml.transform.Transformer,
                javax.xml.transform.dom.DOMSource,
                javax.xml.transform.stream.StreamResult,
                java.io.StringWriter"
        language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Logger logger = LoggerFactory.getLogger("acs.jsp");
    Auth auth = new Auth(request, response);
    auth.processResponse();
    if (!auth.isAuthenticated()) {
        out.println("<div class=\"alert alert-danger\" role=\"alert\">Not authenticated</div>");
    }
    List<String> errors = auth.getErrors();
    if (!errors.isEmpty()) {
        out.println("<p>" + StringUtils.join(errors, ", ") + "</p>");
        if (auth.isDebugActive()) {
            String errorReason = auth.getLastErrorReason();
            if (errorReason != null && !errorReason.isEmpty()) {
                out.println("<p>" + auth.getLastErrorReason() + "</p>");
            }
        }
        out.println("<a href=\"dologin.jsp\" class=\"btn btn-primary\">Log in</a>");
    } else {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = null;
        String assertionXML = auth.getLastResponseXML();
        String attributesXML = "";
        try{
            builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new InputSource(new StringReader(assertionXML)));
            Node rootNode = doc.getDocumentElement();
            logger.debug("Root Node: {}", rootNode);
            NodeList nodeList = rootNode.getChildNodes();
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node currentNode = nodeList.item(i);
                if (currentNode.getNodeName() == "saml:Assertion") {
                    logger.debug("Assertion Node: {}", currentNode);
                    Node assertion = currentNode;
                    NodeList assertionNodeList = assertion.getChildNodes();
                    for(int j = 0; j < assertionNodeList.getLength(); j++){
                        Node assertionNode = assertionNodeList.item(j);
                        if(assertionNode.getNodeName() == "saml:AttributeStatement"){                            
                            TransformerFactory tf = TransformerFactory.newInstance();
                            Transformer transformer = tf.newTransformer();
                            StringWriter writer = new StringWriter();
                            transformer.transform(new DOMSource(assertionNode), new StreamResult(writer));
                            attributesXML = writer.getBuffer().toString();
                            logger.debug("attributesXML: {}", attributesXML);
                        }
                    }
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        session.setAttribute("assertionB64", request.getParameter("SAMLResponse"));
        session.setAttribute("nameIdFormat", auth.getNameIdFormat());
        session.setAttribute("assertionXML", assertionXML);
        session.setAttribute("attributesXML", attributesXML);
        session.setAttribute("nameId", auth.getNameId());
        session.setAttribute("sessionIndex", auth.getSessionIndex());
        String relayState = request.getParameter("RelayState");

        if (relayState != null && !relayState.isEmpty() && !relayState.equals(ServletUtils.getSelfRoutedURLNoQuery(request)) &&
                !relayState.contains("/dologin.jsp")) {
            // We don't want to be redirected to login.jsp either
            response.sendRedirect(request.getParameter("RelayState"));
        } else {
            response.sendRedirect(request.getContextPath() + "/attrs.jsp");
        }
    }
%>
