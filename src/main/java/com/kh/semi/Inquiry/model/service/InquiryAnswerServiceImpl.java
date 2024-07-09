package com.kh.semi.Inquiry.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.semi.Inquiry.model.dao.InquiryAnswerDao;
import com.kh.semi.Inquiry.model.vo.InquiryAnswer;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryAnswerServiceImpl implements InquiryAnswerService{

	private final InquiryAnswerDao answerDao;
	
	@Override
	public List<InquiryAnswer> selectAnswerList(int inquiryNo) {
		return answerDao.selectAnswerList(inquiryNo);
	}

	@Override
	public int insertAnswer(InquiryAnswer a) {
		return answerDao.insertAnswer(a);
	}

	@Override
	public int updateAnswer(InquiryAnswer a) {
		return answerDao.updateAnswer(a);
	}

	@Override
	public int deleteAnswer(int answerNo) {
		return answerDao.deleteAnswer(answerNo);
	}


}
