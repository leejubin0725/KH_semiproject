package com.kh.semi.order.model.service;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.semi.order.model.dao.OrderDao;
import com.kh.semi.order.model.vo.Order;
import com.kh.semi.order.model.vo.OrdersImg;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class OrderServiceImpl implements OrderService {
	
	private final OrderDao orderDao;

	@Override
	@Transactional (rollbackFor = {Exception.class}) 
	public int insertOrder(Order o , OrdersImg oi) throws Exception {	
		int result = orderDao.insertOrder(o);
		
		if(oi != null) {
			oi.setOrderNo(o.getOrderNo());
			result *= orderDao.insertOrdersImg(oi);
		}
		
		if(result == 0) {
			throw new Exception("예외 발생");
		}
		
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

	@Override
	public OrdersImg selectOrdersImg(int orderNo) {
		return orderDao.selectOrdersImg(orderNo);
	}

}
