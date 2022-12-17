package com.tjoeun.spring.dto;

import java.util.Date;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import lombok.Data;


@Data
public class MemberDTO {
	
	private int memberNo; //회원일련번호
	
	private String email;  //아이디와 같은 기능의 이메일
	private String nick;  //대화명

	private String passwords;  //비밀번호
	private String passwordsConfirm; //위 비밀번호 확인변수
	
	private String question; //아이디 비밀번호 분실시 질문
	private String answer; //아이디 비밀번호 분실시 답(위 질문에 대한 답)
	private Date signUpDate; //가입일
	
	private String result; //회원가입 성공여부를 할려주는 결과변수
	
	private boolean signIn; //로그인이 된상태면 이것이 true, 로그인이 안된상태면 false 
		

	

	
	
	
}
