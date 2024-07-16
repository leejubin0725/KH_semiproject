package com.kh.semi.order.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import java.util.List;
import java.util.Map;



import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.order.model.vo.Order;
import com.kh.semi.order.model.vo.OrdersImg;import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.semi.common.model.vo.PageInfo;
import com.kh.semi.order.model.vo.Order;
import com.kh.semi.order.model.vo.OrdersImg;

import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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

	@Override
	public int updateOrderStatus(Order o) {
		return sqlSession.update("Orders.updateOrderStatus" , o);
	}

	@Override
	public int OrderRiderCount(int riderNo) {
		return sqlSession.selectOne("Orders.OrderRiderCount" , riderNo);
	}

	@Override
	public List<Order> selectRiderOrderList(int riderNo) {
		return sqlSession.selectList("Orders.selectRiderOrderList" , riderNo);
	}

	@Override
	public int OrderRiderCountComplete(int riderNo) {
		return sqlSession.selectOne("Orders.OrderRiderCountComplete" , riderNo);
	}

	@Override
   public int selectOrderListConut(Map<String, Object> paramMap) {
      return sqlSession.selectOne("Orders.selectOrderListConut", paramMap);
   }


	@Override
	public List<Order> selectOrderList(PageInfo pi) {
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		int limit  = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("Orders.selectOrderList", pi, rowBounds);
	}

	
}
