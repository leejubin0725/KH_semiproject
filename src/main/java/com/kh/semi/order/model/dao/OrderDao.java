package com.kh.semi.order.model.dao;

import java.util.List;

import com.kh.semi.order.model.vo.Order;
import com.kh.semi.order.model.vo.OrdersImg;

public interface OrderDao {
	

	int insertOrder(Order o);
	
	int insertOrdersImg(OrdersImg oi);

	List<Order> selectOrderList();

	Order selectOrderOne(int orderNo);

	OrdersImg selectOrdersImg(int orderNo);

	List<String> selectOrdersImgList();

}
