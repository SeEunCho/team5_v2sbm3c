package dev.mvc.apihouse;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


// 공공데이터 포털 자료를 DB에 넣는 컨트롤러 클래스
@Controller
public class ApihouseCont {
    
    @Autowired
    @Qualifier("dev.mvc.apihouse.ApihouseProc")
    private ApihouseProcInter apihouseProc;
    
    // google api 통신으로 반환된 위 경도 + 나머지 주택정보가 binding되어 오라클에 1건 씩 insert
    @ResponseBody
    @RequestMapping(value = "/api/geo.go", method = RequestMethod.GET) 
    public String insertResion(ApihouseVO apihouseVO) {
        
        int result = apihouseProc.insert(apihouseVO);
        JSONObject json = new JSONObject();
        
        if (result < 1) {
            json.put("code", "실패...");
        } else {
            json.put("code", "성공!");
        }
        
        return json.toString();
    }

    
    
    
    
    
    // ====================================================== //
    // java controller 단에서 직접 google api 요청 보내는 컨트롤러
    // 사용하지않는 컨트롤러.. 추후 학습을 위해 남겨둠
    @ResponseBody
    @RequestMapping(value = "/api/geo_do", method=RequestMethod.GET)
    public String procGeo() {
        
        ModelAndView mav = new ModelAndView();
        
        StringBuilder urlBuilder = new StringBuilder("https://maps.google.com/maps/api/js?key=AIzaSyB9MXxWL1I2d22VVQj7FzVCelxfZWBDsc8&sensor=flase"); /*URL*/
        String line ="";
        
        try {
            urlBuilder.append("&" + URLEncoder.encode("address", "UTF-8") + "=" + URLEncoder.encode("미아동 센트레빌 아파트", "UTF-8"));
            URL url = new URL(urlBuilder.toString());
            
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            
            System.out.println("Response code: " + conn.getResponseCode());
            BufferedReader rd;
            
            // 자바스크립트 기준으로 응답이 옴... (java에서 요청을 보냈으나, google api측에서 javascript요청 기준으로 결과를 return)
            // java컨트롤러 내부에서는 처리가 불가... 2중 ajax요청으로 방향을 바꿈.
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            
            StringBuilder sb = new StringBuilder();
            
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            
            rd.close();
            conn.disconnect();
            System.out.println(sb.toString());
            
            mav.addObject("line", line);
            
        } catch (Exception e) {
            e.printStackTrace();    
        }

        return line;
    }

}
