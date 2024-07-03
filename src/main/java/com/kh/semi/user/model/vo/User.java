package com.kh.semi.user.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
	private int userNo;
	private String email;
	private String password;
	private String nickname;
	private String birth;
	private String gender;
	private String phone;
	private String address;
	private Date createDate;
	private String role;
	private String status;
	private Date updateDate;
	private String profileImage;
}
