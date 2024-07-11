package com.kh.semi.report.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Report {
	private int reportId;
	private String nickName;
	private String title;
	private String content;
	private Date reportDate;
}
