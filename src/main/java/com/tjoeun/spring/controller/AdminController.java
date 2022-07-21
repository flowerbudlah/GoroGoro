package com.tjoeun.spring.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.tjoeun.spring.dto.BoardDTO;

import com.tjoeun.spring.service.AdminService;


@Controller
@RequestMapping("/admin")
public class AdminController {


	
	@Autowired
	private AdminService adminService;
	
	//1. 게시판 관리 페이지로 이동한다. 
	@RequestMapping("/board_management")
	public String boardManagement() {
		return "admin/board_management";
	}
	
	//1. 1) 게시판 관리 페이지 안에서 게시판 카테고리를 생성한다. 
	@RequestMapping("/board_management/boardCategoryName")
	public String makeCategory(@RequestParam("boardCategoryName") String boardCategoryName) {
		
		adminService.makeCategory(boardCategoryName);
	
		return "redirect:/admin/board_management";
	}
	
	//1. 2) 게시판 관리 페이지 안에서 게시판을 생성한다. 
	@RequestMapping("/board_management/boardName")
	public String makeBoard(BoardDTO BoardDTOinCategory) {
		
		adminService.makeBoard(BoardDTOinCategory);
	
		return "redirect:/admin/board_management";
	}
	
	//1. 2) 게시판 관리 페이지 안에서 게시판 이름 변경한다. 
	@RequestMapping("/board_management/changeBoardName")
	public String changeBoardName(BoardDTO BoardDTOinCategory) {
			
		adminService.changeBoardName(BoardDTOinCategory);
		
		return "redirect:/admin/board_management";
	}
	
	

	//2. 게시물 관리 페이지로 이동한다. 
	@RequestMapping("/post_management")
	public String postManagement() {
		return "admin/post_management";
	}
	
	//3. 회원 관리 페이지로 이동한다. 
	@RequestMapping("/member_management")
	public String memberManagement() {
		return "admin/member_management";
	}
	

}
