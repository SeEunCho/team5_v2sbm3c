package dev.mvc.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.api.ApiProc")
public class ApiProc {
    
    @Autowired
    private ApiDAOInter apiDAO;
    
    /**
     * @return
     */
    public List<ApiVO> getAllRegion() {
        return apiDAO.getAllRegion();
    }
    
    /**
     * 
     * @param regionCode
     * @return
     */
    public ApiVO getOneByRegionCode(String regionCode) {
        return apiDAO.getOneByRegionCode(regionCode);
    };

}
