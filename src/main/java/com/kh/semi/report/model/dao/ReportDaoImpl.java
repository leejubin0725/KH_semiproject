package com.kh.semi.report.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.report.model.vo.Report;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReportDaoImpl implements ReportDao{
	private final SqlSession sqlSession;
	
	@Override
	public int save(Report re) {
	return sqlSession.insert("report.saveReport", re);
	}

	@Override
	public List<Report> selectReportList() {
		return sqlSession.selectList("report.selectReportList");
	}
	

}
