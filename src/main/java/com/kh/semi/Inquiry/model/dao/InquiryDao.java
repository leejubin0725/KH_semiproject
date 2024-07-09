package com.kh.semi.Inquiry.model.dao;

import java.util.List;

import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.Inquiry.model.vo.InquiryCategory;
import com.kh.semi.Inquiry.model.vo.InquiryImg;

public interface InquiryDao {

	int insertInquiry(Inquiry i);
	
	int initCategory(InquiryCategory ic);

	List<Inquiry> inquiryList();

	List<InquiryCategory> inquiryCategoryList();

	Inquiry selectInquiryNo(int inquiryNo);

	int insertInquiryImg(InquiryImg ii);

	Inquiry selectInquiryOne(int orderNo);

	InquiryImg selectInquiryImg(int inquiryNo);

	int selectInquiryCategory(String category);

	

}
