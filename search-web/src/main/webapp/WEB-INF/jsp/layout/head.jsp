<%@ page pageEncoding="UTF-8"%>
<%@page import="es.gobcan.istac.idxmanager.web.buscador.util.WebUtils" %>
<%@include file="../util/taglibs.jsp"%>
	<head>
		<title><%=WebUtils.getWelcomeTitle()%> <fmt:message key="welcome.title" /></title>
		<meta http-equiv="Content-Type"	content="text/html; charset=UTF-8" />

        <%-- Cargador de la cabecera y el pie externos. Va lo mas arriba posible
             y por delante de las hojas de estilo: con `defer` al final del
             <head> el navegador le daba la prioridad mas baja y terminaba el
             ultimo de todos los recursos, retrasando la aparicion de la
             cabecera. No depende de jQuery ni de nada mas, asi que puede ser el
             primero. `defer` se conserva para que no bloquee el parseo. --%>
        <script defer="defer" fetchpriority="high" type="text/javascript" src="<%=WebUtils.getFullURL(request, false)%>theme/js/edatos-external-html.js"></script>

		<meta name="robots" content="all" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta name="keywords" content="Buscador del instituto" />
		<meta name="description" content="Filtre y visualice de manera rápida la información disponible por operaciones estadísticas." />
		<meta http-equiv="imagetoolbar" content="no" />

        <link rel="stylesheet" href="<%=WebUtils.getFullURL(request, false)%>theme/css/paginadorsimple.css"/>
		<link rel="stylesheet" href="<%=WebUtils.getFullURL(request, false)%>theme/css/search-overrides.css">

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="<%=WebUtils.getFullURL(request, false)%>theme/istac-bs/css/istac-bs.css"/>
        
        <!-- Optional theme -->
        <link rel="stylesheet" href="<%=WebUtils.getFullURL(request, false)%>theme/istac-bs/css/istac-bstheme.css"/>
        
        <link rel="stylesheet" href="<%=WebUtils.getFullURL(request, false)%>theme/css/jquery.qtip-2.2.1.min.css"/>
        <link rel="stylesheet" href="<%=WebUtils.getFullURL(request, false)%>theme/css/select2-4.0.0.min.css" />
        <link rel="stylesheet" href="<%=WebUtils.getFullURL(request, false)%>theme/css/select2-bootstrap.min.css" />

        <link rel="stylesheet" href="<%=WebUtils.getFullURL(request, false)%>theme/css/main.css"/>

        <%-- Sin JavaScript nadie anade la clase `edatos-listo`, asi que el body
             se quedaria oculto para siempre. Se revela aqui: se pierde la
             cabecera, que ya se asumia, pero el buscador sigue usandose. --%>
        <noscript>
            <style type="text/css">
                body { visibility: visible; animation: none; }
            </style>
        </noscript>

	</head>