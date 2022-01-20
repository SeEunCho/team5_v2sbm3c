package dev.mvc.api;

import java.util.List;

public interface ApiDAOInter {
    
    /**
     * 
     * @return
     */
    public List<ApiVO> getAllRegion();

    /**
     * 
     * @param regionCode
     * @return
     */
    public ApiVO getOneByRegionCode(String regionCode);
}
