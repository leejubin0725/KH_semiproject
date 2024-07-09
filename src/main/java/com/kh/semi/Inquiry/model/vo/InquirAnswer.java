package com.kh.semi.Inquiry.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class InquirAnswer {
	private int answerNo;
	private String answerWriter;
	private String answerContent;
	private int inquiryNo;
	private Date createDate;
	private String userNickname;
	private String status;
}
