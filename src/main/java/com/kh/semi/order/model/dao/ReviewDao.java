package com.kh.semi.order.model.dao;

import java.util.List;

import com.kh.semi.order.model.vo.Review;

public interface ReviewDao {

	List<Review> selectReviewList(Integer orderNo);

	int insertReview(Review review);
	

}
