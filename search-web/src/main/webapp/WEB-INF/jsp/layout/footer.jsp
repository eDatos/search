<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="es.gobcan.istac.idxmanager.web.buscador.util.WebUtils" %>
	<!-- PIE DE PÁGINA -->
    <div id="pie_istac">
      <c:set var="extHeaderUrl" value="<%=WebUtils.getFooter()%>" />
	  <c:catch var="headerErr">
		<c:import url="${extHeaderUrl}" var="rawHeader" charEncoding="UTF-8" />
	  </c:catch>
    </div>

