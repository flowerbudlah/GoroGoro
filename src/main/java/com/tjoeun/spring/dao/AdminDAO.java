package com.tjoeun.spring.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.spring.dto.BoardDTO;
import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.dto.ReportDTO;

@Repository
public class AdminDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//1. 게시판 대분류 카테고리 생성 Create
	public void makeCategory(String boardCategoryName) {
		sqlSessionTemplate.insert("admin.makeCategory", boardCategoryName); 
	}
	
	//2. 대분류 카테고리에 속하는 진짜 게시판 이름과 인덱스 생성
	public void makeBoard(BoardDTO BoardDTOinCategory) {
		sqlSessionTemplate.insert("admin.makeBoard", BoardDTOinCategory); 
	}

	//3. 게시판 이름 변경 Updating
	public void changeBoardName(BoardDTO boardDTOinCategory) {
		sqlSessionTemplate.update("admin.changeBoardName", boardDTOinCategory); 
	}
	
	//4. 카테고리 삭제
	public void deleteCategory(int boardCategoryNo) {
		sqlSessionTemplate.delete("admin.deleteCategory", boardCategoryNo); 
	}	

	//5. 카테고리에 속한 게시판 삭제
	public void deleteBoard(int boardNo) {
		sqlSessionTemplate.delete("admin.deleteBoard", boardNo); 
	}
		
	//6. 1) 회원목록 가져오기
	public List<MemberDTO> takeMemberList() {
		return sqlSessionTemplate.selectList("admin.takeMemberList");
	}
	
	//6. 2) 특정한 한 회원이 쓴 글의 수 가져오기 
	public int postCount(String writer) {
		return sqlSessionTemplate.selectOne("admin.postCount", writer); 
	}
	
	//6. 3) 특정한 한 회원이 쓴 댓글 수 가져오기 
	public int replyCount(String writer) {
		return sqlSessionTemplate.selectOne("admin.postReply", writer); 
	}
	
	//7. 관리자의 회원검색(with using a Ajax)
	public List<MemberDTO> searchList(MemberDTO searchListMemberDTO) throws Exception {
		return sqlSessionTemplate.selectList("admin.searchList", searchListMemberDTO); 
	}
	
	//8. 1) 관리자가 신고된 게시물보기
	public List<ReportDTO> takeReportedPost(){
		return sqlSessionTemplate.selectList("admin.takeReportedPost");
	}
	
	//8. 2) 신고된 게시글 상세보기
	public ReportDTO readReportedPost(int reportNo) {
		ReportDTO readReportDTO = sqlSessionTemplate.selectOne("admin.readReportedPost",reportNo);  
		return readReportDTO; 
	}
	
	
	
	
		
}