package com.kh.semi.board.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {
	
	

	@GetMapping("/myPost")
	public String myPost() {
		return "/board/myPost";
	}
	
	@GetMapping("/noticeboard")
	public String noticeboard() {
		return "/board/noticeboard";
	}
	@GetMapping("/insertBoard")
	public String insertBoard() {
		return "/board/insertBoard";
	}
	@GetMapping("/inquiryInsert")
	public String inquiryInsert() {
		return "/board/inquiryInsert";
	}
	@GetMapping("/insertUser")
	public String insertUser() {
		return "/board/insertUser";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "/board/mypage";
	}
	@GetMapping("/orderInsert")
	public String orderInsert() {
		return "/board/orderInsert";
	}
}

















