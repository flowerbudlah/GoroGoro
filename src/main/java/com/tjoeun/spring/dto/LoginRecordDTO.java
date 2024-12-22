package com.tjoeun.spring.dto;

import java.util.Date;

import lombok.Data;

@Data
public class LoginRecordDTO {
	
	private int loginRecordNo;
	private int memberNo;
	private String email;
	private Date loginRecordRealTime;
}
