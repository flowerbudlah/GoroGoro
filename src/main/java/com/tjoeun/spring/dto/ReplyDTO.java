package com.tjoeun.spring.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {

	private int postNo; //댓글이 달린 게시글 번호
	private int replyNo; //댓글 번호
	private String replyContent; //댓글 내용
	private String replyWriter;  //댓글 작성자
	private Date replyRegDate; //댓글 작성일
	
	private String result; //댓글 작성의 성공여부를 알려주는 그 리절트!
	
	
	
}
