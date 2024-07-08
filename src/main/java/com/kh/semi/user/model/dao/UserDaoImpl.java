package com.kh.semi.user.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.semi.user.model.vo.Rider;
import com.kh.semi.user.model.vo.User;
import com.kh.semi.user.model.vo.Vehicle;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserDaoImpl implements UserDao {

	private final SqlSessionTemplate sqlSession;

	@Override
	public int insertUser(User u) {
		return sqlSession.insert("user.insertUser", u);
	}

	@Override
	public int insertRider(Rider r) {
		return sqlSession.insert("user.insertRider", r);
	}

	@Override
	public int insertVehicle(Vehicle v) {
		return sqlSession.insert("user.insertVehicle", v);
	}

	@Override
	public User login(User u) {
		return sqlSession.selectOne("user.login", u);
	}

	@Override
	public int updateUser(User u) {
		return sqlSession.update("user.updateUser", u);
	}

	@Override
	public int idCheck(String email) {
		return sqlSession.selectOne("user.idCheck", email);
	}

	@Override
	public String idfind(String phone) {
		return sqlSession.selectOne("user.idfind", phone);
	}

	@Override
	public String pwfind(String birth, String email) {

		Map<String, String> params = new HashMap<>();
		params.put("birth", birth);
		params.put("email", email);
		
		return sqlSession.selectOne("user.pwfind", params);
	}

	@Override
	@Transactional

	public int updatepw(String encPwd, String email) {
		// MyBatis 매퍼에 전달할 파라미터 준비
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("encPwd", encPwd);
		parameters.put("email", email);

		// MyBatis 매퍼 호출하여 SQL 실행
		return sqlSession.update("user.pwupdate", parameters);
	}

}
