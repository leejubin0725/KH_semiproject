package com.kh.semi.chat.service;

import com.kh.semi.chat.model.vo.Message;

import java.util.List;

public interface MessageService {
    void saveMessage(Message message);
    List<Message> getMessagesByChatRoomId(int chatRoomId);
}
