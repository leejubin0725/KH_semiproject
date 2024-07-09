package com.kh.semi.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.semi.order.model.vo.Order;
import com.kh.semi.order.model.vo.OrdersImg;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OrderDaoImpl implements OrderDao{

	private final SqlSession sqlSession;
	
	@Override
	public int insertOrder(Order o) {
		return sqlSession.insert("Orders.insertOrder", o);
	}

	@Override
	public List<Order> selectOrderList() {
		return sqlSession.selectList("Orders.selectOrderList");
	}

	@Override
	public Order selectOrderOne(int orderNo) {
		return sqlSession.selectOne("Orders.selectOrderOne" , orderNo);
	}
	
    @Override
    public int deleteOrder(int orderNo) {
        return sqlSession.delete("Orders.deleteOrder", orderNo);
    }

    @Override
    public int deleteAllOrdersByUser(int userNo) {
        return sqlSession.delete("Orders.deleteAllOrdersByUser", userNo);
    }

	@Override
	public int insertOrdersImg(OrdersImg oi) {
		return sqlSession.insert("Orders.insertOrdersImg" , oi);
	}

	@Override
	public OrdersImg selectOrdersImg(int orderNo) {
		return sqlSession.selectOne("Orders.selectOrdersImg" , orderNo);
	}

	@Override
	public List<String> selectOrdersImgList() {
		return sqlSession.selectList("Orders.selectOrdersImgList");
	}

	@Override
	public List<Order> selectUrgentOrderList() {
		return sqlSession.selectList("Orders.selectUrgentOrderList");
	}

}
