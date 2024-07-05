package com.kh.semi.user.model.dao;

import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;
import com.kh.semi.user.model.vo.Vehicle;

public interface UserDao {

	int insertUser(User u);

	int insertRider(Rider r);

	int insertVehicle(Vehicle v);

	User login(User u);

	int updateUser(User u);

	int idCheck(String email);
	
}
