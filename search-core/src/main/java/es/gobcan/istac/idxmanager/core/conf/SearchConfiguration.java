package es.gobcan.istac.idxmanager.core.conf;

import org.siemac.metamac.core.common.conf.ConfigurationService;
import org.siemac.metamac.core.common.exception.MetamacException;


public interface SearchConfiguration extends ConfigurationService {

    @Override
    String retrieveProperty(String property) throws MetamacException;
}
