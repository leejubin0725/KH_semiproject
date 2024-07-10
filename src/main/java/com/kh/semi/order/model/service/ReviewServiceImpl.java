package com.kh.semi.order.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.semi.order.model.dao.ReviewDao;
import com.kh.semi.order.model.vo.Review;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService{
	
	public final ReviewDao reviewDao;
	
	@Override
	public List<Review> selectReviewList(Integer orderNo) {
		return reviewDao.selectReviewList(orderNo);
	}

	@Override
	public int insertReview(Review review) {
		
		return reviewDao.insertReview(review);
	}

}
