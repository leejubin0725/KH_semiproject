package com.kh.semi.order.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.order.model.vo.Review;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReviewDaoImpl implements ReviewDao{

	public final SqlSessionTemplate sqlSession;
	
	@Override
	public List<Review> selectReviewList(Integer orderNo) {
		
		return sqlSession.selectList("review.selectReviewList",orderNo);
	}

	@Override
	public int insertReview(Review review) {
		return sqlSession.insert("review.insertReview",review);
	}

}
