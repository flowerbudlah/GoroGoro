package com.tjoeun.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.service.MainService;

@Controller
public class MainController {

	@Autowired
	private MainService mainService;

	@RequestMapping("/main")
	public String main(HttpServletRequest request, HttpServletResponse response, Model model) {

		List<PostDTO> postList = mainService.getMainList();

		model.addAttribute("postList", postList);

		return "main";
	}

}
