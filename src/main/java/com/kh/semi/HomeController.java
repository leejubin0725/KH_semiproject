package com.kh.semi;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.semi.order.model.service.OrderService;
import com.kh.semi.order.model.vo.Order;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
public class HomeController {
	
	private final ServletContext application;
	private final OrderService orderService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		List<Order> urgentlist = orderService.selectUrgentOrderList();
		
		if(urgentlist == null) {
			urgentlist = new ArrayList<>();
		}
		
		application.setAttribute("urgentlist", urgentlist);
		application.setAttribute("contextPath", application.getContextPath());
		return "home";
	}
	
}
