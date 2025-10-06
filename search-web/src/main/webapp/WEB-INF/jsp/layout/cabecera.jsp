<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="es.gobcan.istac.idxmanager.web.buscador.util.WebUtils" %>

<div id="cabecera">
 <c:set var="extHeaderUrl" value="<%=WebUtils.getHeader()%>" />
  <c:catch var="headerErr">
    <c:import url="${extHeaderUrl}" var="rawHeader" charEncoding="UTF-8" />
  </c:catch>
  <c:choose>
    <c:when test="${empty headerErr}">
      <c:set var="h1" value="${fn:replace(rawHeader,'href=\"/','href=\"https://estadisticas.arte-consultores.com/')}" />
      <c:set var="h2" value="${fn:replace(h1,'src=\"/','src=\"https://estadisticas.arte-consultores.com/')}" />
      ${h2}
    </c:when>
    <c:otherwise>
      <!-- Fallback local + salida del error para depurar -->
      <jsp:include page="/WEB-INF/jsp/layout/_header-local.jsp"/>
      <!-- quita esto en prod -->
      <pre style="color:#c00">${headerErr}</pre>
    </c:otherwise>
  </c:choose>
</div>