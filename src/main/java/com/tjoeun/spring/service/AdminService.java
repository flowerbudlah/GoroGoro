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
	
	//1.게시판 대분류 카테고리 생성 Create
	public void makeCategory(String boardCategoryName) {
		adminDAO.makeCategory(boardCategoryName);
	}

	//2.게시판 이름 생성
	public void makeBoard(BoardDTO BoardDTOinCategory) {
		adminDAO.makeBoard(BoardDTOinCategory);
	}

	//3. 게시판 이름 변경
	public void changeBoardName(BoardDTO boardDTOinCategory) {
		adminDAO.changeBoardName(boardDTOinCategory);
	}

	//4. 관리자페이지에서 멤버리스트는 다 가져오는거 
	public List<MemberDTO> takeMemberList(){
		return adminDAO.takeMemberList();
	} 
	
	//카테고리 삭제
	public void deleteCategory(int boardCategoryNo) {
		adminDAO.deleteCategory(boardCategoryNo);
	}
	
	//게시판 삭제
	public void deleteBoard(int boardNo) {
		adminDAO.deleteBoard(boardNo);
	}	
	
	//특정한 한 회원이 쓴 글의 수 가져오기 
	public int postCount(String writer) {
		return adminDAO.postCount(writer);   
	}
		
	//특정한 한 회원이 쓴 댓글 수 가져오기 
	public int replyCount(String writer) {
		return adminDAO.replyCount(writer); 
	}
	
	//아작스 게시글 검색 
	public List<MemberDTO> searchList(MemberDTO searchListMemberDTO) throws Exception {
		return adminDAO.searchList(searchListMemberDTO);		
	}
	
	//관리자가 신고된 게시판 글 보기 
	public List<ReportDTO> takeReportedPost(){
		return adminDAO.takeReportedPost();
	} 
	
	
	public ReportDTO readReportedPost(int reportNo) {
		ReportDTO readReportDTO = adminDAO.readReportedPost(reportNo);
		return readReportDTO; 
	}
	
	

}