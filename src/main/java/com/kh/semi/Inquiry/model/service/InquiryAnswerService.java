package com.kh.semi.Inquiry.model.service;

import java.util.List;

import com.kh.semi.Inquiry.model.vo.InquirAnswer;

public interface InquiryAnswerService {

	List<InquirAnswer> selectAnswerList(int inquiryNo);

	int insertAnswer(InquirAnswer a);

	int updateAnswer(InquirAnswer a);

	int deleteAnswer(int answerNo);

}
