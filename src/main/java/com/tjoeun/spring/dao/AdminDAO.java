package com.tjoeun.spring.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.spring.dto.BoardDTO;


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

	//3. 게시판 이름 변경
	public void changeBoardName(BoardDTO boardDTOinCategory) {
		sqlSessionTemplate.update("admin.changeBoardName", boardDTOinCategory); 
	}
	

	
		
}