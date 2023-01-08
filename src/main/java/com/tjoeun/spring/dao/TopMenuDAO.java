package com.tjoeun.spring.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.spring.dto.BoardDTO;
import com.tjoeun.spring.dto.CategoryDTO;

@Repository
public class TopMenuDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	//1. 대분류 카테고리 가져오기
	public List<CategoryDTO> getCategoryList(){
		List<CategoryDTO> CategoryList = sqlSessionTemplate.selectList("topMenu.CategoryList");
		return CategoryList;
				
	}
	
	//2. 게시판 리스트  
	public List<BoardDTO> getBoardList(){
		List<BoardDTO> boardList = sqlSessionTemplate.selectList("topMenu.BoardList");
		return boardList;
				
	}	
	
	
	
	
}
