-- --------------------------------------------------------------------------------------------------
-- EDATOS-5791 - Implementar la auditoría como una tabla en base de datos
--
-- Se añaden las propiedades para activar/desactivar la auditoría CSV y Kafka de forma independiente.
-- Si la propiedad no existe en BD, el código asume 'true' (auditoría habilitada por defecto).
-- Para deshabilitar en un entorno concreto, hacer UPDATE a 'false'.
--
-- NOTA: metamac.kafka.bootstrap_server ya existe en la BD global (common-metadata), no se inserta aquí.
-- --------------------------------------------------------------------------------------------------

INSERT INTO tb_data_configurations
(id, conf_key, conf_value, system_property, externally_published, update_date_tz, update_date, created_date_tz, created_date, created_by, last_updated_tz, last_updated, last_updated_by, "version")
VALUES(GET_NEXT_SEQUENCE_VALUE('DATA_CONFIGURATIONS'), 'search.audit.file.enabled', 'true', true, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

UPDATE TB_SEQUENCES SET SEQUENCE_NEXT_VALUE = SEQUENCE_NEXT_VALUE + 1 WHERE SEQUENCE_NAME = 'DATA_CONFIGURATIONS';

INSERT INTO tb_data_configurations
(id, conf_key, conf_value, system_property, externally_published, update_date_tz, update_date, created_date_tz, created_date, created_by, last_updated_tz, last_updated, last_updated_by, "version")
VALUES(GET_NEXT_SEQUENCE_VALUE('DATA_CONFIGURATIONS'), 'search.audit.kafka.enabled', 'true', true, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

UPDATE TB_SEQUENCES SET SEQUENCE_NEXT_VALUE = SEQUENCE_NEXT_VALUE + 1 WHERE SEQUENCE_NAME = 'DATA_CONFIGURATIONS';

commit;
