package com.kh.semi.chat.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.semi.chat.model.vo.ChatRoom;


@Repository
public class ChatRoomDaoImpl implements ChatRoomDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public void insertChatRoom(ChatRoom chatRoom) {
        sqlSession.insert("com.kh.semi.chat.mapper.ChatRoomMapper.insertChatRoom", chatRoom);
    }

    @Override
    public ChatRoom selectChatRoomByOrderId(int orderId) {
        return sqlSession.selectOne("com.kh.semi.chat.mapper.ChatRoomMapper.selectChatRoomByOrderId", orderId);
    }
    @Override
    public int countChatRoomByOrderId(int orderId) {
        return sqlSession.selectOne("com.kh.semi.chat.mapper.ChatRoomMapper.countChatRoomByOrderId", orderId);
    }
}