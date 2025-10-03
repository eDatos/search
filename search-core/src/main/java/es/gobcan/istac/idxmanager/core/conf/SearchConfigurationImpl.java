package es.gobcan.istac.idxmanager.core.conf;

import org.siemac.metamac.core.common.conf.ConfigurationServiceImpl;
import org.siemac.metamac.core.common.exception.MetamacException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SearchConfigurationImpl extends ConfigurationServiceImpl implements SearchConfiguration {

    private static Logger log = LoggerFactory.getLogger(SearchConfigurationImpl.class);

    @Override
    public String retrieveProperty(String property) throws MetamacException {
        return (String) environmentConfigurationProperties.getProperty(property);
    }
}
