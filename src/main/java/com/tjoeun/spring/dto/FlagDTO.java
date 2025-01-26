package com.tjoeun.spring.dto;


import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class FlagDTO {

	private int flagNo;  
	// 해당 플래그의 주인
	private int memberNo;
	// 유효한 신고의 게시글
	private int postNo;
	// 해당 신고번호
	private int reportNo;
	// 최초 신고자
	private  String reporter;
	
	private String result; 

}
