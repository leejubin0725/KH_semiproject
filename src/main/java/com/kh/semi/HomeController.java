package com.kh.semi;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {
	
	private final ServletContext application;
	
	
	@GetMapping({"", "/", "/home"})
	public String homePage() {
		application.setAttribute("contextPath", application.getContextPath());
		return "home";
	}
	
	
	@GetMapping("/noticeboard")
	public String boardPage() {
		return "notice-board";
	}
	
	@GetMapping("/customerservice")
	public String customerPage() {
		return "customer-service";
	}
	
	@GetMapping("/mypage")
	public String mypagerPage() {
		return "mypage";
	}
	
	@GetMapping("/signup")
	public String signupPage() {
		return "signup";
	}
	

	@GetMapping("/personagree")
	public String personagreePage() {
		return "personagree";
	}
	
	

	
	
	
}
