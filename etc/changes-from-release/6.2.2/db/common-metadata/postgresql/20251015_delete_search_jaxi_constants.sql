-- --------------------------------------------------------------------------------------------------
-- EDATOS-4862 - Eliminar lógica asociada al GPE en las aplicaciones del buscador
-- 
-- Se elimina la propiedad con clave istac.idxmanager.solr.urljaxi
-- --------------------------------------------------------------------------------------------------

delete from tb_data_configurations where conf_key = 'istac.idxmanager.solr.urljaxi';
commit;