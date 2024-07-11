package com.kh.semi.order.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data 
@NoArgsConstructor
@EqualsAndHashCode
@AllArgsConstructor
public class Review {

	private int riderNo;
	private int orderNo;
	private String reviewContent;
	private Date createDate;
	private int rating;
	private String writer;
	
}
