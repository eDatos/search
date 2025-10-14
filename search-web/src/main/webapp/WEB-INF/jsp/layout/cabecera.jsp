<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="es.gobcan.istac.idxmanager.web.buscador.util.WebUtils" %>
<%@ page import="org.siemac.metamac.core.common.util.InternationalizationUtils" %>
<%@include file="../util/taglibs.jsp"%>
<%String internationalizationCookie = InternationalizationUtils.getInstance().getInternationalizationCookieId(); %>

<div id="cabecera">
<p><fmt:message key="app.version" /></p>
  <c:set var="extHeaderUrl" value="<%=WebUtils.getHeader()%>" />
  <c:catch var="headerErr">
    <c:import url="${extHeaderUrl}" var="rawHeader" charEncoding="UTF-8" />
  </c:catch>
  <c:if test="${!empty extHeaderUrl}">
    <c:import charEncoding="UTF-8" url="${extHeaderUrl}">
	  <c:param name="appName">
        <fmt:message key="app.name" />
      </c:param>
	  <c:param name="<%= internationalizationCookie %>" value="es" />
	  <c:param name="appId" value="search"/>
      <c:param name="appVersion" value="1.0" />
	  <c:param name="appVersion">
        <fmt:message key="app.version" />
      </c:param>
    </c:import>
  </c:if>
</div>