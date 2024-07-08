package com.kh.semi.Inquiry.model.service;

import java.util.List;

import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.Inquiry.model.vo.InquiryCategory;
import com.kh.semi.Inquiry.model.vo.InquiryImg;

public interface InquiryService {

	int insertInquiry(Inquiry i, InquiryImg ii) throws Exception;
	
	int initCategory(InquiryCategory ic);
	
	List<Inquiry> inquiryList();

	List<InquiryCategory> inquiryCategoryList();

	Inquiry selectInquiryNo(int inquiryNo);

	Inquiry selectInquiryOne(int inquiryNo);

	InquiryImg selectInquiryImg(int inquiryNo);

	int selectInquiryCategory(String category);	

}
