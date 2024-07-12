package com.kh.semi.report.cotroller;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.report.model.service.ReportService;
import com.kh.semi.report.model.vo.Report;
import com.kh.semi.user.model.vo.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/report")
@Slf4j
@SessionAttributes({"loginUser"})
@RequiredArgsConstructor
public class ReportController {
	
	private final ServletContext application;

	private final ReportService reportservice;
 
	
	@GetMapping("/report")
	public String report() {
		return "/order/report";
	}
	
	@GetMapping("/save")
	public String save() {
		return "home";
	}
	
	@PostMapping("/save")
	public String save(
			Report re,
			Model model,
			@ModelAttribute("loginUser") User loginUser,
			RedirectAttributes ra
			) {
	 re.setNickName(loginUser.getNickname());
 
	 int result = 0;
	 try {
		  result = reportservice.save(re);
		} catch (Exception e) {
			e.printStackTrace();
		}
	 
	 
	 String url = "";
     if(result > 0) {
         ra.addFlashAttribute("alertMsg" , "글 작성 성공");
         url = "home";
     } else {
         model.addAttribute("errorMsg" , "게시글 작성 실패");
         url = "common/errorPage";
     }   
     return url;
	}
 
 
 
 

 @GetMapping("/reportList")
 public String showReportList(Model model) {
	 List<Report> list = reportservice.selectReportList();
		
		application.setAttribute("reports", list);
		
		return "report/reportList";
	}
 }

 
 
 
