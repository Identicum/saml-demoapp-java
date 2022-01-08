<%@page import="java.util.*,
				com.onelogin.saml2.settings.Saml2Settings,
				com.onelogin.saml2.settings.SettingsBuilder"
		language="java" contentType="application/xhtml+xml" trimDirectiveWhitespaces="true"%>
<%@include file = "samlsettings.jsp" %>
<%
Saml2Settings settings = new SettingsBuilder().fromProperties(getSamlSettings()).build();
settings.setSPValidationOnly(true);
String metadata = settings.getSPMetadata();
List<String> errors = Saml2Settings.validateMetadata(metadata);
if (errors.isEmpty()) {
	out.println(metadata);
} else {
	response.setContentType("text/html; charset=UTF-8");
	for (String error : errors) {
		out.println("<p>"+error+"</p>");
	}
}%>