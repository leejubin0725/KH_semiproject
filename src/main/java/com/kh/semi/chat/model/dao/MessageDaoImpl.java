package com.kh.semi.chat.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.semi.chat.model.vo.Message;

import java.util.List;

@Repository
public class MessageDaoImpl implements MessageDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public void insertMessage(Message message) {
        sqlSession.insert("com.kh.semi.chat.model.dao.MessageDao.insertMessage", message);
    }

    @Override
    public List<Message> selectMessagesByChatRoomId(int chatRoomId) {
        return sqlSession.selectList("com.kh.semi.chat.model.dao.MessageDao.selectMessagesByChatRoomId", chatRoomId);
    }
}
