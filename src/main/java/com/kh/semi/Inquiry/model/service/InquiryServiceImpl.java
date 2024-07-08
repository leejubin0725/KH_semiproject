package com.kh.semi.Inquiry.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.semi.Inquiry.model.dao.InquiryDao;
import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.Inquiry.model.vo.InquiryCategory;
import com.kh.semi.Inquiry.model.vo.InquiryImg;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryServiceImpl implements InquiryService{
	private final InquiryDao inquiryDao;

	@Override
	public List<Inquiry> inquiryList() {
		return inquiryDao.inquiryList();
	}

	@Override
	public List<InquiryCategory> inquiryCategoryList() {
		return inquiryDao.inquiryCategoryList();
	}

	@Override
	public Inquiry selectInquiryNo(int inquiryNo) {
		return inquiryDao.selectInquiryNo(inquiryNo);
	}

	@Override
	public int insertInquiry(Inquiry i, InquiryImg ii) throws Exception {
		int result = inquiryDao.insertInquiry(i);
		
		if(ii != null) {
			ii.setInquiryNo(i.getInquiryNo());
			result *= inquiryDao.insertInquiryImg(ii);
		}
		
		if(result == 0) {
			throw new Exception("예외 발생");
		}
		
		return result;
	}

	@Override
	public Inquiry selectInquiryOne(int inquiryNo) {
		return inquiryDao.selectInquiryOne(inquiryNo);
	}

	@Override
	public InquiryImg selectInquiryImg(int inquiryNo) {
		return inquiryDao.selectInquiryImg(inquiryNo);
	}
	
}
