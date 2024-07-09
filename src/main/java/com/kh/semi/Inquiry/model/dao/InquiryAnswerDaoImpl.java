package com.kh.semi.Inquiry.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.Inquiry.model.vo.InquiryAnswer;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InquiryAnswerDaoImpl implements InquiryAnswerDao {

	private final SqlSessionTemplate sqlSession;
	
	@Override
	public List<InquiryAnswer> selectAnswerList(int inquiryNo) {
		return sqlSession.selectList("InquiryAnswer.selectAnswerList", inquiryNo);
	}

	@Override
	public int insertAnswer(InquiryAnswer a) {
		return sqlSession.insert("InquiryAnswer.insertAnswer", a);
	}

	@Override
	public int updateAnswer(InquiryAnswer a) {
		return sqlSession.update("InquiryAnswer.updateAnswer", a);
	}

	@Override
	public int deleteAnswer(int answerNo) {
		return sqlSession.update("InquiryAnswer.deleteAnswer", answerNo);
	}

	
	
	
}
