<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="es.gobcan.istac.idxmanager.web.buscador.util.WebUtils" %>
	<!-- PIE DE PÁGINA -->
<%--
  El pie externo lo pide el navegador, igual que la cabecera: ver
  theme/js/edatos-external-html.js.

  Antes se descargaba con <c:import ... var="rawFooter">, que guarda la
  respuesta en una variable en lugar de imprimirla, asi que la peticion se
  hacia en cada render y el pie no llegaba a verse.

  No se le pasa idioma ni organizacion porque la descarga anterior tampoco los
  enviaba.
--%>
<c:set var="extFooterUrl" value="<%=WebUtils.getFooter()%>" />
<c:if test="${!empty extFooterUrl}">
	<div id="pie_istac" data-edatos-html-url="<c:out value="${extFooterUrl}" />"></div>
</c:if>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/jquery.qtip-2.2.1.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/jquery.cookie.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/istac-bs/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/select2-4.0.0.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/i18n/select2-4.0.0.es.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/custom.js"></script>


