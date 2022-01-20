package dev.mvc.api;

import java.io.BufferedReader;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

@Controller
public class ApiCont {
    
    @Autowired
    @Qualifier("dev.mvc.api.ApiProc")
    private ApiProc apiProc;
    

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
        return "houseinfo/getinfo";
    }
    
    // 사용자가 form에서 '구' + 거래일자 선택하여 submit 하면, OpenApi통신 및 결과 포워딩.
    @RequestMapping(value = "/api/call_do", method = RequestMethod.POST)
    public String fowrdToGet(String regionCode, String year, String month, Model model) {
         
        System.out.println("호출됨");
        ApiVO apiVO = null;
        List<ApiVO> list = null;
        String date = year + month;
        
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
        
        return "houseinfo/postinfo";
    }
    
    
    
    
    
    
    
    //  ============ 내부 구현 methods (below)    
    private String getOpenApiUrl(String regionCode, String date) throws Exception {
        
        StringBuilder urlBuilder = new StringBuilder("http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev"); /*URL*/
        
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=이곳에API지도키넣기!!"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("500", "UTF-8")); /*한 페이지 결과 수*/
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
                tempJson.put("partAddr", partAddress.toString());
                tempJson.put("cyear", getTagValue("건축년도", el));
                tempJson.put("amount", getTagValue("거래금액", el));
                tempJson.put("area", getTagValue("전용면적", el));

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
