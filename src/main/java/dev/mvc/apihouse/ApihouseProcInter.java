package dev.mvc.apihouse;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

public interface ApihouseProcInter {
    
    /**
     * 
     * @param apihouseVO
     * @return
     */
    public int insert(ApihouseVO apihouseVO);
    
    /**
     * 
     * @param map
     * @return
     */
    public List<ApihouseVO> gethousesByUserInput (HashMap<Object, Object> map);
    
    
    /**
     * 
     * @param houseno
     * @return pk에 해당하는 주택정보 1건
     */
    public ApihouseVO getHouseByPk(int houseno);

}
