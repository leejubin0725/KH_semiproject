package com.kh.semi.report.model.dao;

import java.util.List;

import com.kh.semi.report.model.vo.Report;

public interface ReportDao {

	int save(Report re);

	List<Report> selectReportList();
}
