<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@include file="/WEB-INF/jsp/util/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>

<c:import url="/WEB-INF/jsp/layout/head.jsp">
	<c:param name="titulo">
		<fmt:message key="error.pagina.titulo" />
	</c:param>
	<c:param name="metakeywords" value="Error"></c:param>
</c:import>

  <body>
    <div id="contenido">
    	<c:import url="/WEB-INF/jsp/layout/cabecera.jsp"></c:import>

		<div id="bloq_interior">
            <div class="contenido">
                <div id="centercontainer">
                    <div class="conten">
                        <div class="row">
                            <div class="col-md-12 text-center error-page">
                                <h2><fmt:message key="error.pagina.titulo" /></h2>
                                <p><fmt:message key="error.pagina.mensaje" /></p>
                                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                    <fmt:message key="error.pagina.volver" />
                                </a>
                            </div>
                        </div>
        		    </div>
                </div>
            </div>
		</div>

		<%@ include file="/WEB-INF/jsp/layout/footer.jsp" %>
    </div>
  </body>

</html>
