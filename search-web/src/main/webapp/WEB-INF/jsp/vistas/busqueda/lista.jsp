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
	<c:param name="metakeywords" value="Buscador"></c:param>
	<c:param name="metadescription" value="Instituto Canario de Estadística"></c:param>
</c:import>

  <body>
    <div id="contenido">
    	<c:import url="/WEB-INF/jsp/layout/cabecera.jsp"></c:import> 
    	
    	<!-- MIGAS DE PAN-->
		<div id="migas">
			<p class="txt"><fmt:message key="migas.general.estaen" />:</p>		
			<ul>
				<li><strong><fmt:message key="pagina.busqueda.busqueda" /></strong></li>
			</ul>
			<div class="redes_sociales">
			<fmt:message key="pagina.busqueda.redes_sociales.rss" var="rssTitle"/>
				<fmt:message key="pagina.busqueda.redes_sociales.twitter" var="twitterTitle"/>
				<fmt:message key="pagina.busqueda.redes_sociales.istac" var="istacTitle"/>
				<fmt:message key="pagina.busqueda.redes_sociales.istacYoutube" var="istacYoutubeTitle"/>
				<fmt:message key="pagina.busqueda.redes_sociales.istacTableau" var="istacTableauTitle"/>
				<a href="http://www.gobiernodecanarias.org/istac/herramientas/rss.html" accesskey="r" title="${rssTitle}">
					<img src="theme/images/icons/rss_20x20.png" title="${rssTitle}" alt="Canales RSS (tecla de acceso: r)">
				</a>
				<a href="http://www.gobiernodecanarias.org/istac/twitter" accesskey="t" title="${twitterTitle}">
					<img src="theme/images/icons/twitter_20x20.png" title="${twitterTitle}" alt="Seguir a istac_es en Twitter (tecla de acceso: t)">
				</a>
				<a href="https://www.slideshare.net/ISTAC" accesskey="s" title="${istacTitle}">
					<img src="theme/images/icons/Slideshare_20x20.png" title="${istacTitle}" alt="Seguir a ISTAC en Slideshare (tecla de acceso: s)">
				</a>
				<a href="https://www.youtube.com/user/istacES" accesskey="y" title="${istacYoutubeTitle}">
					<img src="theme/images/icons/youtube_20x20.png" title="${istacYoutubeTitle}" alt="Seguir a ISTAC en Youtube (tecla de acceso: y)">
				</a>
				<a href="https://public.tableau.com/profile/istac#!/" accesskey="s" title="${istacTableauTitle}">
					<img src="theme/images/icons/tableau_20.png" title="${istacTableauTitle}" alt="Seguir a ISTAC en Tableau (tecla de acceso: u)">
				</a>
			</div>
		</div>
        
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
                        <span class="entreSel"></span>
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
    					<span class="entreSel"></span>
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
        					<span class="entreSel"></span>
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
    				  
    				  <div class="conten">
                        <div style="float:right">
                            <span class="istac-bs input-group-btn">
                              <button id="btnExpandInfo" type="button" class="btn-link"><i id="iExpandInfo" class="glyphicon glyphicon-eye-close"></i>
                                <span><fmt:message key="pagina.busqueda.menos_detalle" /></span><span style="display: none"><fmt:message key="pagina.busqueda.mas_detalle" /></span>
                              </button>
                            </span>
                        </div>
    					  <%@ include file="/WEB-INF/jsp/vistas/busqueda/ordenacion.jsp" %>
    		 			  <%@ include file="/WEB-INF/jsp/vistas/busqueda/paginacion.jsp" %>
    		 			  
    		 			  <c:forEach var="item" items="${suggestedDocumentList}">
    		              		<%@ include file="/WEB-INF/jsp/vistas/busqueda/item_suggested.jsp" %>
    		              </c:forEach>
    		
    		              <c:forEach var="item" items="${documentList}" begin="0" end="${resultByPage}">
    		              		<c:if test="${item['origen_recurso'] eq 'GPE'}">
    		              			<%@ include file="/WEB-INF/jsp/vistas/busqueda/item_gpe.jsp" %>
    		              		</c:if>
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
