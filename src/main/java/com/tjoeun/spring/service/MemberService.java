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
		
		MemberDTO newMemberDTO = new MemberDTO(); 
		
		int signUp = memberDAO.signUpProcess(signUpMemberDTO); 
		
		if(signUp>0) {
			newMemberDTO.setResult("success");
		} else {
			newMemberDTO.setResult("fail");
		}
		return newMemberDTO; 
	}
	
	
	
	
	
	
	//2. (아이디 용)이메일 중복체크 
	public String checkEmail(String email) {
		return memberDAO.checkEmail(email);
	} 

	//3. 대화명(닉네임) 중복 체크
	public String checkNick(String nick) {
		return  memberDAO.checkNick(nick);
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