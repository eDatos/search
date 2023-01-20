<%@include file="/WEB-INF/jsp/util/taglibs.jsp"%>

<div class="istac-bs">

    <spring:url value="busca" var="formUrl"/>  
    <form:form modelAttribute="busqueda" method="get" action="${fn:escapeXml(formUrl)}" class="form-horizontal" role="form">
        <div class="custom-input-group" id="search-control">
        	<fmt:message key="pagina.busqueda.placeholder.user_query" var="placeHolderUserQuery"/>
            <form:input path="userQuery" type="text" class="form-control" placeholder="${placeHolderUserQuery}" />
            <div class="custom-input-group-btn">
                <div class="btn-group" role="group">
                    <div class="dropdown dropdown-lg">
                        <button id="openAdvanceSearch" type="button" class="btn btn-default dropdown-toggle" aria-expanded="false" style="border-radius: 0px;">
                            <span class="caret"></span>
                        </button>
                        <div id="search-adv" class="dropdown-menu dropdown-menu-right" role="menu">
                            <div class="page-header">
                                <h3 class="resultado_titulo"><fmt:message key="pagina.busqueda.filtros" /></h3>
                            </div>
                            <div class="row">
                                <div class="col-md-5" style="margin-bottom: 3px;">
                                    <form:select class="form-control" path="filtroTexto" items="${filtroTextoMap}" />
                                </div>
                                <div class="col-md-7">
                                	<fmt:message key="pagina.busqueda.filtros.placeholder.texto_query" var="placeHolderTextQuery"/>
                                    <form:input type="text" class="form-control" path="filtroTextoQuery" placeholder="${placeHolderTextQuery}" />
                                </div>
                            </div>                            
                            <div class="row" style="margin-top: 1em; float:right">
                               <button id="advanceSearch" type="submit" class="btn btn-primary"><fmt:message key="pagina.busqueda.buscar" /></button>
                            </div>
                        </div>
                    </div>

                    <button id="normalSearch" class="btn btn-primary" type="submit">
                        <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                    </button>
                </div>
            </div>
        </div>
        <p><form:errors path="userQuery"/></p>
    </form:form>

    <p></p>
</div>
