package com.kh.semi.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {
	
	@GetMapping("/mypage")
	public String mypagerPage() {
		return "/member/mypage";
	}
	
	@GetMapping("/signup")
	public String signupPage() {
		return "/member/signup";
	}
	
	@GetMapping("/personagree")
	public String personagreePage() {
		return "/member/personagree";
	}

}
