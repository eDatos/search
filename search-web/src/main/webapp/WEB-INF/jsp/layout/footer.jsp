<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="es.gobcan.istac.idxmanager.web.buscador.util.WebUtils" %>
	<!-- PIE DE PÁGINA -->
<div id="pie_istac">
	<c:set var="extFooterUrl" value="<%=WebUtils.getFooter()%>" />
	<c:import url="${extFooterUrl}" var="rawFooter" charEncoding="UTF-8" />
</div>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/jquery.qtip-2.2.1.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/jquery.cookie.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/istac-bs/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/select2-4.0.0.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/i18n/select2-4.0.0.es.min.js"></script>
<script type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/custom.js"></script>


