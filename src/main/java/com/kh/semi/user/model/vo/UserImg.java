package com.kh.semi.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class UserImg {
	private int imgNo;
	private String originName;
	private String changeName;
	private int userNo;
}
