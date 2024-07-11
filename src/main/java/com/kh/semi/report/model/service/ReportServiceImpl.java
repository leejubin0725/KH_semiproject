package com.kh.semi.report.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.semi.report.model.dao.ReportDao;
import com.kh.semi.report.model.vo.Report;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService{
	
	private final ReportDao reportdao;
	
	@Override
	public int save(Report re) {
		return reportdao.save(re);
	}
	
	@Override
	public List<Report> selectReportList() {
		return reportdao.selectReportList();
	}

}
