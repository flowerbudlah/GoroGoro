package com.tjoeun.spring.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.dto.ReportDTO;

@Repository
public class MyPageDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//8. 1) 관리자가 신고된 게시물들 리스트로 보기
	public List<ReportDTO> takeMyReportedPost(String reporter, RowBounds rowBounds){
		return sqlSessionTemplate.selectList("myPage.takeMyReportDTO", reporter, rowBounds);
	}

	//1. 2) 해당 신고게시판에 있는 전체 신고된 건의 수(페이지 작업때문에 필요함.)
	public int getReportCnt(String reporter) {
		int reportCnt = sqlSessionTemplate.selectOne("myPage.getReportCnt", reporter);
		return reportCnt;
	}
	
	//"내가 신고한 게시판"에서 검색하기
	public List<PostDTO> searchReportList(ReportDTO searchListReportDTO, RowBounds rowBounds) throws Exception {
				
		List<PostDTO> searchReportList 
		= sqlSessionTemplate.selectList("myPage.searchReportList", searchListReportDTO, rowBounds);
		return searchReportList; 
	}	
	
	//검색 시 검색결과 수(페이징 작업때문에 필요) 
	public int searchReportCount(ReportDTO searchListReportDTO) {
		int searchReportCount = sqlSessionTemplate.selectOne("myPage.searchReportCount", searchListReportDTO);
		return searchReportCount; 
	}
	
	
	
	//8. 2) 신고된 게시글 상세보기(그리고 이 신고내역를 수정하고자 할때도 이것이 쓰인다.)
	public ReportDTO readReportDTO(int reportNo) {
		ReportDTO readReportDTO = sqlSessionTemplate.selectOne("myPage.readReportDTO", reportNo);  
		return readReportDTO; 
	}
	

	//3. 2)신고내역 수정하기(신고한자만 가능)
	public int modifyReportTO(ReportDTO modifyReportDTO){
		return sqlSessionTemplate.update("myPage.modifyReportDTO", modifyReportDTO);
	}
	
	
	//5. 2) 글 수정시 아예 이미지 파일을 없애는 쿼리
	public int deleteImageFile(ReportDTO imageFileReportDTO) {
		return sqlSessionTemplate.update("myPage.deleteImageFile", imageFileReportDTO);
	}
	

	
	
	
	
	
	//4. 특정 글 삭제하기 Delete
	public int deleteReportDTO(int reportNo) throws Exception {
		return sqlSessionTemplate.delete("myPage.deleteReportDTO", reportNo); 
	}

	//5. 내가 쓴 글 검색
	public List<PostDTO> searchList(PostDTO searchListPostDTO, RowBounds rowBounds) throws Exception {
				
		List<PostDTO> searchList = sqlSessionTemplate.selectList("myPage.searchList", searchListPostDTO, rowBounds);
		return searchList; 
			
	}	
	
	//아작스로 검색 시 검색결과 수(아작스로 페이징 작업때문에 필요) 
	public int searchCount(PostDTO searchListPostDTO) {
		int searchCount = sqlSessionTemplate.selectOne("myPage.searchCount", searchListPostDTO);
		return searchCount; 
	}
		

	//7.1) 마이페이지에서 내가 쓴 게시물보기
	public List<PostDTO> goMyPosts(int memberNo, RowBounds rowBounds){
		List<PostDTO> myPostList = sqlSessionTemplate.selectList("myPage.goMyPosts", memberNo, rowBounds); 
		return myPostList;
	}
	
	
	//7. 2) 마이페이지의 내가 쓴글 그 해당 게시판에 있는 전체게시물의 수(페이지 작업때문에 필요함.)
	public int takeCountOfMyPost(int memberNo) {
		int countOfMyPost = sqlSessionTemplate.selectOne("myPage.takeCountOfMyPost", memberNo);
		return countOfMyPost;
	}
	
	

	
}