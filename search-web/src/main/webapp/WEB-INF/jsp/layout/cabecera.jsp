<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- CABECERA -->

<div id="cabecera">
    <div id="cab_superior">
        <!-- MENU DE AYUDA -->
        <ul>
            <li>
                <a href="https://sede.gobiernodecanarias.org/sede/procedimientos_servicios/tramites?contentTypeId=321b9560-73a9-11df-8da5-bf2cae36f426&titulo=&tema=&departamento=c3254a40-6c07-11e5-8789-faa465ab1552&perfil=&organo=44f44490-6e56-11e5-8789-3a94baacdf31&tipo_tramite=&dirGral=44f44490-6e56-11e5-8789-3a94baacdf31&subtema=&enviado=true" target="" accesskey="d" title="Acceso a los procedimientos del ISTAC en la sede electrónica del Gobierno de Canarias">Sede electrónica</a>
            </li>
            <li>|</li>
            <li>
                <a href="https://www.gobiernodecanarias.org/istac/accesibilidad.html" target="" accesskey="a" title="Declaración de accesibilidad">Accesibilidad</a>
            </li>
            <li>|</li>
            <li>
                <a href="https://www.gobiernodecanarias.org/istac/servicios/atencion.html" accesskey="o" title="Acceso al apartado de atención ciudadana">Contacto</a>
            </li>
        </ul>
    </div>
    
    <!-- IMAGEN ISTAC -->
    <h1>
        <a href="http://www.gobiernodecanarias.org/istac" title="Página principal del Instituto Canario de Estadística (ISTAC) - Opciones de accesibilidad (tecla de acceso: i)" accesskey="i">Instituto Canario de Estadística</a>
    </h1>

    <!-- begin: #menu -->
    <div id="menu_contextual">
        <ul class="menu">
            <li><a href="http://www.gobiernodecanarias.org/istac/temas_estadisticos/" class="select" accesskey="1" title="Estadísticas (tecla de acceso: 1)">Estadísticas</a></li>
            <li><a href="http://www.gobiernodecanarias.org/istac/istac/" class="inactive" accesskey="2" title="El ISTAC (tecla de acceso: 2)">El ISTAC</a></li>
            <li><a href="http://www.gobiernodecanarias.org/istac/noticias/" class="inactive" accesskey="4" title="Noticias (tecla de acceso: 4)">Noticias</a></li>
            <li><a href="http://www.gobiernodecanarias.org/istac/datos-abiertos/" class="inactive" accesskey="5" title="Datos abiertos (tecla de acceso: 5)">Datos abiertos</a></li>
        </ul>
        
        <!-- Búsqueda -->
        <spring:url value="busca" var="formCabeceraUrl"/>  
        <form name="gs" method="GET" action="${fn:escapeXml(formCabeceraUrl)}">
            <div id="formulario_google" style="padding-top: 1px;">
                <input type="text" id="userQuery" name="userQuery" placeholder="texto de búsqueda" class="buscar" value="">
                <input type="submit" name="Buscar" value="Buscar" class="boton">
            </div>
        </form>
    </div>
    <!-- end: #menu -->
</div>