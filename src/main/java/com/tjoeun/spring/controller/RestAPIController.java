package com.tjoeun.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.tjoeun.spring.service.MemberService;

@RestController
public class RestAPIController {
	
	@Autowired
	private MemberService memberService;
	
	//1. 이메일(아이디) 중복체크
	@GetMapping("/member/checkEmail/{email}")
	public String checkEmail(@PathVariable String email) {
		boolean chck = memberService.checkEmail(email);
		return chck + "";
	}
	
	//2. 대화명(닉네임) 중복체크
	@GetMapping("/member/checkNick/{nick}")
	public String checkNick(@PathVariable String nick) {
		boolean chck = memberService.checkNick(nick);
		return chck + "";
	}
	
	
	
	
	
}
