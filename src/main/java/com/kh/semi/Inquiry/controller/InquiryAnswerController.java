package com.kh.semi.Inquiry.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.semi.Inquiry.model.service.InquiryAnswerService;
import com.kh.semi.Inquiry.model.vo.InquirAnswer;
import com.kh.semi.user.model.vo.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/InquirAnswer")
@RequiredArgsConstructor
@RestController
@SessionAttributes({"loginUser"})
public class InquiryAnswerController {
	
	private final InquiryAnswerService service;
	
	
	
	@GetMapping("/selectAnswerList")
	public List<InquirAnswer> selectAnswerList(@RequestParam(required = false) Integer inquiryNo) {
	    if (inquiryNo == null) {
	        // 적절한 오류 처리
	        throw new IllegalArgumentException("inquiryNo is required");
	    }
	    return service.selectAnswerList(inquiryNo);
	}
	
	@PostMapping("/insertAnswer")
	public int insertAnswer(@RequestBody InquirAnswer a, @SessionAttribute("loginUser") User loginUser) {
	    a.setAnswerWriter(loginUser.getNickname());
	    a.setUserNickname(loginUser.getNickname());
	    return service.insertAnswer(a);
	}
	
	@PostMapping("/update")
	public int updateAnswer(@RequestBody InquirAnswer a) {
	    return service.updateAnswer(a);
	}

	@PostMapping("/deleteAnswer")
	public int deleteAnswer(@RequestParam int answerNo) {
	    return service.deleteAnswer(answerNo);
	}
	
}
