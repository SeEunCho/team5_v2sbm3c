package dev.mvc.house;
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

 
@Component("dev.mvc.house.HouseProc")
public class HouseProc implements HouseProcInter {

  @Autowired 
  private HouseDAOInter houseDAO;

@Override
public int create(HouseVO houseVO) {
    int cnt = houseDAO.create(houseVO);

    return cnt;
}

@Override
public List<HouseVO> list_houseno_asc() {
    List<HouseVO> list = this.houseDAO.list_houseno_asc();
    return list;
}

@Override
public List<HouseVO> list_price_asc() {
    List<HouseVO> list = this.houseDAO.list_price_asc();
    return list;
}

@Override
public HouseVO read(int houseno) {
    HouseVO houseVO = this.houseDAO.read(houseno);
    return houseVO;
}

@Override
public int update(HouseVO houseVO) {
    int cnt = this.houseDAO.update(houseVO);
    return cnt;
}

@Override
public int delete(int houseno) {
    int cnt = this.houseDAO.delete(houseno);
    return cnt;
}
  


}