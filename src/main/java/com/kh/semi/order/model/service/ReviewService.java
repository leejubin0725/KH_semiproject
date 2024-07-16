package com.kh.semi.order.model.service;

import java.util.List;

import com.kh.semi.order.model.vo.Review;

public interface ReviewService {

	public List<Review> selectReviewList(Integer orderNo);

	public int insertReview(Review review);

}
