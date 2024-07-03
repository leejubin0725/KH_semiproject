package com.kh.semi.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;
import com.kh.semi.user.model.vo.Vehicle;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserDaoImpl implements UserDao{
	
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertUser(User u) {
		return sqlSession.insert("user.insertUser" , u);
	}

	@Override
	public int insertRider(Rider r) {
		return sqlSession.insert("user.insertRider" , r);
	}

	@Override
	public int insertVehicle(Vehicle v) {
		return sqlSession.insert("user.insertVehicle" , v);
	}

}
