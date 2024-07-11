package com.kh.semi.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.kh.semi.chat.model.vo.ChatRoom;
import com.kh.semi.chat.model.vo.Message;
import com.kh.semi.chat.service.ChatRoomService;
import com.kh.semi.chat.service.MessageService;

import java.util.List;

@Controller
@RequestMapping("/chatRoom")
public class ChatRoomController {

    @Autowired
    private ChatRoomService chatRoomService;

    @Autowired
    private MessageService messageService;

    @PostMapping(value = "/create", produces = MediaType.TEXT_PLAIN_VALUE + ";charset=UTF-8")
    @ResponseBody
    public String createChatRoom(@RequestParam("orderId") int orderId, @RequestParam("password") String password) {
        try {
            ChatRoom chatRoom = new ChatRoom();
            chatRoom.setOrderId(orderId);
            chatRoom.setPassword(password);
            chatRoomService.createChatRoom(chatRoom);
            return "채팅방이 성공적으로 생성되었습니다.";
        } catch (IllegalStateException e) {
            return e.getMessage();
        }
    }

    @GetMapping("/join")
    public String joinChatRoom(@RequestParam("orderId") int orderId, @RequestParam("password") String password, Model model) {
        ChatRoom chatRoom = chatRoomService.getChatRoomByOrderId(orderId);
        if (chatRoom != null && chatRoom.getPassword().equals(password)) {
            model.addAttribute("chatRoomId", chatRoom.getChatRoomId());
            List<Message> messages = messageService.getMessagesByChatRoomId(chatRoom.getChatRoomId());
            model.addAttribute("messages", messages);
            return "chat/chat";
        } else {
            return "error/invalid-room";
        }
    }
}
