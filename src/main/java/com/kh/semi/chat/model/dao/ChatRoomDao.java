package com.kh.semi.chat.model.dao;

import com.kh.semi.chat.model.vo.ChatRoom;

public interface ChatRoomDao {
	void insertChatRoom(ChatRoom chatRoom);
    ChatRoom selectChatRoomByOrderId(int orderId);
    int countChatRoomByOrderId(int orderId); // 새로 추가되는 메서드
}