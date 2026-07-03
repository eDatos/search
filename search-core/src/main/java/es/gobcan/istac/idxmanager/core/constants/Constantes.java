package es.gobcan.istac.idxmanager.core.constants;

public class Constantes {

    public static final String BUSCADOR_DATA_URL                = "search.data.path";
    public static final String SEARCH_API_KEY                   = "search.web.api_key";

    // TODO: Revisar propiedad de kafka broker para indicar la que se usa en el resto de aplicaciones
    public static final String AUDIT_KAFKA_BROKERS               = "search.audit.kafka.brokers";
    // TODO: Revisar si los nombres de los topics se definen como propedad o se indica directamente el nombre
    public static final String AUDIT_KAFKA_TOPIC                 = "search.audit.kafka.topic";

    // Si la propiedad no está definida en el environment.xml del entorno, se asume "true".
    public static final String AUDIT_FILE_ENABLED                = "search.audit.file.enabled";
    public static final String AUDIT_KAFKA_ENABLED               = "search.audit.kafka.enabled";
}
