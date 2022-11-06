package com.tjoeun.spring.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.tjoeun.spring.dao.MemberDAO;
import com.tjoeun.spring.dto.MemberDTO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	@Lazy @Resource(name = "loginMemberDTO")
	private MemberDTO loginMemberDTO;

	
	//1. 회원가입(새로운 회원의 탄생)
	public MemberDTO signUpProcess(MemberDTO signUpMemberDTO){
		
		MemberDTO  newMemberDTO = new MemberDTO ();
		
		int SuccessOfSignIn = memberDAO.signUpProcess(signUpMemberDTO); //회원가입 정보 입력
		
		if (SuccessOfSignIn > 0) { //회원가입이 성공했다는 뜻
			newMemberDTO.setResult("SUCCESS");
		} else { //회원가입이 실패했다는 뜻
			newMemberDTO.setResult("FAIL"); 
		}
		return newMemberDTO; 	
	}
	
	
	//2. (아이디 용)이메일 중복체크 
	public boolean checkEmail(String email) {
		String checkingEmail = memberDAO.checkEmail(email); 
		if(checkingEmail == null) {	
			return true; //입력한 이메일이 존재하지 않기에 입력한 이메일 사용가능. 
		} else {	
			return false; //입력한 이메일 이미 존재하기에 사용불가
		}
	} 

	//3. 대화명(닉네임) 중복 체크
	public boolean checkNick(String nick) {
		String checkingNick = memberDAO.checkNick(nick); 
		if(checkingNick == null) {	
			return true; //입력한 대화명이 존재하지 않기에 입력한 이메일 사용가능. 
		} else {	
			return false; //입력한 대화명은 이미 다른사람이 사용중이기애(이미 존재하기에) 사용불가
		}
	}

	//4.Sign In or Log In
	public void signIn(MemberDTO tmpLoginMemberDTO) {
		MemberDTO MemberDTOfromDB = memberDAO.signIn(tmpLoginMemberDTO);
		
		if(MemberDTOfromDB != null) {//로그인을 했더니, DB애 정보가 있다.
			loginMemberDTO.setMemberNo(MemberDTOfromDB.getMemberNo());//로그인한 회원의 회원번호
			loginMemberDTO.setEmail(MemberDTOfromDB.getEmail()); //로그인한 회원의 아이디 이메일
			loginMemberDTO.setPasswords(MemberDTOfromDB.getPasswords()); //로그인한 회원의 패스워드
			loginMemberDTO.setNick(MemberDTOfromDB.getNick()); //로그인한 회원의 대화명
	
			loginMemberDTO.setSignIn(true); //로그인 성공하니 sign in이 false에서 true로 바뀝니다. 
		}
	}


	

		
	
	
	
	
	
	
}
