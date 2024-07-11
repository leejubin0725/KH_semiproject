package com.kh.semi.chat.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.semi.chat.model.dao.MessageDao;
import com.kh.semi.chat.model.vo.Message;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageDao messageDao;

    @Override
    public void saveMessage(Message message) {
        messageDao.insertMessage(message);
    }

    @Override
    public List<Message> getMessagesByChatRoomId(int chatRoomId) {
        return messageDao.selectMessagesByChatRoomId(chatRoomId);
    }
}
