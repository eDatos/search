<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="es.gobcan.istac.idxmanager.web.buscador.util.WebUtils" %>
<%@ page import="org.siemac.metamac.core.common.util.InternationalizationUtils" %>
<%@include file="../util/taglibs.jsp"%>
<%String internationalizationCookie = InternationalizationUtils.getInstance().getInternationalizationCookieId(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 


<div id="cabecera">
<fmt:setBundle basename="application" var="appVersion" />

  <c:set var="extHeaderUrl" value="<%=WebUtils.getHeader()%>" />
  <c:set var="apiKey" value="<%=WebUtils.getApiKey()%>" />
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
	  <c:param name="appVersion">
        <fmt:message bundle="${appVersion}" key="app.version" />
      </c:param>
	  <c:param name="apiKey" value="${apiKey}"/>
    </c:import>
  </c:if>
</div>