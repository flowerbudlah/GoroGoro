package com.tjoeun.spring.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {

	@RequestMapping("/main")
	public String main(HttpServletRequest request, HttpServletResponse response) {
		return "main";
	}
	

	//4. 로그인을 한 뒤에 관리자가 아닌 사람이 관리자 페이지에 들어가는 경우, (Interceptor, 인터셉터)
	@RequestMapping("/etc/notAdmin")
	public String notAdmin(){
		return "etc/notAdmin";
	}
	
	
	
	
	

	
	
}
