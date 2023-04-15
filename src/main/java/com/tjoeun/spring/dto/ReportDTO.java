package com.tjoeun.spring.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReportDTO {
	
	private int reportNo; //신고번호
	private String reason;  //신고사유(제목)
	private String detail;  //신고상세사유(내용)
	private String reporter;  //신고자(글쓴이)
	private Date reportDate;  //신고일(작성일)
	private int postNo; //신고대상 글번호
	
	
	private String imageFileName; //증거자료 이름(첨부파일 이름)
	
	
	private MultipartFile imageFile; //업로드한 사진파일 
	
	private String result; 
		
	private int replyCount; 
	
	
	private String keyword;//키워드 
	private String type; //검색종류

	
	
}
