package com.tjoeun.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.service.BoardService;

@Controller
@RequestMapping("/myPage")
public class MyPageController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/myProfile")
	public String myProfile(){
		return "myPage/myProfile";
	}
	
	@RequestMapping("/myPosts")
	public String myPost
	(Model model, @RequestParam("memberNo") int memberNo, String writer, 
			@RequestParam(value="page", defaultValue="1") int page){
		
		model.addAttribute("writer", writer); 
		model.addAttribute("memberNo", memberNo); //게시판 일련번호(인덱스)
			
		List<PostDTO> myPostList = boardService.goMyPosts(memberNo, page);
		model.addAttribute("myPostList", myPostList); //글 목록
		
		//페이징
		PageDTO pageDTO = boardService.getPostCnt(writer, page); 
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);
		
		return "myPage/myPosts";
	}
	
	
}
