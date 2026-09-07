/*
 * Carga en el navegador la cabecera y el pie externos (complementos-apps).
 *
 * Antes los descargaba el servidor con <c:import> en cada render, y eran tres
 * peticiones a complementos-apps por pagina: la cabecera se pedia dos veces
 * —una de ellas a una variable que nadie imprimia— y el pie una, tambien sin
 * imprimirse. Con los crawlers barriendo el catalogo eso son cientos de miles
 * de peticiones diarias, asi que la descarga se mueve aqui: los bots no
 * ejecutan JavaScript.
 *
 * Las dos URLs se construyen en servidor (ver layout/cabecera.jsp y
 * layout/footer.jsp) y viajan en el data-edatos-html-url del contenedor, de
 * forma que el navegador no tiene que resolver ninguna propiedad del gestor de
 * metadatos.
 *
 * La contrapartida es que sin JavaScript no hay cabecera ni pie. El uso de
 * fetch no anade ninguna restriccion nueva de navegador: el propio HTML que
 * sirve complementos-apps ya usa URLSearchParams y arrow functions.
 */
(function () {
    'use strict';

    var CONTAINER_SELECTOR = '[data-edatos-html-url]';

    function ready(callback) {
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', callback);
        } else {
            callback();
        }
    }

    /*
     * innerHTML inserta los <script> sin ejecutarlos, asi que hay que reponer
     * cada uno por una copia nueva. La cabecera trae varios (selector de
     * idioma, menu de aplicaciones, gestion de usuario, analitica) y sin esto
     * se ve pero esta muerta. async = false conserva el orden de ejecucion.
     */
    function reinsertScripts(element) {
        Array.prototype.slice
            .call(element.getElementsByTagName('script'))
            .forEach(function (script) {
                var copy = document.createElement('script');
                Array.prototype.forEach.call(script.attributes, function (attribute) {
                    copy.setAttribute(attribute.name, attribute.value);
                });
                copy.text = script.text;
                copy.async = false;
                script.parentNode.replaceChild(copy, script);
            });
    }

    /*
     * Revela la pagina. El CSS la mantiene oculta hasta aqui para que no se
     * complete en dos tiempos, asi que esto tiene que ejecutarse pase lo que
     * pase: si no, no hay pagina. Ver la reja de seguridad en
     * theme/css/search-overrides.css y el <noscript> de layout/head.jsp.
     */
    function mostrarPagina() {
        if (document.body) {
            document.body.classList.add('edatos-listo');
        }
    }

    function load(container) {
        var url = container.getAttribute('data-edatos-html-url');

        // credentials: 'omit' mantiene la paridad con la descarga en servidor,
        // que tampoco enviaba las cookies del usuario.
        return fetch(url, {credentials: 'omit'})
            .then(function (response) {
                if (!response.ok) {
                    throw new Error(url + ': HTTP ' + response.status);
                }
                return response.text();
            })
            .then(function (html) {
                container.innerHTML = html;
                reinsertScripts(container);
            })
            .catch(function (error) {
                console.error('No se ha podido cargar ' + container.id, error);
            });
    }

    ready(function () {
        var cargas = Array.prototype.map.call(
            document.querySelectorAll(CONTAINER_SELECTOR), load);

        // El finally va aqui y no dentro de load() a proposito: revelar cuando
        // termina *cada* contenedor mostraria la pagina en cuanto acabase el
        // primero, y sobre todo no se ejecutaria nunca si no hay contenedores
        // —la propiedad de la URL sin resolver—, dejando la pagina oculta hasta
        // que saltase la reja de los 3s. Con Promise.all, una lista vacia
        // resuelve de inmediato y la pagina se revela sin esperar.
        // load() captura sus propios errores, asi que aqui no rechaza nada.
        Promise.all(cargas).finally(mostrarPagina);
    });
})();
