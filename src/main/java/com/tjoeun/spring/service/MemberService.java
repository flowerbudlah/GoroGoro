package com.tjoeun.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tjoeun.spring.dao.MemberDAO;

import com.tjoeun.spring.dto.MemberDTO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;

	//1. 회원가입(새로운 회원인 newMemberDTO의 탄생)
	public MemberDTO signUpProcess(MemberDTO signUpMemberDTO) throws Exception {
		
		MemberDTO  newMemberDTO = new MemberDTO ();
		
		int SuccessOfSignIn = memberDAO.signUpProcess(signUpMemberDTO); //회원가입 정보 입력
		
		if (SuccessOfSignIn > 0) { //회원가입이 성공했다는 뜻
			newMemberDTO.setResult("SUCCESS");
		} else { //회원가입이 실패했다는 뜻
			newMemberDTO.setResult("FAIL"); 
		}
		
		return newMemberDTO; 
	} 
	
	

		
	
	
	
}
