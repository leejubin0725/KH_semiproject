package com.kh.semi.board.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {
	@GetMapping("/noticeboard")
	public String boardPage() {
		return "/board/noticeboard";
	}
	
	@GetMapping("/customerservice")
	public String customerPage() {
		return "/board/customerservice";
	}
}
