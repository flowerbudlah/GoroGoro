package com.tjoeun.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tjoeun.spring.dao.AdminDAO;
import com.tjoeun.spring.dto.BoardDTO;

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
	

	
}