package com.kh.semi.order.model.dao;

import java.util.List;

import com.kh.semi.order.model.vo.Order;

public interface OrderDao {

	int insertOrder(Order o);

	List<Order> selectOrderList();

	Order selectOrderOne(int orderNo);


}
