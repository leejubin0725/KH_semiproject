package com.kh.semi.Inquiry.model.dao;

import java.util.List;

import com.kh.semi.Inquiry.model.vo.InquiryAnswer;

public interface InquiryAnswerDao {

	List<InquiryAnswer> selectAnswerList(int inquiryNo);

	int insertAnswer(InquiryAnswer a);

	int updateAnswer(InquiryAnswer a);

	int deleteAnswer(int answerNo);


}
