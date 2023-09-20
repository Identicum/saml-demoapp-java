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
                javax.xml.namespace.NamespaceContext,
                javax.xml.parsers.DocumentBuilder,
                javax.xml.parsers.DocumentBuilderFactory,
                javax.xml.parsers.ParserConfigurationException,
                javax.xml.xpath.XPath,
                javax.xml.xpath.XPathConstants,
                javax.xml.xpath.XPathExpressionException,
                javax.xml.xpath.XPathFactory"
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
        String assertionXML = auth.getLastResponseXML();
        DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = builderFactory.newDocumentBuilder();
        Document xmlDocument = builder.parse(new InputSource(new StringReader(assertionXML)));
        XPath xPath = XPathFactory.newInstance().newXPath();
        String expression = "/Response/Assertion/AttributeStatement/Attribute";
        NodeList attributesList = (NodeList) xPath.compile(expression).evaluate(xmlDocument, XPathConstants.NODESET);
        
        session.setAttribute("assertionB64", request.getParameter("SAMLResponse"));
        session.setAttribute("nameIdFormat", auth.getNameIdFormat());
        session.setAttribute("assertionXML", assertionXML);
        session.setAttribute("attributesList", attributesList);
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
