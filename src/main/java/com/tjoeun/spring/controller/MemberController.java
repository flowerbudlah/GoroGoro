package com.tjoeun.spring.controller;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	
	@Resource(name="loginMemberDTO")
	@Lazy
	private MemberDTO loginMemberDTO;
	
	//1. 회원가입 페이지로 이동
	@RequestMapping("/signUp")
	public String signUp() { //회원가입 페이지로 이동
		return "member/signUp";
	}
	
	//2. 회원가입 완료버튼 누르고 회원가입 하기
	@RequestMapping("/signUpProcess")
	public  @ResponseBody MemberDTO signUpProcess(MemberDTO signUpMemberDTO){
		
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
	
		
	@RequestMapping("/signIn")
	public String signIn() {
		return "member/signIn";
	}
	
	//4. 로그인버튼을 누르고 로그인성공하기. 
	@PostMapping("/signInProcess")
	public String signInProcess(MemberDTO tmpLoginMemberDTO) {
		
		memberService.signIn(tmpLoginMemberDTO);
		return null;
	}
	

}
