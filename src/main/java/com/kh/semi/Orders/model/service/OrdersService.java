package com.kh.semi.Orders.model.service;

import java.util.List;

import com.kh.semi.Orders.model.vo.Order;


public interface OrdersService {

//	int insertOrder(Orders o, OrderImg oi);

	int insertOrder(Order o);

	List<Order> selectOrderList();

}
