package com.kh.semi.order.controller;

import java.io.File;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.common.Utils;
import com.kh.semi.order.model.service.OrderService;
import com.kh.semi.order.model.vo.Order;
import com.kh.semi.order.model.vo.OrdersImg;
import com.kh.semi.user.model.service.UserService;
import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/order")
@SessionAttributes({"loginUser"})
@RequiredArgsConstructor
public class OrderController {
	
	private final OrderService orderService;
	private final UserService userService;
	private final ServletContext application;
	private final ResourceLoader resourceLoader;
	
	@GetMapping("/orderInsert")
	public String insertOrderForm() {
		return "/order/orderInsert";
	}
	
	@PostMapping("/orderInsert")
	public String insertOrder(
			Order o,
			Model model,
			@ModelAttribute("loginUser") User loginUser,
			RedirectAttributes ra,
			@RequestParam(value="file", required=false) MultipartFile upfile
			) {
		o.setUserNo(loginUser.getUserNo());
		
		OrdersImg oi = null;
		if(upfile != null && !upfile.isEmpty()) {
			String webPath = "/resources/images/Orders/";
			String serverFolderPath = application.getRealPath(webPath);
			
			// 디렉토리가 존재하지 않는다면 생성하는 코드 추가
			File dir = new File(serverFolderPath);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			// 사용자가 등록한 첨부파일의 이름을 수정
			String changeName = Utils.saveFile(upfile, serverFolderPath);
		
			oi = new OrdersImg();
			oi.setOrderNo(o.getOrderNo());
			oi.setChangeName(changeName);
			oi.setOriginName(upfile.getOriginalFilename());
		}
		
		
		int result = 0;
		try {
			result = orderService.insertOrder(o , oi);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		String url = "";
        if(result > 0) {
            ra.addFlashAttribute("alertMsg" , "글 작성 성공");
            url = "redirect:/order/orderInsert";
        } else {
            model.addAttribute("errorMsg" , "게시글 작성 실패");
            url = "common/errorPage";
        }   
        return url;
	}
	
	
	@GetMapping("/noticeboard")
	public String boardPage(
			Model model
			) {
		List<Order> list = orderService.selectOrderList();
		
		application.setAttribute("list", list);
		
		return "order/noticeboard";
	}
	
	@GetMapping("/detailProduct/{orderNo}")
	public String detailProduct(
			@PathVariable("orderNo") int orderNo,
			Model model,
			@ModelAttribute("loginUser") User loginUser,
			HttpServletRequest req,
			HttpServletResponse res
			) {
		Order o  = orderService.selectOrderOne(orderNo);
		o.setOrdersImg(orderService.selectOrdersImg(orderNo));
		
		model.addAttribute("order", o);
		
		return "order/detailProduct";
	}
	
	/* 삭제 기능 */
	@PostMapping("/del/{orderNo}")
	@ResponseBody
	public String deleteOrder(@PathVariable("orderNo") int orderNo) {
		int result = orderService.deleteOrder(orderNo);
		return result > 0 ? "success" : "fail";
	}

	@PostMapping("/deleteAll")
	@ResponseBody
	public String deleteAllOrders(@ModelAttribute("loginUser") User loginUser) {
		int result = orderService.deleteAllOrdersByUser(loginUser.getUserNo());
		return result > 0 ? "success" : "fail";
	}
	
	@GetMapping("/orderAccept")
	public String orderAccept(
			@ModelAttribute("loginUser") User loginUser,
			Order o,
			Model model,
			RedirectAttributes ra
			) {
		
		Rider rider = userService.selectRiderOne(loginUser.getUserNo());
		
		o.setRiderNo(rider.getRiderNo());
		
		LocalDate localDate = LocalDate.now();
		o.setStartDate(Date.valueOf(localDate));
		
		o.setOrderStatus("배달중");
		
		int result = orderService.updateOrderStatus(o);
		
		String url = "";
        if(result > 0) {
            ra.addFlashAttribute("alertMsg" , "주문 수락 성공");
            url = "redirect:/order/detailProduct";
        } else {
            model.addAttribute("errorMsg" , "주문 수락 실패");
            url = "common/errorPage";
        }   
        
        model.addAttribute("order", o);
        
        return url;
	}
	
	@GetMapping("/orderEnd")
	public String orderEnd(
			@ModelAttribute("loginUser") User loginUser,
			Order o,
			Model model,
			RedirectAttributes ra
			) {
		
		Rider rider = userService.selectRiderOne(loginUser.getUserNo());
		
		o.setRiderNo(rider.getRiderNo());
		
		LocalDate localDate = LocalDate.now();
		o.setEndDate(Date.valueOf(localDate));
		
		o.setOrderStatus("배달완료");
		
		int result = orderService.updateOrderStatus(o);
		
		String url = "";
        if(result > 0) {
            ra.addFlashAttribute("alertMsg" , "배달 완료 알림 성공");
            url = "redirect:/order/detailProduct";
        } else {
            model.addAttribute("errorMsg" , "배달 완료 알림 실패");
            url = "common/errorPage";
        }   
        
        model.addAttribute("order", o);
        
        return url;
	}
	
}

