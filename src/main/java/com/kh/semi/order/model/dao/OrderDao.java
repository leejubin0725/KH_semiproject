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

    int deleteOrder(int orderNo);
    
    int deleteAllOrdersByUser(int userNo);  // 추가된 메소드

	List<Order> selectUrgentOrderList();

	int updateOrderStatus(Order o);

	int OrderRiderCount(int riderNo);

	List<Order> selectRiderOrderList(int riderNo);

	int OrderRiderCountComplete(int riderNo);

}
