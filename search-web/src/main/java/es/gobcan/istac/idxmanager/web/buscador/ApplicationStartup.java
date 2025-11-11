package es.gobcan.istac.idxmanager.web.buscador;

import javax.servlet.ServletContextEvent;

import org.siemac.metamac.core.common.conf.ConfigurationService;
import org.siemac.metamac.core.common.exception.MetamacException;
import org.siemac.metamac.core.common.listener.ApplicationStartupListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;


public class ApplicationStartup extends ApplicationStartupListener {

    private static final Logger log = LoggerFactory.getLogger(ApplicationStartup.class);
    private ConfigurationService configurationService;

    
    public ConfigurationService getConfigurationService() {
        return configurationService;
    }


    
    public void setConfigurationService(ConfigurationService configurationService) {
        this.configurationService = configurationService;
    }


    @Override
    public String projectName() {
        return "statistical-visualizer";
    }


    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            WebApplicationContext root = WebApplicationContextUtils.getRequiredWebApplicationContext(sce.getServletContext());

            setConfigurationService(root.getBean(ConfigurationService.class));
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            // Abort startup application
            throw new RuntimeException(e);
        }
        super.contextInitialized(sce);
    }

    @Override
    public void checkApplicationProperties() throws MetamacException {

    }
}
