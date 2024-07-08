package com.kh.semi.Inquiry.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.Inquiry.model.vo.Inquiry;
import com.kh.semi.Inquiry.model.vo.InquiryCategory;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InquiryDaoImpl implements InquiryDao{
   
   private final SqlSessionTemplate sqlSession;

   @Override
   public int insertInquiry(Inquiry i) {
      return sqlSession.insert("inquiry.insertInquiry", i);
   }

   @Override
   public List<Inquiry> inquiryList() {
      return sqlSession.selectList("inquiry.inquiryList");
   }

   @Override
   public List<InquiryCategory> inquiryCategoryList() {
      return sqlSession.selectList("inquiry.inquiryCategoryList");
   }

   @Override
   public Inquiry selectInquiryNo(int inquiryNo) {
      return sqlSession.selectOne("inquiry.selectInquiryNo", inquiryNo);
   }

}