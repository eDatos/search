###
# Dockerfile usado para consutruir la imagen del search
#
# Antes de construir la imagen debemos haber compilado previamente el proyecto (desde el directorio raíz):
#
# mvn clean package
#
# A continuación podremos construir la imagen ejecutando siempre desde el directorio raíz del proyecto:
#
# docker build -f dockerfiles/Dockerfile -t search:<version> .
#
# Para ejecutar un contenedor asociado a esta imagen:
# docker run -i --rm -p 8080:8080 search:<version>
#
# Para ejecutar con opciones de debug habilitadas:
# docker run -i --rm \
# -e JAVA_OPTS="-agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n" \
# -p 8080:8080 \
# -p 5005:5005 \
# search:<version>
###

FROM tomcat:9.0.98-jdk8
LABEL MAINTAINER=info@arte-consultores.com

RUN mkdir -p /data/edatos/search/conf

COPY dockerfiles/conf /data/edatos/search/conf
COPY search-web/target/*.war /usr/local/tomcat/webapps/search.war

ENV LANG='es_ES.UTF-8'
ENV SEARCHCONF_PATH='file:/data/edatos/search/metamac/environment.xml'

RUN env

CMD ["catalina.sh", "run"]