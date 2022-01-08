<%@page import="com.onelogin.saml2.Auth,
                com.onelogin.saml2.servlet.ServletUtils,
                java.util.List,
                java.util.Map,
                org.apache.commons.lang3.StringUtils"
        language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
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
        Map<String, List<String>> attributes = auth.getAttributes();
        String nameId = auth.getNameId();

        session.setAttribute("auth", auth);
        session.setAttribute("attributes", attributes);
        session.setAttribute("nameId", nameId);
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
