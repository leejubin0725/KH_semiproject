package com.kh.semi.Inquiry.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Inquiry {
	private int inquiryNo;
	private int userNo;
	private int categoryNo;
	private String title;
	private String content;
	private Date createDate;
	private Date updateDate;
}
