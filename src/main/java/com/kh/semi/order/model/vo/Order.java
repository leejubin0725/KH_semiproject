package com.kh.semi.order.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Order {
	private int orderNo;
    private int userNo;
    private String orderTitle;
    private String orderContent;
    private String categoryMain;
    private String alertFragile;
    private String alertValuable;
    private String alertUrgent;
    private String startPoint;
    private String endPoint;
    private Date createDate;
    private String orderStatus;
    private int distance;
    private int price;
    private Date startDate;
    private Date endDate;
 
}
