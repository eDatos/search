package es.gobcan.istac.idxmanager.core.constants;

public class Constantes {

    public static final String BUSCADOR_DATA_URL   = "search.data.path";
    public static final String SEARCH_API_KEY      = "search.web.api_key";

    // If the AUDIT properties  is not defined in the database, auditing is assumed to be enabled (defaults to true).
    public static final String AUDIT_FILE_ENABLED  = "search.audit.file.enabled";
    public static final String AUDIT_KAFKA_ENABLED = "search.audit.kafka.enabled";

    public static final String AUDIT_KAFKA_TOPIC = "SEARCH_AUDIT_QUERIES";
}
