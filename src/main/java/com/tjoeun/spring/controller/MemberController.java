package com.tjoeun.spring.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.service.MemberService;


@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/signIn")
	public String signIn(Model model) { //로그인 페이지로 이동
		return "member/signIn";
	}
	
	
	
	@RequestMapping("/signUp")
	public String signUp(Model model) { //회원가입 페이지로 이동
		return "member/signUp";
	}
	
	@RequestMapping("/signUpProcess")
    public @ResponseBody MemberDTO signUpProcess //회원가입 완료버튼 누르고 회원가입 하기
    (HttpServletRequest request, HttpServletResponse response, MemberDTO signUpMemberDTO) throws Exception{	
		
		MemberDTO newMemberDTO = memberService.signUpProcess(signUpMemberDTO);
        
		return newMemberDTO;
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
