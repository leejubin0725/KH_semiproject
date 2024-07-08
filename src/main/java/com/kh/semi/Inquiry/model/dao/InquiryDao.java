package com.kh.semi.Inquiry.model.dao;

import java.util.List;

import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.Inquiry.model.vo.InquiryCategory;

public interface InquiryDao {

   int insertInquiry(Inquiry i);

   List<Inquiry> inquiryList();

   List<InquiryCategory> inquiryCategoryList();

   Inquiry selectInquiryNo(int inquiryNo);

}