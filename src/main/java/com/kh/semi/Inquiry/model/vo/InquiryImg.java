package com.kh.semi.Inquiry.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode
@AllArgsConstructor
public class InquiryImg {
	private int imgNo;
	private int inquiryNo;
	private String originName;
	private String changeName;
}
