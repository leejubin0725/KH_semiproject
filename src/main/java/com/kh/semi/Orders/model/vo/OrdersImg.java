package com.kh.semi.Orders.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data 
@NoArgsConstructor
@EqualsAndHashCode
@AllArgsConstructor
public class OrdersImg {
	private int imgNo;
	private int orderNo;
	private String originName;
	private String changeName;
	
}
