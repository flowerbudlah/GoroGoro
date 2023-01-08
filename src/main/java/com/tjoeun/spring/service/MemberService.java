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
	
	@Resource(name="signInMemberDTO")
	@Lazy
	private MemberDTO signInMemberDTO; 

	//1. 1) 회원가입(새로운 회원의 탄생) Create
	public MemberDTO signUpProcess(MemberDTO signUpMemberDTO){
		
		MemberDTO newMemberDTO = new MemberDTO(); 
		int signUp = memberDAO.signUpProcess(signUpMemberDTO); 
		
		if(signUp > 0) {
			newMemberDTO.setResult("success");
		} else {
			newMemberDTO.setResult("fail");
		}
		return newMemberDTO; 
	}
	
	//1. 2) 회원가입 시 (아이디 용)이메일 중복체크 
	public String checkEmail(String email) {
		return memberDAO.checkEmail(email);
	} 

	//1. 3) 대화명(닉네임) 중복 체크 (회원가입, 회원정보수정 모두 해당됨)
	public String checkNick(String nick) {
		return memberDAO.checkNick(nick);
	}

	//2. Sign In(로그인)
	public void signIn(MemberDTO tmpSignInMemberDTO) {
		
		MemberDTO memberDTOfromDB = memberDAO.signIn(tmpSignInMemberDTO); //아이디와 비밀번호로 로그인
		
		if(memberDTOfromDB != null) {//로그인을 했더니, DB애 정보가 있다.
			signInMemberDTO.setMemberNo(memberDTOfromDB.getMemberNo());//로그인한 회원의 회원번호
			signInMemberDTO.setEmail(memberDTOfromDB.getEmail()); //로그인한 회원의 아이디 이메일
			signInMemberDTO.setPasswords(memberDTOfromDB.getPasswords()); //로그인한 회원의 패스워드
			signInMemberDTO.setNick(memberDTOfromDB.getNick()); //로그인한 회원의 대화명
			
			signInMemberDTO.setSignIn(true); //로그인 성공하니 sign in이 false에서 true로 바뀝니다.
		} else if(memberDTOfromDB == null) { //로그인을 했더니, DB애 정보가 없다. 
			signInMemberDTO.setSignIn(false); 
		}
	}
	
	//3. 1) 수정하고자하는 회원 정보를 가져오기. 
	public void takeMemberDTO(MemberDTO modifyMemberDTO) {
		MemberDTO fromDBMemberDTO = memberDAO.takeMemberDTO(signInMemberDTO.getMemberNo());
  	
		modifyMemberDTO.setEmail(fromDBMemberDTO.getEmail());
		modifyMemberDTO.setPasswords(fromDBMemberDTO.getPasswords());
		modifyMemberDTO.setPasswordsConfirm(fromDBMemberDTO.getPasswordsConfirm());
		modifyMemberDTO.setNick(fromDBMemberDTO.getNick()); 
		modifyMemberDTO.setQuestion(fromDBMemberDTO.getQuestion());
		modifyMemberDTO.setAnswer(fromDBMemberDTO.getAnswer());
		
		modifyMemberDTO.setMemberNo(signInMemberDTO.getMemberNo());
	} 

	//3. 2) 진정으로 회원정보 수정하기! 
	public MemberDTO modifyMemberDTO(MemberDTO modifyMemberDTO){
		
		MemberDTO memberDTO = new MemberDTO(); 
		
		int successOrFail = memberDAO.modifyMemberDTO(modifyMemberDTO);
		
		if(successOrFail > 0) { //회원정보 수정 성공
			signInMemberDTO.setNick(modifyMemberDTO.getNick());
			memberDTO.setResult("success");
		} else { //회원정보 수정 실패
			memberDTO.setResult("fail");
		}
		return memberDTO;
	}
	
	
	
	
	


}