package es.gobcan.istac.idxmanager.core.service;

import java.time.Duration;
import java.time.ZonedDateTime;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

import javax.annotation.PreDestroy;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;
import org.siemac.metamac.core.common.conf.ConfigurationService;
import org.siemac.metamac.core.common.exception.MetamacException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import es.gobcan.istac.idxmanager.core.constants.Constantes;
import es.gobcan.istac.idxmanager.domain.mvc.Busqueda;

@Service
public class AuditoriaKafkaServiceImpl implements AuditoriaService {

    protected static final Log LOGGER = LogFactory.getLog(AuditoriaKafkaServiceImpl.class);

    private final ObjectMapper mapper = new ObjectMapper().registerModule(new JavaTimeModule()).disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

    private final KafkaProducer<String, String> producer;

    private final String topic;

    private final ConfigurationService configurationService;

    @Autowired
    public AuditoriaKafkaServiceImpl(ConfigurationService configurationService) throws MetamacException {
        this.configurationService = configurationService;
        this.topic = configurationService.retrieveProperty(Constantes.AUDIT_KAFKA_TOPIC);

        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, configurationService.retrieveProperty(Constantes.AUDIT_KAFKA_BROKERS));
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        props.put(ProducerConfig.ACKS_CONFIG, "1");
        props.put(ProducerConfig.LINGER_MS_CONFIG, "50");
        props.put(ProducerConfig.DELIVERY_TIMEOUT_MS_CONFIG, "10000");
        this.producer = new KafkaProducer<>(props);
    }

    @Override
    public void auditar(Busqueda busquedausuario) {
        if (!isEnabled()) {
            return;
        }

        try {
            Map<String, Object> evento = new LinkedHashMap<>();
            evento.put("time", ZonedDateTime.now().toInstant().toString());
            evento.put("userQuery", busquedausuario.getUserQuery());
            evento.put("searchType", busquedausuario.getSearchType());
            evento.put("filtroTexto", busquedausuario.getFiltroTexto());
            evento.put("filtroTextoQuery", busquedausuario.getFiltroTextoQuery());
            evento.put("filtroSeccion", busquedausuario.getFiltroSeccion());
            evento.put("filtroSeccionArea", busquedausuario.getFiltroSeccionArea());
            evento.put("filtroSeccionOperacion", busquedausuario.getFiltroSeccionOperacion());
            evento.put("startResult", busquedausuario.getStartResult());
            evento.put("pestania", busquedausuario.getPestania());
            evento.put("sort", busquedausuario.getSort());
            evento.put("svyCodFF", busquedausuario.getSvyCodFF());
            evento.put("subCodFF", busquedausuario.getSubCodFF());
            evento.put("cvgTCodFF", busquedausuario.getCvgTCodFF());
            evento.put("cvgSCodFF", busquedausuario.getCvgSCodFF());
            evento.put("formato", busquedausuario.getFormato());
            evento.put("ff_select", busquedausuario.getFf_select());

            String json = mapper.writeValueAsString(evento);

            // Envío asíncrono: no bloquea la búsqueda del usuario aunque Kafka esté caído
            producer.send(new ProducerRecord<>(topic, json), (metadata, ex) -> {
                if (ex != null) {
                    LOGGER.error("Fallo enviando evento de auditoría a Kafka", ex);
                }
            });
        } catch (Exception e) {
            LOGGER.error("Se ha producido una excepción al auditar la búsqueda en Kafka", e);
        }
    }

    @PreDestroy
    public void close() {
        producer.close(Duration.ofSeconds(5));
    }

    private boolean isEnabled() {
        try {
            return configurationService.retrievePropertyBoolean(Constantes.AUDIT_KAFKA_ENABLED);
        } catch (MetamacException e) {
            return true;
        }
    }

}
