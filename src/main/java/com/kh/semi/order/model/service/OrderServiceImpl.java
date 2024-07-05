package com.kh.semi.order.model.service;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;

import com.kh.semi.order.model.dao.OrderDao;
import com.kh.semi.order.model.vo.Order;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class OrderServiceImpl implements OrderService {
	
	private final OrderDao orderDao;
	private final ServletContext application;
	
//	@Override
//	public int insertOrder(Orders o, OrderImg oi) {
//		
//		String orderTitle = o.getOrderTitle();
//		String orderContent = o.getOrderContent();
//		
//		int result = orderDao.insertOrder(o);
//		
//		int orderNo = o.getOrderNo();
//		if(oi != null) {
//			oi.setOrderNo(orderNo);
//			result *= orderDao.insertOrderImg(oi);
//		}
//		
//		if(result == 0) {
//			throw
//		}
//		
//		return result;
//	}

	@Override
	public int insertOrder(Order o) {
		String orderTitle = o.getOrderTitle();
		String orderContent = o.getOrderContent();
		
		int result = orderDao.insertOrder(o);
		
		return result;
	}

	@Override
	public List<Order> selectOrderList() {
		return orderDao.selectOrderList();
	}

	@Override
	public Order selectOrderOne(int orderNo) {
		return orderDao.selectOrderOne(orderNo);
	}

}
