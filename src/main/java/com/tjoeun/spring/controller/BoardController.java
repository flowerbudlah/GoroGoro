package com.tjoeun.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.dto.ReplyDTO;
import com.tjoeun.spring.service.BoardService;
import com.tjoeun.spring.service.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	
	//1. 게시판 메인화면으로 간다. 
	@RequestMapping("/main")
	public String main(Model model, @RequestParam("boardNo") int boardNo, @RequestParam(value="page", defaultValue="1") int page) {
		
		model.addAttribute("boardNo", boardNo);
		
		String boardName = boardService.getBoardName(boardNo); 
		model.addAttribute("boardName", boardName);
		
		List<PostDTO> postList = boardService.goMain(boardNo, page);
		model.addAttribute("postList", postList); //글 목록
		
		//페이징
		PageDTO pageDTO = boardService.getPostCnt(boardNo, page); 
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);
		
		return "board/main";
	}
	
	
	//2. 글쓰기페이지로 이동 
	@RequestMapping("/write")
	public String write(Model model, @RequestParam("boardNo") int boardNo) {
		model.addAttribute("boardNo", boardNo);
		return "board/write";
		
	}
	
	
	//3. 게시글 등록 
	@RequestMapping("/writeProcess")
    public @ResponseBody PostDTO writeProcess(HttpServletRequest request, HttpServletResponse response, PostDTO writePostDTO) {	
    	PostDTO postDTO = boardService.writeProcess(writePostDTO);
        return postDTO;
    }
	
	
	//4. 글읽기(댓글 출력작업포함)
	@RequestMapping("/read")
	public String read(@RequestParam("postNo") int postNo, @ModelAttribute("readPostDTO") PostDTO postDTO, Model model) {
		
		PostDTO readPostDTO = boardService.read(postNo);
		
		model.addAttribute("readPostDTO", readPostDTO); 
		model.addAttribute("postNo", postNo);
				
		boardService.increasingViewCount(postNo); //조회수 증가 
		
		//댓글출력 
		List<ReplyDTO> replyList =  replyService.replyList(postNo);
		model.addAttribute("replyList", replyList); 
				
		return "board/read";
	}
		
	
	//4. 글 삭제
	@RequestMapping("/deleteBoard")
    public @ResponseBody PostDTO deleteBoard(HttpServletRequest request, HttpServletResponse response, int postNo) throws Exception{
 
        PostDTO boardDto = boardService.deleteBoard(postNo); 
        return boardDto;
        
    }
	
	
	//6. 좋아요. 
	@RequestMapping("/like") // http://localhost:8090/NerdCommunity/board/like
	public @ResponseBody PostDTO like(HttpServletRequest request, HttpServletResponse response, int postNo) throws Exception {
		PostDTO likePostDTO = boardService.like(postNo);
		return likePostDTO;
	
	}
	
	
	//5. 글 수정 페이지로 이동
	@RequestMapping("/modify")
	public String modify(Model model) {
	
		return "board/modify";	
	}
	

	@Autowired
	private ReplyService replyService;
	
	
	//1. 댓글등록 
	@RequestMapping("/writeReplyProcess")
    public @ResponseBody ReplyDTO writeReplyProcess(HttpServletRequest request, HttpServletResponse response, ReplyDTO writeReplyDTO) {	
		
		ReplyDTO ReplyDTO = replyService.writeReplyProcess(writeReplyDTO);
		
        return ReplyDTO;
    }
	
	
	
	
}