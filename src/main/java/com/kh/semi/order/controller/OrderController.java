package com.kh.semi.order.controller;

import java.sql.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.semi.order.model.service.OrderService;
import com.kh.semi.order.model.vo.Order;
import com.kh.semi.user.model.vo.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/order")
@RequiredArgsConstructor
public class OrderController {

	private final OrderService orderService;
	private final ServletContext application;
	private final ResourceLoader resourceLoader;

	@GetMapping("/list")
	public String selectOrderList(Model model) {
		List<Order> list = orderService.selectOrderList();

		return "/order/noticeboard";
	}

	@GetMapping("/orderInsert")
	public String insertOrderForm() {
		return "/order/orderInsert";
	}

	@PostMapping("/orderInsert")
    @ResponseBody
    public ResponseEntity<String> insertOrder(@RequestBody Order order, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        
        order.setUserNo(loginUser.getUserNo());
        order.setCreateDate(new Date(System.currentTimeMillis()));
        
        int result = orderService.insertOrder(order);

        

        return ResponseEntity.ok("Order received successfully");
    }
	@GetMapping("/noticeboard")
	public String boardPage() {
		return "/order/noticeboard";
	}

	@GetMapping("/detailProduct")
	public String detailProduct() {
		return "/order/detailProduct";
	}

}
