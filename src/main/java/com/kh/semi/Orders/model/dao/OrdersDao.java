package com.kh.semi.Orders.model.dao;

import java.util.List;

import com.kh.semi.Orders.model.vo.Order;

public interface OrdersDao {

	int insertOrder(Order o);

	List<Order> selectOrderList();

}
