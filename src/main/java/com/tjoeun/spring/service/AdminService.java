package com.tjoeun.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tjoeun.spring.dao.AdminDAO;
import com.tjoeun.spring.dto.BoardDTO;
import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.dto.ReportDTO;

@Service
public class AdminService {

	@Autowired
	private AdminDAO adminDAO; 
	
	//1. 게시판 대분류 카테고리 생성 Create
	public void makeCategory(String boardCategoryName) {
		adminDAO.makeCategory(boardCategoryName);
	}

	//2. 카테고리 삭제 Delete 
	public void deleteCategory(int boardCategoryNo) {
		adminDAO.deleteCategory(boardCategoryNo);
	}
	
	//3. 게시판 이름 생성 Create
	public void makeBoard(BoardDTO BoardDTOinCategory) {
		adminDAO.makeBoard(BoardDTOinCategory);
	}

	//4. 게시판 이름 변경 Updating
	public void changeBoardName(BoardDTO boardDTOinCategory) {
		adminDAO.changeBoardName(boardDTOinCategory);
	}
	
	//5. 게시판 삭제 Delete
	public void deleteBoard(int boardNo) {
		adminDAO.deleteBoard(boardNo);
	}	

	//6. 1) 멤버리스트는 다 가져오는거(at 관리자페이지)
	public List<MemberDTO> takeMemberList(){
		return adminDAO.takeMemberList();
	} 
	
	//6. 2) 특정한 한 회원이 쓴 글의 수 가져오기 (at 관리자페이지)
	public int postCount(String writer) {
		return adminDAO.postCount(writer);   
	}
		
	//6. 3) 특정한 한 회원이 쓴 댓글 수 가져오기	(at 관리자페이지)
	public int replyCount(String writer) {
		return adminDAO.replyCount(writer); 
	}

	//6. 4) 특정 회원 검색(at 관리자페이지) 
	public List<MemberDTO> searchList(MemberDTO searchListMemberDTO) throws Exception {
		return adminDAO.searchList(searchListMemberDTO);		
	}
	
	//7. 1) 관리자가 신고된 글 모두 리스트로 보기 (at 게시물페이지) 
	public List<ReportDTO> takeReportedPost(){
		return adminDAO.takeReportedPost();
	} 
	
	//7. 2) 관리자가 신고된 특정한 글 하나 보기(신고의 구체적인 사유)
	public ReportDTO readReportedPost(int reportNo) {
		ReportDTO readReportDTO = adminDAO.readReportedPost(reportNo);
		return readReportDTO; 
	}
	
	

}