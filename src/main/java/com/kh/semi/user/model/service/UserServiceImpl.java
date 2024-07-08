package com.kh.semi.user.model.service;

import org.springframework.stereotype.Service;

import com.kh.semi.user.model.dao.UserDao;
import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;
import com.kh.semi.user.model.vo.Vehicle;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

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

	@Override
	public User login(User u) {
		return dao.login(u);
	}

	@Override
	public int updateUser(User u) {
		return dao.updateUser(u);
	}

	@Override
	public int idCheck(String email) {
		return dao.idCheck(email);
	}

	@Override
	public String idfind(String phone) {
		return dao.idfind(phone);

	}

	@Override
	public String pwfind(String birth, String email) {
		return dao.pwfind(birth, email);
	}

	@Override
	public int updatepw(String encPwd, String email) {
		return dao.updatepw(encPwd, email);
	}
}
