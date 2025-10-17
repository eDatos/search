-- --------------------------------------------------------------------------------------------------
-- EDATOS-3520 - Modificar el buscador para adaptarlo al entorno IESTADIS
-- 
-- Se añade la propiedad para la api-key
-- --------------------------------------------------------------------------------------------------

INSERT INTO tb_data_configurations
(id, conf_key, conf_value, system_property, externally_published, update_date_tz, update_date, created_date_tz, created_date, created_by, last_updated_tz, last_updated, last_updated_by, "version")
VALUES(GET_NEXT_SEQUENCE_VALUE('DATA_CONFIGURATIONS'), 'search.web.api_key', 'YVbK5dZcsXrKazTGemhAFVM5VPLP8RSgA0E5KgKDFvdOr5soGeywD3dmvowPJk0V', true, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

UPDATE TB_SEQUENCES SET SEQUENCE_NEXT_VALUE = SEQUENCE_NEXT_VALUE + 1 WHERE SEQUENCE_NAME = 'DATA_CONFIGURATIONS';

commit;

INSERT INTO tb_data_configurations
(id, conf_key, conf_value, system_property, externally_published, update_date_tz, update_date, created_date_tz, created_date, created_by, last_updated_tz, last_updated, last_updated_by, "version")
VALUES(GET_NEXT_SEQUENCE_VALUE('DATA_CONFIGURATIONS'), 'istac.idxmanager.solr.urljaxi', 'http://estadisticas.arte-consultores.com/jaxi-istac', true, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

UPDATE TB_SEQUENCES SET SEQUENCE_NEXT_VALUE = SEQUENCE_NEXT_VALUE + 1 WHERE SEQUENCE_NAME = 'DATA_CONFIGURATIONS';

// TODO: MODIFICAR INSERT PARA RESTO DE ENTORNOS Y REVISAR LA NOMENCLATURA 