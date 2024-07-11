package com.kh.semi.chat.service;

import com.kh.semi.chat.model.vo.ChatRoom;

public interface ChatRoomService {
    void createChatRoom(ChatRoom chatRoom);
    ChatRoom getChatRoomByOrderId(int orderId);
}
