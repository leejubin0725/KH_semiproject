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
@RequestMapping("/member")
@SessionAttributes({"loginUser"})
@Slf4j
public class UserController {
	
	private final UserService uService;
	
	@GetMapping("/signup")
	public String loginPage() {
		return "/member/signup";
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
			@ModelAttribute User u,
			@ModelAttribute Rider R,
			@ModelAttribute Vehicle V,
			Model model,
			RedirectAttributes ra
			) {
		
		System.out.println(u);
		System.out.println(R);
		System.out.println(V);
		
		return "/home";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "";
	}
}
