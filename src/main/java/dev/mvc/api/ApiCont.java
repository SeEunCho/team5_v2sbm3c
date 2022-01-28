package dev.mvc.api;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.fasterxml.jackson.databind.ObjectMapper;

import dev.mvc.apihouse.ApihouseProcInter;
import dev.mvc.apihouse.ApihouseVO;


@Controller
public class ApiCont {
    
    @Autowired
    @Qualifier("dev.mvc.api.ApiProc")
    private ApiProc apiProc;
    
    @Autowired
    @Qualifier("dev.mvc.apihouse.ApihouseProc")
    private ApihouseProcInter apihouseProc;
    
    private static final String WEB_DRIVER_ID = "webdriver.chrome.driver"; //드라이버 ID
    private static final String WEB_DRIVER_PATH = "C:/kd1/ws_java/team5_v2sbm3c/chromedriver.exe"; //드라이버 경로
    

    /**
     * 
     * @param model
     * @return kakao맵 담긴 view 페이지 + 서울시 '구' data list  리턴
     */
    @RequestMapping(value = "/api/call.do", method = RequestMethod.GET)
    public String getApi(Model model) {
        
        List<ApiVO> list = null;
        list = apiProc.getAllRegion();
        
        if(list == null) {
            System.out.println("값이 들어오지 않습니다 APIVo LIST");
        } else {
            model.addAttribute("list", list);
        }
        // "houseinfo/getinfo";
        return "houseinfo/getinfo";
    }
    
    // List에서 하나 클릭시에 상세조회 할 수 있는 컨트롤러
    @RequestMapping(value = "/api/{houseno}/read.do", method = RequestMethod.GET)
    public String readOne(@PathVariable String houseno, Model model) {
        
        int pk = Integer.parseInt(houseno);
        
        ApihouseVO apihouseVO = null;
        apihouseVO = apihouseProc.getHouseByPk(pk);

        if(apihouseVO == null) {
            System.out.println("객체 조회가 되지 않습니다.");
        }

        model.addAttribute("apihouseVO", apihouseVO);

        return "houseinfo/readApiHouse";
    }
    
    
    // 마커 에서 하나 클릭시에 상세조회 할 수 있는 컨트롤러
    @ResponseBody
    @RequestMapping(value = "/api/{houseno}/read_marker.do", method = RequestMethod.GET)
    public String readOneForMarker(@PathVariable String houseno, Model model) {
        
        int pk = Integer.parseInt(houseno);
        
        JSONObject json = new JSONObject();
        ApihouseVO apihouseVO = null;
        apihouseVO = apihouseProc.getHouseByPk(pk);
        String nUrl = null;
        nUrl = url_return(apihouseVO.getName());
        System.out.println(nUrl);
        if(apihouseVO == null) {
            System.out.println("객체 조회가 되지 않습니다.");
        }
        
        if (nUrl == null) {
            System.out.println("링크 조회가 되지 않습니다.");
        }
        
        json.put("nUrl", nUrl);

        return json.toString();
    }
    
    // 사용자 입력값에 대해 데이터베이스에 검색하여 관련 데이터 전달하는 컨트롤러 
    // 사용자가 map으로 볼 때 해당 컨트롤러가 작동.
    @RequestMapping(value = "/api/call.do", method = RequestMethod.POST)
    public String getApiProc(String regionCode, String year, String month, Model model) {
         
        System.out.println("api/call.do 호출됨");
        ApiVO apiVO = null;
        List<ApiVO> list = null;
        List<ApihouseVO> houseList = null;
        HashMap<Object, Object> map = new HashMap<Object, Object>();
        ObjectMapper mapper = new ObjectMapper();
        
        // 사용자 입력을 DB 쿼리를 위해 맵에 저장
        map.put("rcode", Integer.parseInt(regionCode));
        map.put("year", Integer.parseInt(year));
        map.put("month", Integer.parseInt(month));
        
        // 지역코드 + 이름 객체 (1st), form에 넘길 apiVO list (2nd), DB에서 가져온 공공데이터포털 거래정보(3rd)
        list = apiProc.getAllRegion();
        apiVO = apiProc.getOneByRegionCode(regionCode);
        houseList = apihouseProc.gethousesByUserInput(map);
        
        //여기서 지희님이 보내주신 함수로, 반복문 돌려서 링크 만들어진 부분으로 보내보기.
        
        System.out.println();
        
        if (apiVO == null) {
            System.out.println("값이 들어오지 않습니다 ApiVO");
        }
        
        if(list == null) {
            System.out.println("값이 들어오지 않습니다 APIVo LIST");
        } 
        
        if (houseList ==  null) {
            System.out.println("값이 들어오지 않습니다 ApihouseVO LIST");
        }      

        try {
            // jackson library 사용하여 java Object(List<ApihouseVO> houseList) -> json format(String.class) parsing 
            String jsonFromObj = mapper.writeValueAsString(houseList);
            model.addAttribute("jsonlist", jsonFromObj);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        model.addAttribute("singleApiVO", apiVO);
        model.addAttribute("year", year);
        model.addAttribute("month", month);
        model.addAttribute("list", list);
        model.addAttribute("length", houseList.size());
        
        return "houseinfo/postinfo";
    }
    
    // 사용자가 List로 볼 때 해당 컨트롤러가 작동.
    // 컨트롤러 로직은 getApiProc 와 동일. view 경로만 다름!
    @RequestMapping(value = "/api/call_list.do", method = RequestMethod.GET)
    public String getApiProc_List(String regionCode, String year, String month, Model model) {
         
        System.out.println("api/call.do 호출됨");
        ApiVO apiVO = null;
        List<ApiVO> list = null;
        List<ApihouseVO> houseList = null;
        HashMap<Object, Object> map = new HashMap<Object, Object>();
        
        // 사용자 입력을 DB 쿼리를 위해 맵에 저장
        map.put("rcode", Integer.parseInt(regionCode));
        map.put("year", Integer.parseInt(year));
        map.put("month", Integer.parseInt(month));
        
        // 지역코드 + 이름 객체 (1st), form에 넘길 apiVO list (2nd), DB에서 가져온 공공데이터포털 거래정보(3rd)
        list = apiProc.getAllRegion();
        apiVO = apiProc.getOneByRegionCode(regionCode);
        houseList = apihouseProc.gethousesByUserInput(map);
        
        System.out.println();
        
        if (apiVO == null) {
            System.out.println("값이 들어오지 않습니다 ApiVO");
        }
        
        if(list == null) {
            System.out.println("값이 들어오지 않습니다 APIVo LIST");
        } 
        
        if (houseList ==  null) {
            System.out.println("값이 들어오지 않습니다 ApihouseVO LIST");
        }      
        
        model.addAttribute("singleApiVO", apiVO);
        model.addAttribute("year", year);
        model.addAttribute("month", month);
        model.addAttribute("list", list);
        model.addAttribute("length", houseList.size());
        model.addAttribute("houseList", houseList);
        
        return "houseinfo/postinfolist";
    }
    
    
    
    
    // 해당 컨트롤러를 db 저장용 open api 통신 컨트롤러로 구현함.
    // 관리자가 form에서 '구' + 거래일자 선택하여 submit 하면, OpenApi통신 및 결과 DB에 저장.
    @RequestMapping(value = "/api/call_do", method = RequestMethod.POST)
    public String fowrdToGet(String regionCode, String year, String month, Model model) {
         
        System.out.println("호출됨");
        ApiVO apiVO = null;
        List<ApiVO> list = null;
        String date = year + month;
        System.out.println(regionCode + date);
        list = apiProc.getAllRegion();
        apiVO = apiProc.getOneByRegionCode(regionCode);
        
        if (apiVO == null) {
            System.out.println("값이 들어오지 않습니다 ApiVO");
        }
        
        if(list == null) {
            System.out.println("값이 들어오지 않습니다 APIVo LIST");
        } 
        
        model.addAttribute("singleApiVO", apiVO);
        model.addAttribute("year", year);
        model.addAttribute("month", month);
        model.addAttribute("list", list);
        
        try {
            String url = getOpenApiUrl(regionCode, date);
            String jsonlist = parseDocument(url, model);
            model.addAttribute("jsonlist", jsonlist);
        } catch (Exception e) {
           e.printStackTrace();
           System.out.println("개발자는 예외처리하세요.");
        }         
        
        return "houseinfo/postinfo3";
    }
    
    
    
    
    
    
    //  ============ 내부 구현 methods (below)
    
    
    private String url_return(String apt_name) {
        //드라이버 설정
        try {
            System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        //크롬 설정을 담은 객체 생성
        ChromeOptions options = new ChromeOptions();
        
        //브라우저 내부적으로 동작
        options.addArguments("headless");
        
        WebDriver driver = new ChromeDriver(options);

        String url = "https://m.land.naver.com/search";
        driver.get(url);
        
        //브라우저 이동시 생기는 로드시간 대기
        //HTTP응답속도보다 자바의 컴파일 속도가 더 빠르기 때문에 임의적으로 1초를 대기
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {}
         
        WebElement search = driver.findElement(By.id("query"));
        search.sendKeys(apt_name);
        search.sendKeys(Keys.ENTER);
        url = driver.getCurrentUrl();
                
        try {
            //드라이버가 null이 아니라면
            if(driver != null) {
                //드라이버 연결 종료
                driver.close(); //드라이버 연결 해제
                
                //프로세스 종료
                //driver.quit();
            }
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
        
        return url;
    }
       
    private String getOpenApiUrl(String regionCode, String date) throws Exception {
        
        StringBuilder urlBuilder = new StringBuilder("http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev"); /*URL*/
        
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=2P4vHr1EqNHZQmmf7LsLCZ%2BgTxFBRst68xrJfk7hIAgCY6BHjDOEJkOQ45xWIAgndYBTIuiAZwyFMROd3vCPJQ%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("50", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("LAWD_CD","UTF-8") + "=" + URLEncoder.encode(regionCode, "UTF-8")); /*지역코드*/
        urlBuilder.append("&" + URLEncoder.encode("DEAL_YMD","UTF-8") + "=" + URLEncoder.encode(date, "UTF-8")); /*계약월*/
        
        return urlBuilder.toString();
        
    }
    
    
 
    // jSON 객체 LIST 를 tostring 함수로 문자열 화 하여 리턴하는 함수, 컨트롤러의 Model 객체에 담김
    private String parseDocument(String url, Model model) throws Exception {
        
        List<JSONObject>json = new ArrayList<JSONObject>();
        
        // 팩토리 메소드 호출.
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document document = db.parse(url);
        
        // 문자열 형태의 xml을 객체화
        document.getDocumentElement().normalize(); 

        // 결과 리스트가 되는 item tag 부분 빼내기.
        NodeList nList = document.getElementsByTagName("item");
        
        // root Tag 확인.
        //System.out.println("Root Element : " + document.getDocumentElement().getNodeName());
        
        
        // xml -> json 변환 작업 
        for(int i = 0; i < nList.getLength(); i++ ) {
            
            Node nNode = nList.item(i);
            JSONObject tempJson = new JSONObject();
            
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                
                Element el = (Element) nNode;
                StringBuilder fullAddress = new StringBuilder();// 원하는 데이터로 가공하기.
                StringBuilder partAddress = new StringBuilder();
                
                //OO동 OOOO길 OO 아파트 (for Geocoding)
                fullAddress.append(getTagValue("법정동", el) + " " + getTagValue("도로명", el) + " " + getTagValue("아파트", el));
                
                //OO동 OO아파트
                partAddress.append(getTagValue("법정동", el) + " " + getTagValue("아파트", el));
                
                tempJson.put("fullAddr", fullAddress.toString());
                tempJson.put("name", partAddress.toString());
                tempJson.put("cyear", getTagValue("건축년도", el));
                tempJson.put("amount", getTagValue("거래금액", el));
                tempJson.put("area", getTagValue("전용면적", el));
                tempJson.put("rcode", getTagValue("지역코드", el));
                tempJson.put("year", getTagValue("년", el));
                tempJson.put("month", getTagValue("월", el));
                

            }          
            json.add(tempJson);
        }         
        model.addAttribute("length", json.size());
        return json.toString();
    }
    
    
    //xml 객체에서 tag 이름으로 value 얻어오는 사용자 정의 메소드
    private String getTagValue(String tag, Element element) {
        
        NodeList nList = element.getElementsByTagName(tag).item(0).getChildNodes();
                
        Node node = (Node) nList.item(0);
        if (node == null) {
            return null;
        }
        
        return node.getNodeValue();
    }

}
