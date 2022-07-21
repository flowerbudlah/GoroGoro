package com.tjoeun.spring.dto;

import java.util.Date;

import lombok.Data;

@Data
public class CategoryDTO {

	private int boardCategoryNo; //게시판 대분류 카테고리 번호  
	private String boardCategoryName; //대분류 카테고리 이름 ex. 관세사 1차, 관세사 2차, 프로그래밍, 외국어, 기타 
	private Date creationDate; //대분류 카테고리 만든날 
	
	
	
	
}
