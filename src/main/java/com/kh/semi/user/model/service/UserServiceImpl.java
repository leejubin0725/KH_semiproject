package com.kh.semi.user.model.service;

import org.springframework.stereotype.Service;

import com.kh.semi.user.model.dao.UserDao;
import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;
import com.kh.semi.user.model.vo.Vehicle;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{

	private final UserDao dao;
	
	@Override
	public int insertUser(User u) {
		return dao.insertUser(u);
	}

	@Override
	public int insertRider(Rider r) {
		return dao.insertRider(r);
	}

	@Override
	public int insertVehicle(Vehicle v) {
		return dao.insertVehicle(v);
	}
	
}
