package com.tjoeun.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.spring.dto.BoardDTO;
import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	//1. 게시판 관리 페이지로 이동한다. 
	@RequestMapping("/boardManagement")
	public String boardManagement() {
		return "admin/boardManagement";
	}
	
	//1.1) 게시판 관리 페이지 안에서 게시판 카테고리(게시판 대분류)를 생성한다. 
	@RequestMapping("/boardManagement/boardCategoryName")
	public String makeCategory(@RequestParam("boardCategoryName") String boardCategoryName) {
		adminService.makeCategory(boardCategoryName);
		return "redirect:/admin/boardManagement";
	}
	
	//1.2) 게시판 관리 페이지 안에서 게시판(대분류 카테고리에 포함된)을 생성한다. 
	@RequestMapping("/boardManagement/boardName")
	public String makeBoard(BoardDTO BoardDTOinCategory) {
		adminService.makeBoard(BoardDTOinCategory);
		return "redirect:/admin/boardManagement";
	}
	
	
	//1.3)게시판 관리 페이지 안에서 게시판 이름 변경한다. 
	@RequestMapping("/boardManagement/changeBoardName")
	public String changeBoardName(BoardDTO BoardDTOinCategory) {
		adminService.changeBoardName(BoardDTOinCategory);
		return "redirect:/admin/boardManagement";
	}
	
	//2. 게시물 관리 페이지로 이동한다. 
	@RequestMapping("/postManagement")
	public String postManagement() {
		return "admin/postManagement";
	}
	
	//3. 회원 관리 페이지로 이동한다. 
	@RequestMapping("/memberManagement")
	public String memberManagement(Model model) {
		List<MemberDTO> allMemberList = adminService.takeMemberList(); 
		model.addAttribute("allMemberList", allMemberList); 
		return "admin/memberManagement";
	}
	
	//카테고리 삭제
	@RequestMapping("/boardManagement/deleteCategory")
	public String deleteCategory(int boardCategoryNo) {
		adminService.deleteCategory(boardCategoryNo); 
		return "redirect:/admin/boardManagement";
	}
	
	//게시판 삭제
	@RequestMapping("/boardManagement/deleteBoard")
	public String deleteBoard(int boardNo) {
		adminService.deleteBoard(boardNo); 
		return "redirect:/admin/boardManagement";
	}
	
	//회원 검색(아작스 이용)
	@GetMapping("/searchList")
	public @ResponseBody List<MemberDTO> searchList
	(@RequestParam("type") String type, @RequestParam("keyword") String keyword, Model model) throws Exception{

		MemberDTO searchListMemberDTO = new MemberDTO(); 
		searchListMemberDTO.setType(type); 
		searchListMemberDTO.setKeyword(keyword); 
		
		List<MemberDTO> searchList = adminService.searchList(searchListMemberDTO);  
		model.addAttribute("searchList", searchList);
		return searchList;
	}
	
	
	
	
	

	
	

	
}
