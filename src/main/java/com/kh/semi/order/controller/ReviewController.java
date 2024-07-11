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

import com.kh.semi.order.model.service.ReviewService;
import com.kh.semi.order.model.vo.Review;
import com.kh.semi.user.model.vo.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
@RequestMapping("/review")
@SessionAttributes({"loginUser"})
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;
    
    @GetMapping("/selectReviewList")
    @ResponseBody
    public List<Review> selectReviewList(@RequestParam(required = false) Integer orderNo) {
        return reviewService.selectReviewList(orderNo);
    }
    
    @PostMapping("/insertReview")
    @ResponseBody
    public String insertReview(@RequestBody Review review, @SessionAttribute("loginUser") User loginUser) {
    	log.debug("test : {}" , review);
        review.setWriter(loginUser.getNickname());
        review.setRiderNo(1);
        int result = reviewService.insertReview(review);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }
}































