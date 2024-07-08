package com.kh.semi.Inquiry.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.semi.Inquiry.model.dao.InquiryDao;
import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.Inquiry.model.vo.InquiryCategory;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryServiceImpl implements InquiryService{
	private final InquiryDao dao;

	@Override
	public int insertInquiry(Inquiry i) {
		return dao.insertInquiry(i);
	}
	
	@Override
	public List<Inquiry> inquiryList() {
		return dao.inquiryList();
	}

	@Override
	public List<InquiryCategory> inquiryCategoryList() {
		return dao.inquiryCategoryList();
	}

	@Override
	public Inquiry getInquiryById(int id) {
		return dao.getInquiryById(id);
	}
	
}
