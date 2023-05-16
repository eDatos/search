-- --------------------------------------------------------------------------------------------------
-- EDATOS-2234 - [CORE] Comprobar si se puede eliminar el dialecto de las propiedades de BBDD de todas las aplicaciones
-- 
-- Se depreca la propiedad con el valor metamac.access_control.db.dialect
-- --------------------------------------------------------------------------------------------------

update tb_data_configurations set conf_key = 'deprecated.search.db.dialect' where conf_key ='search.db.dialect';
commit;