package com.kh.semi.chat.model.dao;

import com.kh.semi.chat.model.vo.Message;
import java.util.List;

public interface MessageDao {
    void insertMessage(Message message);
    List<Message> selectMessagesByChatRoomId(int chatRoomId);
}
