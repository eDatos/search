-- --------------------------------------------------------------------------------------------------
-- EDATOS-3520 - Modificar el buscador para adaptarlo al entorno IESTADIS
-- 
-- Se añade la propiedad para la api-key
-- --------------------------------------------------------------------------------------------------

INSERT INTO tb_data_configurations
(id, conf_key, conf_value, system_property, externally_published, update_date_tz, update_date, created_date_tz, created_date, created_by, last_updated_tz, last_updated, last_updated_by, "version")
VALUES(GET_NEXT_SEQUENCE_VALUE('DATA_CONFIGURATIONS'), 'search.web.api_key', 'FILL_ME', true, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

UPDATE TB_SEQUENCES SET SEQUENCE_NEXT_VALUE = SEQUENCE_NEXT_VALUE + 1 WHERE SEQUENCE_NAME = 'DATA_CONFIGURATIONS';

--este valor debería de coincidir con el valor de la propiedad del environment.xml con nombre istac.idxmanager.buscador.data.url en la siguiente ruta: config-deploy\WEB-INF\classes\buscador

INSERT INTO tb_data_configurations
(id, conf_key, conf_value, system_property, externally_published, update_date_tz, update_date, created_date_tz, created_date, created_by, last_updated_tz, last_updated, last_updated_by, "version")
VALUES(GET_NEXT_SEQUENCE_VALUE('DATA_CONFIGURATIONS'), 'search.data.path', 'FILL_ME', true, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

UPDATE TB_SEQUENCES SET SEQUENCE_NEXT_VALUE = SEQUENCE_NEXT_VALUE + 1 WHERE SEQUENCE_NAME = 'DATA_CONFIGURATIONS';
commit;