package com.tjoeun.spring.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {

	@RequestMapping("/main")
	public String main(HttpServletRequest request, HttpServletResponse response) {
		return "main";
	}
	

	@GetMapping("etc/not_admin")
	public String notAdmin() {
		return "etc/not_admin";
	}
	
	
	
	
	
	

	
	
}
