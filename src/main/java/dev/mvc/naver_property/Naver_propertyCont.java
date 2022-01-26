package dev.mvc.naver_property;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

//@Controller
public class Naver_propertyCont {
    
//    @Autowired
    public Naver_propertyCont() {
        System.out.println("-> naver_property created.");
        System.out.println(url_return("돈암동 한신"));
        //System.out.println(url_return("돈암동 돈암동삼성"));
    }
    
    public static final String WEB_DRIVER_ID = "webdriver.chrome.driver"; //드라이버 ID
    public static final String WEB_DRIVER_PATH = "C:/kd1/ws_java/team5_v2sbm3c/chromedriver.exe"; //드라이버 경로
    
    public String url_return(String apt_name) {
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

}