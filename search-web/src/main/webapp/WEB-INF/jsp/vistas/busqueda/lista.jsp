<%@include file="/WEB-INF/jsp/util/taglibs.jsp"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@page import="es.gobcan.istac.idxmanager.domain.dom.TypeNMDomain" %>
<%@page import="org.apache.solr.common.SolrDocument" %>
<compress:html>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<c:import url="/WEB-INF/jsp/layout/head.jsp">
	<c:param name="titulo">
		<fmt:message key="welcome.title" />
	</c:param>
</c:import>

  <body>
    <div id="contenido">
    	<c:import url="/WEB-INF/jsp/layout/cabecera.jsp"></c:import>
        
		<div id="bloq_interior">
            <div class="contenido">
                <div id="centercontainer">
    	            <div class="conten">
    	              
                      <%@ include file="/WEB-INF/jsp/vistas/busqueda/form.jsp" %>
    	 			  
                      <div class="pestanias">
    	 			    <% 
    	 			        BusquedaWrapper busquedaPestaniaWrapper = new BusquedaWrapper((Busqueda)request.getAttribute("busqueda"));
    	 			        busquedaPestaniaWrapper.getBusqueda().setPestania("ALL");
                        %>
                        <fmt:message key="pagina.busqueda.todo" var="todo"/>
                        <fmt:message key="pagina.busqueda.datos" var="datos" />
                        <fmt:message key="pagina.busqueda.publicaciones" var="publicaciones" />
                        <c:choose>
                            <c:when test="${busqueda.pestania eq 'ALL'}">
                                <span class="pestSel">
                                	<input type="button" class="bt_pst" id="busca_todo" value="${todo}" tabindex="12" accesskey="d" title="Alt+d" onclick="window.location.href='<%=WebUtils.generarUrl("busca", busquedaPestaniaWrapper)%>'; return false;">
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="pest">
                                	<input type="button" class="bt_pst" id="busca_todo" value="${todo}" tabindex="12" accesskey="d" title="Alt+d" onclick="window.location.href='<%=WebUtils.generarUrl("busca", busquedaPestaniaWrapper)%>'; return false;"></input>
                                </span>
                            </c:otherwise>
                        </c:choose>
                        <% 
                            busquedaPestaniaWrapper.getBusqueda().setPestania("DSC");
                        %>
    					<c:choose>
    						<c:when test="${busqueda.pestania eq 'DSC'}">
    							<span class="pestSel">
    								<input type="button" class="bt_pst" id="busca_datos" value="${datos}" tabindex="12" accesskey="d" title="Alt+d" onclick="window.location.href='<%=WebUtils.generarUrl("busca", busquedaPestaniaWrapper)%>'; return false;"></input>
    			 			  	</span>
    						</c:when>
    						<c:otherwise>
    							<span class="pest">
    								<input type="button" class="bt_pst" id="busca_datos" value="${datos}" tabindex="12" accesskey="d" title="Alt+d" onclick="window.location.href='<%=WebUtils.generarUrl("busca", busquedaPestaniaWrapper)%>'; return false;"></input>
    			 			  	</span>
    						</c:otherwise>
    					</c:choose>
                        <% 
                            busquedaPestaniaWrapper.getBusqueda().setPestania("DSP");
                        %>
    					<c:choose>
    						<c:when test="${busqueda.pestania eq 'DSP'}">
    							<span class="pestSel">
    								<input type="button" class="bt_pst" id="busca_publicaciones" value="${publicaciones}" tabindex="12" accesskey="d" title="Alt+d" onclick="window.location.href='<%=WebUtils.generarUrl("busca", busquedaPestaniaWrapper)%>'; return false;"></input>
    			 			  	</span>
    						</c:when>
    						<c:otherwise>
    							<span class="pest">
    								<input type="button" class="bt_pst" id="busca_publicaciones" value="${publicaciones}" tabindex="12" accesskey="d" title="Alt+d" onclick="window.location.href='<%=WebUtils.generarUrl("busca", busquedaPestaniaWrapper)%>'; return false;"></input>
    			 			  	</span>
    						</c:otherwise>
    					</c:choose>
                        <c:if test="${1 < 0}">
                        	<fmt:message key="pagina.busqueda.complementaria" var="complementaria" />
                            <% 
                                busquedaPestaniaWrapper.getBusqueda().setPestania("COMP"); //poner pestania de complementari
                            %>
        					<c:choose>
        						<c:when test="${busqueda.pestania eq 'COMP'}">
        							<span class="pestSel">
        			 			  		<input type="button" class="bt_pst" id="busca_complementaria" value="${complementaria}" tabindex="12" accesskey="d" title="Alt+d" onclick="window.location.href='<%=WebUtils.generarUrl("busca", busquedaPestaniaWrapper)%>'; return false;"></input>
        			 			  	</span>
        						</c:when>
        						<c:otherwise>
        							<span class="pest">
        			 			  		<input type="button" class="bt_pst" id="busca_complementaria" value="${complementaria}" tabindex="12" accesskey="d" title="Alt+d" onclick="window.location.href='<%=WebUtils.generarUrl("busca", busquedaPestaniaWrapper)%>'; return false;"></input>
        			 			  	</span>
        						</c:otherwise>
        					</c:choose>
                        </c:if>
    	              </div>
    				  
    				  <div class="conten_result">
    				  <div class="cabecera_div">
                        <div style="float:right;padding-top:20px">
                            <span class="istac-bs input-group-btn">
                              <button id="btnExpandInfo" type="button" class="btn-link"><i id="iExpandInfo" class="glyphicon glyphicon-eye-close"></i>
                                <span><fmt:message key="pagina.busqueda.menos_detalle" /></span><span style="display: none"><fmt:message key="pagina.busqueda.mas_detalle" /></span>
                              </button>
                            </span>
                        </div>
    					<%@ include file="/WEB-INF/jsp/vistas/busqueda/ordenacion.jsp" %>
    					</div>
    		 			  <%@ include file="/WEB-INF/jsp/vistas/busqueda/paginacion.jsp" %>
    		 			  
    		 			  <c:forEach var="item" items="${suggestedDocumentList}">
    		              		<%@ include file="/WEB-INF/jsp/vistas/busqueda/item_suggested.jsp" %>
    		              </c:forEach>
    		
    		              <c:forEach var="item" items="${documentList}" begin="0" end="${resultByPage}">
    		              		<c:if test="${item['origen_recurso'] eq 'WEB'}">
    		              			<%@ include file="/WEB-INF/jsp/vistas/busqueda/item_web.jsp" %>
    		              		</c:if>
                                <c:if test="${item['origen_recurso'] eq 'MTM_STAT_RESOURCES'}">
                                    <%@ include file="/WEB-INF/jsp/vistas/busqueda/item_metamac.jsp" %>
                                </c:if>
    		              </c:forEach>
    					  <%@ include file="/WEB-INF/jsp/vistas/busqueda/paginacion.jsp" %>
    				 
    				  </div>
                      
    			    </div>
                </div>
            </div>
		</div>
		<%@ include file="/WEB-INF/jsp/layout/footer.jsp" %>
    </div>	
  </body>
</html>
</compress:html>
