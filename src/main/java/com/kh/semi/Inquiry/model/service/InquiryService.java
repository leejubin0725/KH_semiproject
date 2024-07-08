package com.kh.semi.Inquiry.model.service;

import java.util.List;

import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.Inquiry.model.vo.InquiryCategory;

public interface InquiryService {

	int insertInquiry(Inquiry i);
	
	List<Inquiry> inquiryList();

	List<InquiryCategory> inquiryCategoryList();

	Inquiry getInquiryById(int id);

}
