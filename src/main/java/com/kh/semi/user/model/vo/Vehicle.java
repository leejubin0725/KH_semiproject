package com.kh.semi.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Vehicle {
	private int riderNo;
	private String vehicle;
	private int maxDistance;
}
