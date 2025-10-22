<%@ page pageEncoding="UTF-8"%>
<%@page import="es.gobcan.istac.idxmanager.web.buscador.util.WebUtils" %>
<%@include file="../util/taglibs.jsp"%>
	<head>
		<title><%=WebUtils.getWelcomeTitle()%> <fmt:message key="welcome.title" /></title>
		<meta http-equiv="Content-Type"	content="text/html; charset=UTF-8" />
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
        
	</head>