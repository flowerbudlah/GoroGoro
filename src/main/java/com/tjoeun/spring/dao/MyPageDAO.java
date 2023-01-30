package com.tjoeun.spring.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.tjoeun.spring.dto.ReportDTO;

@Repository
public class MyPageDAO {

	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	//8. 1) 관리자가 신고된 게시물보기
	public List<ReportDTO> takeMyReportedPost(String reporter, RowBounds rowBounds){
		return sqlSessionTemplate.selectList("myPage.takeMyReportedPost", reporter, rowBounds);
	}
	
	
	//8. 2) 신고된 게시글 상세보기
	public ReportDTO readReportDTO(int reportNo) {
		ReportDTO readReportDTO = sqlSessionTemplate.selectOne("myPage.readReportDTO", reportNo);  
		return readReportDTO; 
	}
	
	
	//4. 특정 글 삭제하기 Delete
	public int deleteReportDTO(int reportNo) throws Exception {
		return sqlSessionTemplate.delete("myPage.deleteReportDTO", reportNo); 
	}


	
	
	
	
}
