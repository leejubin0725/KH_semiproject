package com.kh.semi.chat.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.semi.chat.model.dao.ChatRoomDao;
import com.kh.semi.chat.model.vo.ChatRoom;

@Service
public class ChatRoomServiceImpl implements ChatRoomService {

    @Autowired
    private ChatRoomDao chatRoomDao;

    @Override
    public void createChatRoom(ChatRoom chatRoom) {
        if (chatRoomDao.countChatRoomByOrderId(chatRoom.getOrderId()) == 0) {
            chatRoomDao.insertChatRoom(chatRoom);
        } else {
            throw new IllegalStateException("채팅방이 이미 존재합니다.");
        }
    }

    @Override
    public ChatRoom getChatRoomByOrderId(int orderId) {
        return chatRoomDao.selectChatRoomByOrderId(orderId);
    }
}
