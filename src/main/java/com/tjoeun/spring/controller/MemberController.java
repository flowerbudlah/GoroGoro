package com.tjoeun.spring.controller;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.service.MemberService;
import com.tjoeun.spring.validator.MemberValidator;


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
	public String signUpProcess
	(@Valid @ModelAttribute("signUpMemberDTO") MemberDTO signUpMemberDTO, BindingResult result){
		
		if(result.hasErrors()) { 
			return "member/signUp"; 
		}

		memberService.signUpProcess(signUpMemberDTO);
		return "member/signIn"; //회원가입이 성공했으면 로그인 페이지로 간다. 
	}
	
	

	@RequestMapping("/signIn")
	public String signIn() {
		return "member/signIn";
	}
	

	
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		MemberValidator validator1 = new MemberValidator();
		binder.addValidators(validator1);
	}



	
	//4. 로그인버튼을 누르고 로그인성공하기. 
	@PostMapping("/signInProcess")
	public String signInProcess(MemberDTO tmpLoginMemberDTO) {
		
		memberService.signIn(tmpLoginMemberDTO);
		return null;
	}
	

}
