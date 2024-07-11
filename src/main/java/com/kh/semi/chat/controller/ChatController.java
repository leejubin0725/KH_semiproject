package com.kh.semi.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.semi.chat.model.vo.Message;
import com.kh.semi.chat.service.MessageService;

import java.util.List;

@Controller
public class ChatController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    private MessageService messageService;

    @MessageMapping("/sendMessage")
    public void sendMessage(Message message) {
        // 메시지의 senderId를 클라이언트에서 받은 senderId로 설정
        if (message.getSenderId() == 0) {
            throw new IllegalStateException("User is not logged in.");
        }

        // 메시지를 데이터베이스에 저장
        messageService.saveMessage(message);

        // 특정 채팅방의 주제로 메시지 전송
        messagingTemplate.convertAndSend("/topic/messages/" + message.getChatRoomId(), message);
    }

    @GetMapping("/messages")
    @ResponseBody
    public List<Message> getMessages(@RequestParam int chatRoomId) {
        return messageService.getMessagesByChatRoomId(chatRoomId);
    }
}
