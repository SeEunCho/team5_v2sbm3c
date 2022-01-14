package dev.mvc.house;

import java.util.List;

public interface HouseProcInter {

    
    public int create(HouseVO houseVO);
    
    /**
     * 등록 순서별 목록
     */
    public List<HouseVO> list_houseno_asc();
    
    /**
     * 주택 순서별 목록
     */
    public List<HouseVO> list_price_asc();
    
    /**
     * 조회
     */
    public HouseVO read(int houseno);
    
    /**
     * 수정 처리
     */
    public int update(HouseVO houseVO);
    
    /**
     * 삭제 처리
     */
    public int delete(int houseno);

  }