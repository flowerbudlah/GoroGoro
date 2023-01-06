package com.tjoeun.spring.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReportDTO {
	
	private int reportNo; 
	private String reason;  
	private String detail;  
	private String reporter;  
	private Date reportDate;  
	private int postNo;  
	
	private String imageFileName; 
	
	private MultipartFile imageFile; //업로드한 사진파일 
	
	private String result; 
	
	
}
