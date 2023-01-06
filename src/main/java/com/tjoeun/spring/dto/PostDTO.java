package com.tjoeun.spring.dto;

import java.util.Date;


import org.springframework.web.multipart.MultipartFile;

import lombok.Data;


@Data
public class PostDTO {
	
	private int boardNo; //게시판 자체의 번호
	private String boardName; 

	private int postNo; //글 번호
	private String title; //글 제목
	private String content; //글 내용
	private String writer; //작성자
	
	private Date regDate; //글 작성일
	
	private String reg_date; //글검색시 아작스
	
	private int viewCount; //조회수
	private  int sameThinking; //좋아요 공감버튼! 
	private int replyCount; //해당 글의 댓글 수 

	private String result; 
		
	private String keyword;//키워드 
	private String type; //검색종류
	
	private String imageFileName; //업로드한 사진의 이름
	private MultipartFile imageFile; //업로드한 사진파일 
	
	
	
	
	
	
}