# UPGRADE - Proceso de actualización entre versiones

*Para actualizar de una versión a otra es suficiente con actualizar el WAR a la última versión. El siguiente listado presenta aquellos cambios de versión en los que no es suficiente con actualizar y que requieren por parte del instalador tener más cosas en cuenta. Si el cambio de versión engloba varios cambios de versión del listado, estos han de ejecutarse en orden de más antiguo a más reciente.*

*De esta forma, si tuviéramos una instalación en una versión **A.B.C** y quisieramos actualizar a una versión posterior **X.Y.Z** para la cual existan versiones anteriores que incluyan cambios listados en este documento, se deberá realizar la actualización pasando por todas estas versiones antes de poder llegar a la versión deseada.*

*EJEMPLO: Queremos actualizar desde la versión 1.0.0 a la 3.0.0 y existe un cambio en la base de datos en la actualización de la versión 1.0.0 a la 2.0.0.*

*Se deberá realizar primero la actualización de la versión 1.0.0 a la 2.0.0 y luego desde la 2.0.0 a la 3.0.0*

## 6.6.0 a 6.6.1-SNAPSHOT
* Es necesario ejecutar el siguiente script SQL, donde se incluye la propiedad del endpoint de auditoría:

```
etc/changes-from-release/6.6.0/db/common-metadata/postgresql/20260930_create_property_endpoint_search_audit.sql
```

## 6.4.3 a 6.5.0
- Se han realizado cambios a la base de datos, por ello se proveen una serie de scripts SQL para adaptarse a la nueva versión.
  Ejecutar los scripts de la siguiente ruta en el esquema correspondiente por orden de fecha: [etc/changes-from-release/6.4.3/db/common-metadata/postgresql/](etc/changes-from-release/6.4.3/db/common-metadata/postgresql)

## 6.3.0 a 6.4.0
- Se han realizado cambios a la base de datos, por ello se proveen una serie de scripts SQL para adaptarse a la nueva versión. 
  Ejecutar los scripts de la siguiente ruta en el esquema correspondiente por orden de fecha: [etc/changes-from-release/6.3.0/db/common-metadata/postgresql/](etc/changes-from-release/6.3.0/db/common-metadata/postgresql)
- Eliminar el fichero buscador.xml localizado en la carpeta conf/estatica dentro del diretorio data de la apliación en cada cliente/entorno
- Modificar el fichero environment.xml del proyecto SISTEMAS para eliminar la propiedad istac.idxmanager.buscador.data.url y añadir las propiedades relativas al configuration service/common-metadata y renombrar la carpeta que tiene como nombre buscador por metamac

## 6.2.2 a 6.3.0
- Se han realizado cambios a la base de datos, por ello se proveen una serie de scripts SQL para adaptarse a la nueva versión. 
  Ejecutar los scripts de la siguiente ruta en el esquema correspondiente por orden de fecha: [etc/changes-from-release/6.2.2/db/common-metadata/postgresql/](etc/changes-from-release/6.2.2/db/common-metadata/postgresql)
- Se ha quitado propiedad "istac.idxmanager.solr.urljaxi" en el proyecto de sistemas. Por lo que hay que quitarla del archivo de propiedades del proyecto. Es una propiedad del GPE del istac por lo que es posible que esté configurada sólo en ISTAC. Atención!!! El fichero a modificar puede que se encuentre externalizado en el data o en el proyecto de sistemas en función de si el cliente tiene la aplicación desplegada en docker

## 5.5.1 a 6.0.1
- Es necesario la actualización de solr a la versión 8.11 previo al despliegue de esta versión. Ver EDATOS-4386

## 5.5.0 a 5.5.1
- Se han realizado cambios a la base de datos, por ello se proveen una serie de scripts SQL para adaptarse a la nueva versión. 
  Ejecutar los scripts de la siguiente ruta en el esquema correspondiente por orden de fecha: [etc/changes-from-release/5.5.0/db/common-metadata/postgresql/](etc/changes-from-release/5.5.0/db/common-metadata/postgresql)

## 5.4.0 a 5.5.0
- Se han realizado cambios a la base de datos, por ello se proveen una serie de scripts SQL para adaptarse a la nueva versión. 
  Ejecutar los scripts de la siguiente ruta en el esquema correspondiente por orden de fecha: [etc/changes-from-release/5.4.0/db/common-metadata/postgresql/](etc/changes-from-release/5.4.0/db/common-metadata/postgresql)

## 0.0.0 a 5.3.1
* El proceso de actualizaciones entre versiones para versiones anteriores a la 5.3.1 está definido en "Metamac - Manual de instalación.doc"
