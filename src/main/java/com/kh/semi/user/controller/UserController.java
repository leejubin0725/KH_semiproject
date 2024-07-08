package com.kh.semi.user.controller;

import java.io.IOException;
import java.text.Normalizer.Form;
import java.util.HashMap;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpSession;
import javax.swing.text.AbstractDocument.Content;

import org.apache.http.client.ClientProtocolException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.semi.user.model.service.UserService;
import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;
import com.kh.semi.user.model.vo.Vehicle;

import lombok.RequiredArgsConstructor;


import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.http.entity.StringEntity;

import org.springframework.beans.factory.annotation.Value;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
@SessionAttributes({"loginUser"})
public class UserController {
	

	@Value("${kakao.client.id}")
	private String clientId;

	@Value("${kakao.redirect.uri}")
	private String redirectUri;

	@Value("${kakao.client.secret}")
	private String clientSecret; // 카카오 개발자 콘솔에서 발급받은 클라이언트 시크릿

   private final UserService uService;
   private final BCryptPasswordEncoder encoder;

   @GetMapping("/login")
   public String loginPage() {
      return "/user/login";
   }

   @PostMapping("/login")
   public String login(
         @ModelAttribute User u ,
         Model model,
         HttpSession session,
         RedirectAttributes ra
         ) {
      
      User loginUser = uService.login(u);
      String url = "";
      if(!(loginUser != null && encoder.matches(u.getPassword(), loginUser.getPassword()))) {
         model.addAttribute("errorMsg" , "로그인 실패!");
         url = "common/errorPage";
      } else {
         ra.addFlashAttribute("alertMsg" , "로그인 성공");
         model.addAttribute("loginUser" , loginUser);
         
         String nextUrl = (String) session.getAttribute("nextUrl");
         
         url = "redirect:" + (nextUrl != null ? nextUrl :"/");
         session.removeAttribute(nextUrl);
      }
      return url;
   }

   @GetMapping("/idfind")
   public String idfindPage() {
      return "/user/idfind";
   }
   
   @GetMapping("/insert")
   public String insertPage() {
      return "/user/signup";
   }

   @PostMapping("/insert")
   public String insert(
         @ModelAttribute User u,
         Model model,
         @RequestParam("vehicle") Object vehicle,
         RedirectAttributes ra
         ) {
      String encPwd = encoder.encode(u.getPassword()); 
      u.setPassword(encPwd); 
      
      int result = uService.insertUser(u);

      if (u.getRole().equals("rider")) {
         Rider r = new Rider();
         r.setUserNo(u.getUserNo());
         result *= uService.insertRider(r);

         Vehicle v = new Vehicle();
         v.setRiderNo(r.getRiderNo());
         v.setVehicle((String)vehicle);
         switch ((String)vehicle) {
         case "Walk":
            v.setMaxDistance(1000);
            break;
         case "Bicycle":
            v.setMaxDistance(2500);
            break;
         case "Motobike":
            v.setMaxDistance(5000);
            break;
         case "Car":
            v.setMaxDistance(10000);
            break;
         }
         result *= uService.insertVehicle(v);
      }

      String url = "";
      if (result > 0) {
         ra.addFlashAttribute("alertMsg", "회원가입 성공");
         url = "redirect:/"; // 재요청
      } else {
         model.addAttribute("errorMsg", "회원가입 실패");
         url = "common/errorPage"; // 에러 페이지
      }
      return url;
   }

   @GetMapping("/mypage")
   public String mypage() {
      return "/user/mypage";
   }
   
   @PostMapping("/update")
   public String update(
         User u, 
         Model model, 
         RedirectAttributes ra,
         HttpSession session
         ) {
      String encPwd = encoder.encode(u.getPassword()); 
      u.setPassword(encPwd); 
      int result = uService.updateUser(u);
      
      String url = "";
      if(result > 0) {
         User loginUser = uService.login(u);
         model.addAttribute("loginUser", loginUser);
         ra.addFlashAttribute("alertMsg" , "내정보수정 성공");
         url = "redirect:/user/mypage";
      } else {
         model.addAttribute("errorMsg" , "내정보수정 실패");
         url = "common/errorPage";
         
      }
      
      return url;
   }
   
   @GetMapping("/logout")
   public String logout(SessionStatus status) {
      status.setComplete();
      return "redirect:/";
   }
   
   @GetMapping("/idCheck")
    @ResponseBody
    public int idCheck(@RequestParam String email) {
       int result = uService.idCheck(email);
       
       return result;
    }
   
   
//   @PostMapping("/idfind")
//   @ResponseBody
//   public ResponseEntity<String> idfind(@RequestParam String phone) {
//       String username = uService.idfind(phone);
//       String responseMessage = (username != null) ? username : "아이디를 찾을 수 없습니다.";
//       return ResponseEntity.ok()
//                            .contentType(MediaType.TEXT_PLAIN)
//                            .body(responseMessage);
//   }
   
   /* 카카오로그인 */


   @GetMapping("/kakao/login")
   public String kakaoLogin() {
       String url = "https://kauth.kakao.com/oauth/authorize?"
                  + "response_type=code"
                  + "&client_id=" + clientId
                  + "&redirect_uri=" + redirectUri;

       return "redirect:" + url;
   }

   @GetMapping("/kakao/callback")
   public String kakaoCallback(@RequestParam("code") String code, HttpSession session) throws ClientProtocolException, IOException {
       String tokenUrl = "https://kauth.kakao.com/oauth/token";

       // HTTP POST 요청을 생성합니다.
       CloseableHttpClient httpClient = HttpClients.createDefault();
       HttpPost httpPost = new HttpPost(tokenUrl);
       httpPost.setHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

       // 요청 본문에 필요한 파라미터를 추가합니다.
       StringEntity params = new StringEntity(
           "grant_type=authorization_code" +
           "&client_id=" + clientId +
           "&redirect_uri=" + redirectUri +
           "&code=" + code +
           "&client_secret=" + clientSecret
       );
       httpPost.setEntity(params);

       // 요청을 실행하고 응답을 얻습니다.
       HttpResponse httpResponse = httpClient.execute(httpPost);
       String response = EntityUtils.toString(httpResponse.getEntity());

       // 응답을 JSON으로 파싱합니다.
       ObjectMapper mapper = new ObjectMapper();
       JsonNode rootNode = mapper.readTree(response);
       String accessToken = rootNode.path("access_token").asText();

       // 사용자 정보 요청
       String userInfoUrl = "https://kapi.kakao.com/v2/user/me";
       HttpGet httpGet = new HttpGet(userInfoUrl);
       httpGet.setHeader("Authorization", "Bearer " + accessToken);

       // 사용자 정보 요청을 실행하고 응답을 얻습니다.
       httpResponse = httpClient.execute(httpGet);
       response = EntityUtils.toString(httpResponse.getEntity());
       rootNode = mapper.readTree(response);

       // 사용자 정보를 session에 저장합니다.
       String kakaoId = rootNode.path("id").asText();
       String email = rootNode.path("kakao_account").path("email").asText();

       Map<String, String> userInfo = new HashMap<>();
       userInfo.put("kakaoId", kakaoId);
       userInfo.put("email", email);
       session.setAttribute("loginUser", userInfo);

       return "redirect:/home"; // 로그인 후 이동할 페이지
   }
   
}
