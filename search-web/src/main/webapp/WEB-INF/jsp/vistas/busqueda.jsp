<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@include file="/WEB-INF/jsp/util/taglibs.jsp"%>
<compress:html>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<%@ include file="/WEB-INF/jsp/layout/head.jsp" %>
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
			</div>
		</div>
		
		<div id="bloq_interior">
            <div class="contenido">
                <div id="centercontainer">
                    <div class="conten">
                      <%@ include file="/WEB-INF/jsp/vistas/busqueda/form.jsp" %>
        		    </div>
                </div>
            </div>
		</div>
		
		<%@ include file="/WEB-INF/jsp/layout/footer.jsp" %>
    </div>
  </body>
</html>
</compress:html>