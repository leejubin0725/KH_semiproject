package com.kh.semi.chat.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatRoom {
    private int chatRoomId;
    private int orderId;
    private String password;
}
