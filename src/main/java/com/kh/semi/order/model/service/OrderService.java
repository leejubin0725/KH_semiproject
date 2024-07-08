package com.kh.semi.order.model.service;

import java.util.List;

import com.kh.semi.order.model.vo.Order;


public interface OrderService {

//	int insertOrder(Orders o, OrderImg oi);

	int insertOrder(Order o);

	List<Order> selectOrderList();

	Order selectOrderOne(int orderNo);


}
