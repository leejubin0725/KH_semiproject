package com.kh.semi.order.model.service;

import java.util.List;
import java.util.Map;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.order.model.vo.Order;
import com.kh.semi.order.model.vo.OrdersImg;

public interface OrderService {

	int insertOrder(Order o, OrdersImg oi) throws Exception;

	List<Order> selectOrderList(PageInfo pi);

	Order selectOrderOne(int orderNo);

	OrdersImg selectOrdersImg(int orderNo);

	List<String> selectOrdersImgList();

	int deleteOrder(int orderNo);

	int deleteAllOrdersByUser(int userNo);

	List<Order> selectUrgentOrderList();

	int updateOrderStatus(Order o);

	int OrderRiderCount(int riderNo);

	List<Order> selectRiderOrderList(int riderNo);

	int OrderRiderCountComplete(int riderNo);

	int selectListCount(Map<String, Object> paramMap);

}
