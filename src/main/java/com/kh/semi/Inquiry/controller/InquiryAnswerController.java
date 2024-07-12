package com.kh.semi.Inquiry.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.semi.Inquiry.model.service.InquiryAnswerService;
import com.kh.semi.Inquiry.model.service.InquiryService;
import com.kh.semi.Inquiry.model.vo.InquiryAnswer;
import com.kh.semi.user.model.vo.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/InquiryAnswer")
@RequiredArgsConstructor
@RestController
@SessionAttributes({"loginUser"})
public class InquiryAnswerController {
	
	private final InquiryAnswerService service;
	private final InquiryService inquiryService;
	
	@GetMapping("/selectAnswerList")
	public List<InquiryAnswer> selectAnswerList(@RequestParam(required = false) Integer inquiryNo) {
	    return service.selectAnswerList(inquiryNo);
	}
	
	@PostMapping("/insertAnswer")
	public int insertAnswer(@RequestBody InquiryAnswer a, @SessionAttribute("loginUser") User loginUser) {
	    a.setAnswerWriter(loginUser.getNickname());
	    a.setUserNickname(loginUser.getNickname());
	    int result = inquiryService.updateStatus(a.getInquiryNo());

	    return service.insertAnswer(a);
	}
	
	@PostMapping("/updateAnswer")
	public int updateAnswer(@RequestBody InquiryAnswer a) {
		return service.updateAnswer(a);
	}
	
	@PostMapping("/deleteAnswer")
	public int deleteAnswer(Integer answerNo) {
		return service.deleteAnswer((int)answerNo);
	}
	
	
}