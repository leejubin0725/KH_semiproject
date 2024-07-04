package com.kh.semi.Orders.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.semi.Orders.model.vo.Order;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OrdersDaoImpl implements OrdersDao{

	private final SqlSession sqlSession;
	
	@Override
	public int insertOrder(Order o) {
		return sqlSession.insert("order.insertOrder", o);
	}

	@Override
	public List<Order> selectOrderList() {
		return sqlSession.selectList("order.selectOrderList");
	}

}
