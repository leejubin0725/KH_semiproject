package com.kh.semi.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.user.model.service.UserService;
import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;
import com.kh.semi.user.model.vo.Vehicle;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
@SessionAttributes({"loginUser"})
@Slf4j
public class UserController {

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
}
