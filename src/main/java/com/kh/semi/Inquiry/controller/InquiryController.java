package com.kh.semi.Inquiry.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.Inquiry.model.service.InquiryService;
import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.Inquiry.model.vo.InquiryCategory;
import com.kh.semi.Inquiry.model.vo.InquiryImg;
import com.kh.semi.common.Utils;
import com.kh.semi.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@SessionAttributes({"loginUser"})
@RequestMapping("/inquiry")
public class InquiryController {
    
    private final InquiryService iService;
    private final ServletContext application;
    
    @GetMapping("/customerservice")
    public String inquiryList() {
        List<Inquiry> inquiryList = iService.inquiryList();
        List<InquiryCategory> inquiryCategoryList = iService.inquiryCategoryList();
        
        if(inquiryCategoryList.isEmpty()) {
        	iService.initCategory(new InquiryCategory(1,"분류1"));
        	iService.initCategory(new InquiryCategory(2,"분류2"));
        	iService.initCategory(new InquiryCategory(3,"분류3"));
        	iService.initCategory(new InquiryCategory(4,"분류4"));
        	iService.initCategory(new InquiryCategory(5,"분류5"));
        }
        
        application.setAttribute("inquiryList" , inquiryList);
        application.setAttribute("inquiryCategoryList" , inquiryCategoryList);
        
        return "inquiry/customerservice";
    }
    
    @GetMapping("/inquiryInsert")
    public String inquiryInsertPage() {
        return "inquiry/inquiryInsert";
    }
    
    @PostMapping("/inquiryInsert")
    public String inquiryInsert(
            Inquiry i,
            Model model,
            @ModelAttribute("loginUser") User loginUser,
            RedirectAttributes ra,
            @RequestParam(value="file", required=false) MultipartFile upfile,
            @RequestParam("category") String category
            ) {
        i.setUserNo(loginUser.getUserNo());
        i.setCategoryNo(iService.selectInquiryCategory(category));
        
        InquiryImg ii = null;
		if(upfile != null && !upfile.isEmpty()) {
			String webPath = "/resources/images/Inquiry/";
			String serverFolderPath = application.getRealPath(webPath);
			
			// 디렉토리가 존재하지 않는다면 생성하는 코드 추가
			File dir = new File(serverFolderPath);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			// 사용자가 등록한 첨부파일의 이름을 수정
			String changeName = Utils.saveFile(upfile, serverFolderPath);
		
			ii = new InquiryImg();
			ii.setInquiryNo(i.getInquiryNo());
			ii.setChangeName(changeName);
			ii.setOriginName(upfile.getOriginalFilename());
		}
		
		
		int result = 0;
		try {
			result = iService.insertInquiry(i , ii);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String url = "";
        if(result > 0) {
            ra.addFlashAttribute("alertMsg" , "글 작성 성공");
            url = "redirect:/inquiry/customerservice";
        } else {
            model.addAttribute("errorMsg" , "게시글 작성 실패");
            url = "common/errorPage";
        }   
        return url;
    }
    
    @GetMapping("/inquiryDetailView/{inquiryNo}")
    public String inquiryDetailView(
    		@PathVariable("inquiryNo") int inquiryNo,
			Model model,
			@ModelAttribute("loginUser") User loginUser,
			HttpServletRequest req,
			HttpServletResponse res
			) {
		Inquiry i  = iService.selectInquiryOne(inquiryNo);
		i.setInquiryImg(iService.selectInquiryImg(inquiryNo));
		
		model.addAttribute("inquiry", i);
		
		return "inquiry/inquiryDetailView";
    }
}

