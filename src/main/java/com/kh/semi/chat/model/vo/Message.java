package com.kh.semi.chat.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Message {
    private int id;
    private int chatRoomId;
    private int senderId;
    private String content;
}