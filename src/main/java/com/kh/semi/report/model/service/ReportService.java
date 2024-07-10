package com.kh.semi.report.model.service;

import java.util.List;


import com.kh.semi.report.model.vo.Report;

public interface ReportService {

	int save(Report re);

	List<Report> selectReportList();

}
