<%@page import="es.gobcan.istac.idxmanager.web.buscador.util.WebUtils" %>
<%@ page import="org.siemac.metamac.core.common.util.InternationalizationUtils" %>
<%@include file="../util/taglibs.jsp"%>
<%
String internationalizationCookie = InternationalizationUtils.getInstance().getInternationalizationCookieId();
String locale = InternationalizationUtils.getInstance().getCurrentLocale(request);
 %>
<%--
  La cabecera externa la pide el navegador, no el servidor: aqui solo se
  construye la URL y se deja en un contenedor vacio que rellena
  theme/js/edatos-external-html.js. Antes se descargaba con <c:import> en cada
  render, y los crawlers no ejecutan JavaScript, asi que barrer el catalogo
  provocaba una peticion a complementos-apps por pagina servida.

  Si la propiedad de la URL no resuelve no se pinta ni el contenedor, para no
  dejar un hueco vacio en la pagina.
--%>
<c:set var="extHeaderUrl" value="<%=WebUtils.getHeader()%>" />
<c:if test="${!empty extHeaderUrl}">
  <c:set var="apiKey" value="<%=WebUtils.getApiKey()%>" />
  <fmt:setBundle basename="application" var="appVersion" />
  <c:url var="headerUrl" value="${extHeaderUrl}">
    <c:param name="appName">
      <fmt:message key="app.name" />
    </c:param>
    <c:param name="<%= internationalizationCookie %>" value="<%=locale%>" />
    <c:param name="appId" value="search"/>
    <c:param name="appVersion">
      <fmt:message bundle="${appVersion}" key="app.version" />
    </c:param>
    <c:param name="apiKey" value="${apiKey}"/>
  </c:url>
  <div id="cabecera" data-edatos-html-url="<c:out value="${headerUrl}" />"></div>
</c:if>
