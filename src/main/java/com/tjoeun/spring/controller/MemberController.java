package com.tjoeun.spring.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.service.MemberService;


@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	
	//1. 회원가입 페이지로 이동
	@RequestMapping("/signUp")
	public String signUp() { //회원가입 페이지로 이동
		return "member/signUp";
	}

	
	//2. 회원가입 완료버튼 누르고 회원가입 하기
	@RequestMapping("/signUpProcess")
    public @ResponseBody MemberDTO signUpProcess
    (HttpServletRequest request, HttpServletResponse response, MemberDTO signUpMemberDTO) throws Exception{	
		
		MemberDTO newMemberDTO = memberService.signUpProcess(signUpMemberDTO);
        return newMemberDTO;
    }
	
	//3. 로그인 페이지로 이동
	@RequestMapping("/signIn")
	public String signIn() { 
		return "member/signIn";
	}
	
	//4. 로그인버튼을 누르고 로그인성공하기. 
	@PostMapping("/signInProcess")
	public String login_pro(MemberDTO tmpLoginMemberDTO) {
		
		memberService.signIn(tmpLoginMemberDTO);
		return null;
			
		
	}
	

	
	
	
	
	
	
	
	
	
	
}
