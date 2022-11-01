package com.tjoeun.spring.dto;

import java.util.Date;

import lombok.Data;

@Data
public class FileDTO {

	private int postNo; //게시물 번호
	private int fileNo; //파일 일련번호
	
	private String fileNameKey;  
	private String fileName;  // 업로드 파일 이름
	private String filePath;  //파일이 저장되는 경로
	private String fileSize;  //파일의 사이즈

	private Date uploadDate; //첨부파일 업로드 일자
	
	

}
