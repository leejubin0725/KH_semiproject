package com.kh.semi.chat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.semi.chat.model.vo.ChatRoom;
import com.kh.semi.chat.model.vo.Message;
import com.kh.semi.chat.service.ChatRoomService;
import com.kh.semi.chat.service.MessageService;
import com.kh.semi.user.model.vo.User;

@Controller
@RequestMapping("/chatRoom")
public class ChatRoomController {

    @Autowired
    private ChatRoomService chatRoomService;

    @Autowired
    private MessageService messageService;

    @PostMapping("/enter")
    public String enterChatRoom(@RequestParam("orderId") int orderId, @RequestParam("password") String password, Model model, HttpSession session, RedirectAttributes ra) {
        ChatRoom chatRoom = chatRoomService.getChatRoomByOrderId(orderId);
        
        if (chatRoom == null) {
            // 채팅방이 없으면 생성
            chatRoom = new ChatRoom();
            chatRoom.setOrderId(orderId);
            chatRoom.setPassword(password);
            chatRoomService.createChatRoom(chatRoom);
        } else if (!chatRoom.getPassword().equals(password)) {
            // 비밀번호가 맞지 않으면 에러 메시지 추가
        	 ra.addFlashAttribute("errorMessage", "비밀번호가 틀렸습니다.");
             return "redirect:/order/detailProduct/" + orderId;
        }
        
        model.addAttribute("chatRoomId", chatRoom.getChatRoomId());
        
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser != null) {
            model.addAttribute("nickName", loginUser.getNickname());
        } else {
            return "error/unauthorized";
        }
        
        List<Message> messages = messageService.getMessagesByChatRoomId(chatRoom.getChatRoomId());
        model.addAttribute("messages", messages);
        
        return "chat/chat";
    }
    
    
    @GetMapping("/password")
    @ResponseBody
    public String getPassword(@RequestParam("orderId") int orderId) {
        ChatRoom chatRoom = chatRoomService.getChatRoomByOrderId(orderId);
        if (chatRoom != null) {
            return chatRoom.getPassword();
        } else {
            return "방을 찾을 수 없습니다.";
        }
    }




}
