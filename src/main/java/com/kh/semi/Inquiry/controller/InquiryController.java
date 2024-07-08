package com.kh.semi.Inquiry.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.Inquiry.model.service.InquiryService;
import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.Inquiry.model.vo.InquiryCategory;
import com.kh.semi.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@SessionAttributes({"loginUser"})
public class InquiryController {
	
	private final InquiryService iService;
	private final ServletContext application;
	
	@GetMapping("/board/customerservice")
	public String inquiryList() {
		List<Inquiry> inquiryList = iService.inquiryList();
		
		List<InquiryCategory> inquiryCategoryList = iService.inquiryCategoryList();
		
		application.setAttribute("inquiryList" , inquiryList);
		application.setAttribute("inquiryCategoryList" , inquiryCategoryList);
		
		return "/board/customerservice";
	}
	
	@GetMapping("/board/inquiryInsert")
	public String inquiryInsertPage() {
		return "/board/inquiryInsert";
	}
	
	@PostMapping("/board/inquiryInsert")
	public String inquiryInsert(
			Inquiry i,
			Model model,
			@ModelAttribute("loginUser") User loginUser,
			RedirectAttributes ra,
			@RequestParam(value="upfile", required=false) MultipartFile upfile
			) {
		i.setUserNo(loginUser.getUserNo());
		i.setCategoryNo(1);
		int result = iService.insertInquiry(i);
		
		String url = "";
		if(result > 0) {
			ra.addFlashAttribute("alertMsg" , "글 작성 성공");
			url = "redirect:/board/customerservice";
			
		} else {
			model.addAttribute("errorMsg" , "게시글 작성 실패");
			url = "common/errorPage";
		}	

		return url;
	}
	
	@GetMapping("/inquiryDetailView/{id}")
	public String inquiryDetailView(
			@RequestParam("id") int id, 
			Model model
			) {
		Inquiry inquiry = iService.getInquiryById(id);
	    model.addAttribute("inquiry", inquiry);
		
		return "board/inquiryDetailView";
	}
	
}
