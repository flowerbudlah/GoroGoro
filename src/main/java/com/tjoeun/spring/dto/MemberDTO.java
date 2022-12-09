package com.tjoeun.spring.dto;

import java.util.Date;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import lombok.Data;


@Data
public class MemberDTO {
	
	private int memberNo; //회원일련번호
	
	private String email;  //아이디와 같은 기능의 이메일
	
	@Size(min=1, max=5) 
	@Pattern(regexp = "[가-힣]*")
	private String nick;  //대화명

	
	private String passwords;  //비밀번호
	private String passwordsConfirm; //위 비밀번호 확인변수
	

	private String question; //아이디 비밀번호 분실시 질문
	private String answer; //아이디 비밀번호 분실시 답(위 질문에 대한 답)
	private Date signUpDate; //가입일
	
	//로그인
	private boolean signIn; 
		
		
	
	

	private String result; //회원가입 성공여부를 할려주는 결과변수
	
	private boolean inputEmail; //아이디 중복검사
	private boolean inputNick; //대화명 중복검사

	public MemberDTO() {
		this.inputEmail = false; //중복검사 유효성검사와 관련있는 부분
		this.inputNick = false; 
	}
	
	
	
	
	

	
}
