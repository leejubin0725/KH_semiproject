package com.kh.semi.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.user.model.service.UserService;
import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;
import com.kh.semi.user.model.vo.Vehicle;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
@SessionAttributes({"loginUser"})
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
		return "";
	}
	
	@PostMapping("/insert")
	public String insert(
			User u,
			Rider r,
			Vehicle v,
			Model model,
			RedirectAttributes ra
			) {
		int result = uService.insertUser(u);
		if(model.getAttribute("riderselect") != null) {
			result *= uService.insertRider(r);
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
