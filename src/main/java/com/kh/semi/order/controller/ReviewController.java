package com.kh.semi.order.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.semi.order.model.service.OrderService;
import com.kh.semi.order.model.service.ReviewService;
import com.kh.semi.order.model.vo.Review;
import com.kh.semi.user.model.service.UserService;
import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;

import lombok.RequiredArgsConstructor;


@Controller
@RequestMapping("/review")
@SessionAttributes({"loginUser"})
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;
    private final UserService userService;
    private final OrderService orderService;
    
    @PostMapping("/selectReviewList")
    @ResponseBody
    public List<Review> selectReviewList(@RequestParam(required = false) Integer orderNo) {
        return reviewService.selectReviewList(orderNo);
    }
    
//    @PostMapping("/insertReview")
//    @ResponseBody
//    public int insertReview(
//    		@RequestParam("riderNo") int riderNo,
//    		@RequestParam("orderNo") int orderNo,
//    		@RequestParam("reviewContent") String reviewContent,
//    		@RequestParam("rating") int rating,
//    		@RequestParam("writer") String writer
//    		) {
//    	Review review = new Review();
//    	review.setRiderNo(riderNo);
//    	review.setOrderNo(orderNo);
//    	review.setReviewContent(reviewContent);
//    	review.setRating(rating);
//    	review.setWriter(writer);
//    	
//    	int result = reviewService.insertReview(review);
//    	if(result > 0) {
//    		Rider rider = userService.selectRider(review.getRiderNo());
//    		int OrderRiderCountComplete = orderService.OrderRiderCountComplete(review.getRiderNo());
//    		
//    		Double grade = (Double)((rider.getGrade() + review.getRating()) / OrderRiderCountComplete);
//    		rider.setGrade(grade);
//    		
//    		userService.updateRiderRating(rider);
//    		
//    	} 
//    	return result;
//    }
    
    
    @PostMapping("/insertReview")
    @ResponseBody
    public String insertReview(@RequestBody Review review, @SessionAttribute("loginUser") User loginUser) {
        review.setWriter(loginUser.getNickname());
        int result = reviewService.insertReview(review);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }
    
    
}































