package dev.mvc.apihouse;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.api.ApiDAOInter;

@Component("dev.mvc.apihouse.ApihouseProc")
public class ApihouseProc implements ApihouseProcInter {
    
    @Autowired
    private ApihouseDAOInter apihouseDAO;

    @Override
    public int insert(ApihouseVO apihouseVO) {
        return apihouseDAO.insert(apihouseVO);
    }

    @Override
    public List<ApihouseVO> gethousesByUserInput(HashMap<Object, Object> map) {
        return apihouseDAO.gethousesByUserInput(map);
    }

    @Override
    public ApihouseVO getHouseByPk(int houseno) {
        return apihouseDAO.getHouseByPk(houseno);
    }
    
    

}
