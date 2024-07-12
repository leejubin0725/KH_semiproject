package com.kh.semi.order.controller;

import java.io.File;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
			@RequestParam("orderNo") int orderNo,
			Order o,
			Model model,
			RedirectAttributes ra
			) {
		
		Rider rider = userService.selectRiderOne(loginUser.getUserNo());
		
		o.setOrderNo(orderNo);
		o.setRiderNo(rider.getRiderNo());
		
		o.setOrderStatus("배달중");
		
		int result = orderService.updateOrderStatus(o);
		
		String url = "";
        if(result > 0) {
            ra.addFlashAttribute("alertMsg" , "주문 수락 성공");
            url = "redirect:/order/detailProduct/" + orderNo;
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
			@RequestParam("orderNo") int orderNo,
			Order o,
			Model model,
			RedirectAttributes ra
			) {
		
		Rider rider = userService.selectRiderOne(loginUser.getUserNo());
		
		o.setOrderNo(orderNo);
		o.setRiderNo(rider.getRiderNo());
		
		o.setOrderStatus("배달완료");
		
		int result = orderService.updateOrderStatus(o);
		
		String url = "";
        if(result > 0) {
            ra.addFlashAttribute("alertMsg" , "배달 완료 알림 성공");
            url = "redirect:/order/detailProduct/" + orderNo;
        } else {
            model.addAttribute("errorMsg" , "배달 완료 알림 실패");
            url = "common/errorPage";
        }   
        
        model.addAttribute("order", o);
        
        return url;
	}
	
	@GetMapping("/riderOrderSelect")
	public String riderOrderSelect(
			@ModelAttribute("loginUser") User loginUser,
			Model model,
			RedirectAttributes ra,
			Order o
			) {

		Rider rider = userService.selectRiderOne(loginUser.getUserNo());
		
		List<Order> riderOrders = orderService.selectRiderOrderList(rider.getRiderNo());
		
		int orderNo = 0;
		for(Order temp : riderOrders) {
			if(temp.getOrderStatus().equals("배달중")) {
				orderNo = temp.getOrderNo();
			}
		}
		
		if(orderNo == 0) {
			ra.addFlashAttribute("alertMsg" , "현재 배달중인 목록이 없습니다.");
			return "redirect:/user/mypage/";
		} else {
			return "redirect:/order/detailProduct/" + orderNo;
		}
	
	}
	
	@GetMapping("riderOrderSelectAjax")
	@ResponseBody
	public int riderOrderSelectAjax(@ModelAttribute("loginUser") User loginUser,
			@RequestParam("orderRiderNo") int orderRiderNo) {

		/*
		 * orderRiderNo 넘어온 상태인데
		 * null 인경우주문ㅇ을 안 받은 상태
		 * null 이 아닌 경우 주문을 받은 상태
		 * 
		 * 로그인 유저에서 라이더 번호를 뽑아옴
		 * null 인 경우
		 * null 이 아닌 경우 - 라이더
		 * 
		 * orderRiderNo가 null 이고 , 로그인 라이더가 null - 주문을 못받았고 , 다른 고객인 본 상태 -> 버튼 막기
		 * orderRiderNo가 null 이고 , 로그인 라이더가 null이 아님 - 주문을 받지 않은 상태 -> 받기 가능 + 유효성 검사
		 * 
		 * orderRiderNo null이 아니고 , 로그인 라이더가 null - 주문연결은 됐는데 , 다른 고객인 본 상태 -> 버튼 막기
		 * orderRiderNo null이 아니고 , 로그인 라이더가 null이 아님
		 * 
		 * 1. orderRiderNo == 로그인 라이더 번호 -> 배달중인 상태 -> 배달 완료
		 * 2. orderRiderNo != 로그인 라이더 번호 -> 배달중인데 , 다른 라이더 봄 -> 막기
		 * 
		 * 
		 * 1. 로그인 라이더가 null 이면 -> 무조건 버튼을 막기
		 * 2. 로그인 라이더 + 주문 null 상태 -> 유효성 검사를 통해 주문 수락 버튼 보이기
		 * 3. 로그인 라이더 + 주문 있는 상태 + (주문 라이더 정보와 일치) -> 배송 완료 버튼
		 * 4. 로그인 라이더 + 주문 있는 상태 + (주문 라이더 정보와 불일치) -> 버튼을 막기
		 * 5. 배송 완료 상태 - > 버튼을 막기
		 * 
		 * 1. status + 로그인 라이더 정보로 거르기 (1,5)
		 * 2. 주문이 null 이면 , 로그인에서 받아온 유저 번호를 서비스에게 넘겨서 유효성 검사 후 주문 받기
		 * 3. 주문이 있고 , 라이더와 일치하면 완료
		 * 4. 주문이 있고 , 라이더와 불일치하면 막기
		 * 
		 */
		
		Rider rider = userService.selectRiderOne(loginUser.getUserNo());
		int userRiderNo = rider.getRiderNo();
		
		if(orderRiderNo == 0) {
			return (orderService.OrderRiderCount(userRiderNo) > 0) ? 0 : userRiderNo;
		} else {
			return userRiderNo;
		}

	}
	
}

