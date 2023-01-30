package com.tjoeun.spring.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;


import com.tjoeun.spring.dao.MyPageDAO;

import com.tjoeun.spring.dto.ReportDTO;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class MyPageService {

	@Value("${page.listcnt}")
	private int page_listcnt; // 한 페이지당 보여주는 글의 개수
	
	@Value("${page.paginationcnt}")
	private int page_paginationcnt;	// 한 페이지당 보여주는 페이지 버튼 개수
	
	
	@Autowired
	private MyPageDAO myPageDAO; 

	
	public List<ReportDTO> takeMyReportedPost(String reporter, int page){
			
		int start = (page - 1) * page_listcnt; //한 페이지 
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		
		return myPageDAO.takeMyReportedPost(reporter, rowBounds);
	} 
	
	//7. 2) 신고된 특정한 글 하나 보기(신고의 구체적인 사유)
	public ReportDTO readReportDTO(int reportNo) {
		
		ReportDTO readReportDTO = myPageDAO.readReportDTO(reportNo);
		return readReportDTO;
		
	}

	
	//5. 오직 신고자만 신고내용 삭제가능
	public ReportDTO deleteReportDTO(int reportNo) throws Exception {
		
		ReportDTO reportDTO = new ReportDTO();
		
		int deleteCnt = myPageDAO.deleteReportDTO(reportNo);

		if (deleteCnt > 0) {
			reportDTO.setResult("SUCCESS");
		} else {
			reportDTO.setResult("FAIL");
		}
		return reportDTO;
		
	}
	
	
	
	

	
}
