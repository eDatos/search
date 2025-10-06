package es.gobcan.istac.idxmanager.web.buscador;

import javax.servlet.ServletContextEvent;

import org.siemac.metamac.core.common.exception.MetamacException;
import org.siemac.metamac.core.common.listener.ApplicationStartupListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import es.gobcan.istac.idxmanager.core.conf.SearchConfiguration;

public class ApplicationStartup extends ApplicationStartupListener {

    private static final Logger log = LoggerFactory.getLogger(ApplicationStartup.class);

    @Override
    public String projectName() {
        return "statistical-visualizer";
    }

    private SearchConfiguration searchConfigurationService;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        
//        ServletContext sc = sce.getServletContext();
//
//        String servletName = "Spring MVC Dispatcher Servlet"; // EXACTO como en <servlet-name>
//        String key = org.springframework.web.servlet.FrameworkServlet.SERVLET_CONTEXT_PREFIX + servletName;
//        ApplicationContext ctx = (ApplicationContext) sc.getAttribute(key);
//        if (ctx == null) {
//            throw new IllegalStateException("No WebApplicationContext for DispatcherServlet: " + servletName);
//        }
//
//        // Ya puedes pedir tu bean
//        SearchConfiguration conf = ctx.getBean(SearchConfiguration.class);
        try {
            WebApplicationContext root =
                    WebApplicationContextUtils.getRequiredWebApplicationContext(sce.getServletContext());

                searchConfigurationService = root.getBean(SearchConfiguration.class);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            // Abort startup application
            throw new RuntimeException(e);
        }
        super.contextInitialized(sce);

        // 
    }

    
    @Override
    public void checkApplicationProperties() throws MetamacException {
    
    }

}
