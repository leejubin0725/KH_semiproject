package com.kh.semi.order.model.dao;

import java.util.List;

import com.kh.semi.order.model.vo.Order;

public interface OrderDao {
	

	int insertOrder(Order o);

	List<Order> selectOrderList();

	Order selectOrderOne(int orderNo);

    int deleteOrder(int orderNo);
    
    int deleteAllOrdersByUser(int userNo);  // 추가된 메소드
}
