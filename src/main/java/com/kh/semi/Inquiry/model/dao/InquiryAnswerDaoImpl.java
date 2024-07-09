package com.kh.semi.Inquiry.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.Inquiry.model.vo.InquirAnswer;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InquiryAnswerDaoImpl implements InquiryAnswerDao {

	private final SqlSessionTemplate sqlSession;
	
	@Override
	public List<InquirAnswer> selectAnswerList(int inquiryNo) {
		return sqlSession.selectList("InquirAnswer.selectAnswerList", inquiryNo);
	}

	@Override
	public int insertAnswer(InquirAnswer a) {
		return sqlSession.insert("InquirAnswer.insertAnswer", a);
	}

	@Override
	public int updateAnswer(InquirAnswer a) {
		return sqlSession.update("InquirAnswer.updateAnswer", a);
	}

	@Override
	public int deleteAnswer(int answerNo) {
		return sqlSession.delete("InquirAnswer.deleteAnswer", answerNo);
	}

}
