package com.tjoeun.spring.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
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

	@Resource(name="signInMemberDTO") 
	@Lazy
	private MemberDTO signInMemberDTO; //로그인, 세션 쿠키와 관련있는 부분

	//1. 회원가입 페이지로 이동
	@RequestMapping("/signUp")
	public String signUp(){ //회원가입 페이지로 이동
		return "member/signUp";
	}
	
	//2. 회원가입 완료버튼 누르고 회원가입 하기
	@RequestMapping("/signUpProcess")
	public @ResponseBody MemberDTO signUpProcess(MemberDTO signUpMemberDTO){
		
		MemberDTO newMemberDTO = memberService.signUpProcess(signUpMemberDTO); //회원가입 완료
		return newMemberDTO; 
	}
	
	
	
	//1. 이메일(아이디) 중복체크
	@RequestMapping("/checkEmail")
	public @ResponseBody String checkEmail(String email) {
		String result = memberService.checkEmail(email);
		
		if(result == null){
			return "available"; //사용가능
		} else {
			return "unavailable"; //사용불가
		}
	}
	
	
	
	//닉네임 중복체크
	@RequestMapping("/checkNick")
	public @ResponseBody String checkNick(String nick) {
		String result = memberService.checkNick(nick);
		
		if(result == null){
			return "available"; //사용가능
		} else {
			return "unavailable"; //사용불가
		}
	}
	
		
	
	//로그인 페이지로 입장
	@RequestMapping("/signIn")
	public String signIn() {
		return "member/signIn";
	}
	
	
	
	//4. 로그인버튼을 누르고 로그인성공하기. 
	@PostMapping("/signInProcess")
	public void signInProcess
	(HttpServletRequest request, HttpServletResponse response, MemberDTO tmpSignInMemberDTO) {
			
		memberService.signIn(tmpSignInMemberDTO); //로그인 시도 
		
		if(signInMemberDTO.isSignIn() == true) {//이것이 true 
			
			
		} else if(signInMemberDTO.isSignIn() ==  false ) {
			try {
				response.getWriter().write("loginFail");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
		
	@RequestMapping("/signOut") 
	public @ResponseBody void signOut(HttpSession session) {
		signInMemberDTO.setSignIn(false); //로그인 풀리고, 
		session.invalidate(); //세션 종료
	}
	

}
