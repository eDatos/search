package es.gobcan.istac.idxmanager.core.service;

import java.time.Duration;
import java.time.ZonedDateTime;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.kafka.clients.producer.Callback;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;
import org.apache.kafka.common.serialization.StringSerializer;
import org.siemac.metamac.core.common.conf.ConfigurationService;
import org.siemac.metamac.core.common.exception.MetamacException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import es.gobcan.istac.idxmanager.core.constants.Constantes;
import es.gobcan.istac.idxmanager.domain.mvc.Busqueda;

@Service
public class AuditoriaKafkaServiceImpl implements AuditoriaService, ApplicationListener<ContextClosedEvent> {

    private static final Log    LOGGER             = LogFactory.getLog(AuditoriaKafkaServiceImpl.class);
    private static final String PRODUCER_CLIENT_ID = "search_audit_producer_1";

    private final ObjectMapper mapper = new ObjectMapper().registerModule(new JavaTimeModule()).disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

    private KafkaProducer<String, String> producer;

    private final ConfigurationService configurationService;

    @Autowired
    public AuditoriaKafkaServiceImpl(ConfigurationService configurationService) {
        this.configurationService = configurationService;
    }

    @Override
    public void auditar(Busqueda busqueda) {
        if (!isEnabled()) {
            return;
        }
        try {
            sendEvento(buildEvento(busqueda));
        } catch (Exception e) {
            LOGGER.error("Se ha producido una excepción al auditar la búsqueda en Kafka", e);
        }
    }

    @Override
    public void onApplicationEvent(ContextClosedEvent event) {
        if (producer != null) {
            producer.close(Duration.ofSeconds(5));
            producer = null;
        }
    }

    private void sendEvento(String json) throws MetamacException {
        getProducer().send(new ProducerRecord<>(Constantes.AUDIT_KAFKA_TOPIC, json), new Callback() {
            @Override
            public void onCompletion(RecordMetadata metadata, Exception exception) {
                if (exception != null) {
                    LOGGER.error("Fallo enviando evento de auditoría a Kafka", exception);
                }
            }
        });
    }

    private String buildEvento(Busqueda busqueda) throws JsonProcessingException {
        Map<String, Object> extra = new LinkedHashMap<>();
        extra.put("userQuery",            busqueda.getUserQuery());
        extra.put("subjectArea",          busqueda.getFiltroSeccionArea());
        extra.put("statisticalOperation", busqueda.getFiltroSeccionOperacion());

        Map<String, Object> app = new LinkedHashMap<>();
        app.put("searchType",       busqueda.getSearchType());
        app.put("filtroTexto",      busqueda.getFiltroTexto());
        app.put("filtroTextoQuery", busqueda.getFiltroTextoQuery());
        app.put("filtroSeccion",    busqueda.getFiltroSeccion());
        app.put("startResult",      busqueda.getStartResult());
        app.put("pestania",         busqueda.getPestania());
        app.put("sort",             busqueda.getSort());
        app.put("svyCodFF",         busqueda.getSvyCodFF());
        app.put("subCodFF",         busqueda.getSubCodFF());
        app.put("cvgTCodFF",        busqueda.getCvgTCodFF());
        app.put("cvgSCodFF",        busqueda.getCvgSCodFF());
        app.put("formato",          busqueda.getFormato());
        app.put("ff_select",        busqueda.getFf_select());

        Map<String, Object> evento = new LinkedHashMap<>();
        evento.put("time",   ZonedDateTime.now().toInstant().toString());
        evento.put("origen", Constantes.AUDIT_ORIGIN);
        evento.put("extra",  extra);
        evento.put("app",    app);
        return mapper.writeValueAsString(evento);
    }

    private KafkaProducer<String, String> getProducer() throws MetamacException {
        if (producer == null) {
            producer = new KafkaProducer<>(getProducerProperties());
        }
        return producer;
    }

    private Properties getProducerProperties() throws MetamacException {
        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG,              configurationService.retrieveKafkaBootStrapServers());
        props.put(ProducerConfig.CLIENT_ID_CONFIG,                      PRODUCER_CLIENT_ID);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG,           StringSerializer.class.getName());
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG,         StringSerializer.class.getName());
        props.put(ProducerConfig.ACKS_CONFIG,                           "all");
        props.put(ProducerConfig.COMPRESSION_TYPE_CONFIG,               "gzip");
        props.put(ProducerConfig.RETRIES_CONFIG,                        10);
        props.put(ProducerConfig.MAX_IN_FLIGHT_REQUESTS_PER_CONNECTION, 1);
        props.put(ProducerConfig.MAX_BLOCK_MS_CONFIG,                   5000L);
        return props;
    }

    private boolean isEnabled() {
        try {
            return configurationService.retrievePropertyBoolean(Constantes.AUDIT_KAFKA_ENABLED);
        } catch (MetamacException e) {
            return true;
        }
    }

}
