package com.kh.semi.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@GetMapping("/login")
	public String loginPage() {
		return "";
	}
	
	@PostMapping("/login")
	public String login() {
		return "";
	}
	
	@GetMapping("/insert")
	public String insertPage() {
		return "/user/signup";
	}
	
	@PostMapping("/insert")
	public String insert(
			@ModelAttribute User u,
			Model model,
			RedirectAttributes ra
			) {

		int result = uService.insertUser(u);
		log.debug("user : {}" , u);
		if(u.getRole().equals("rider")) {
			Rider r = new Rider();
			r.setUserNo(u.getUserNo());
			result *= uService.insertRider(r);
			
			Vehicle v = new Vehicle();
			v.setRiderNo(r.getRiderNo());
			v.setVehicle((String)model.getAttribute("vehicle"));
			result *= uService.insertVehicle(v);
		} 
		
		String url = "";
		if(result > 0) {
			ra.addFlashAttribute("alertMsg" , "회원가입 성공");
			url = "redirect:/"; // 재요청
		} else {
			model.addAttribute("errorMsg" , "회원가입 실패");
			url = "common/errorPage"; // 에러 페이지
		}
		return url;
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "";
	}
}
