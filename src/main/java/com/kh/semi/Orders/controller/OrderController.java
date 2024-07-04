package com.kh.semi.Orders.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.Orders.model.service.OrdersService;
import com.kh.semi.Orders.model.vo.Order;
import com.kh.semi.Orders.model.vo.OrdersImg;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/Orders")
@RequiredArgsConstructor
public class OrderController {
	
	private final OrdersService orderService;
	private final ServletContext application;
	private final ResourceLoader resourceLoader;
	
	@GetMapping("/list")
	public String selectOrderList(
			Model model			
			) {
		List<Order> list = orderService.selectOrderList();
		
		return "Orders/noticeboard";
	}
	
	@GetMapping("/orderInsert")
	public String insertOrderForm() {
		return "Orders/orderInsert";
	}
	
	@PostMapping("/orderInsert")
	public String insertOrder(
			Order o,
			Model model,
			@RequestParam("title") String title,
			@RequestParam(value="upfile", required=false) MultipartFile upfile
			) {
		System.out.println(title);
		OrdersImg oi = null;
		if(upfile != null && !upfile.isEmpty()) {
			String webPath = "resources/images/Orders/";
			String serverFolderPath = application.getRealPath(webPath);
			
			File dir = new File(serverFolderPath);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			oi = new OrdersImg();
			oi.setChangeName("");
			oi.setOriginName(upfile.getOriginalFilename());
		}
		
		log.debug("Order : {}", o);
		o.setWriter(String.valueOf(o.getOrderNo()));
		
		int result = 0;
		try {
//			result = orderService.insertOrder(o, oi);
			result = orderService.insertOrder(o);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		
		String url = "redirct:/Orders/list";
		
		return url;
	}
	
	
	@GetMapping("/noticeboard")
	public String boardPage() {
		return "/Orders/noticeboard";
	}
	
	@GetMapping("/customerservice")
	public String customerPage() {
		return "/Orders/customerservice";
	}
	
}

