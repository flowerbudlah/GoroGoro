package com.tjoeun.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.service.BoardService;

@Controller
public class MainController {

	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/main")
	public String main(HttpServletRequest request, HttpServletResponse response) {
		return "main";
	}
	
	//4. 로그인을 한 뒤에 관리자가 아닌 사람이 관리자 페이지에 들어가는 경우, (Interceptor, 인터셉터)
	@RequestMapping("/etc/notAdmin")
	public String notAdmin(){
		return "etc/notAdmin";
	}
	
	
	@RequestMapping("/myPage/myProfile")
	public String myProfile(){
		return "myPage/myProfile";
	}
	
	@RequestMapping("/myPage/myPosts")
	public String myPost
	(Model model,
	@RequestParam("memberNo") int memberNo, String writer, 
	@RequestParam(value="page", defaultValue="1") int page){
		
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
