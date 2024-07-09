package com.kh.semi.user.model.dao;

import java.util.List;

import com.kh.semi.order.model.vo.Order;
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

   String idfind(String phone);

   String pwfind(String birth, String email);

   int updatepw(String encPwd, String email);

   List<Order> selectMyPostList(int userNo);

   /* 삭제 기능 */
   void deleteAllChatRoomJoinsByUser(int userNo);

   void deleteAllOrdersByUser(int userNo);

   void deleteAllChatRoomJoinsByChatRoom(int userNo);

   void deleteAllChatsByUser(int userNo);

   void deleteAllVehiclesByRider(int userNo);

   void deleteAllRidersByUser(int userNo);

   int deleteUser(int userNo);
}
