package com.kh.semi.Inquiry.model.service;

import java.util.List;

import com.kh.semi.Inquiry.model.vo.InquiryAnswer;

public interface InquiryAnswerService {

	List<InquiryAnswer> selectAnswerList(int inquiryNo);

	int insertAnswer(InquiryAnswer a);

	int updateAnswer(InquiryAnswer a);

	int deleteAnswer(int answerNo);


}
