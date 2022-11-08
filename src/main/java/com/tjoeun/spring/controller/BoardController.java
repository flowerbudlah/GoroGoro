package com.tjoeun.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
	
	@Autowired
	private ReplyService replyService;
	
	//1. 게시판 메인화면으로 간다. 
	@RequestMapping("/main")
	public String main
	(Model model, @RequestParam("boardNo") int boardNo, @RequestParam(value="page", defaultValue="1") int page) {
		
		model.addAttribute("boardNo", boardNo); //게시판 일련번호(인덱스)
		
		String boardName = boardService.getBoardName(boardNo); 
		model.addAttribute("boardName", boardName);//게시판 이름
		
		List<PostDTO> postList = boardService.goMain(boardNo, page);
		model.addAttribute("postList", postList); //글 목록
		
		//페이징
		PageDTO pageDTO = boardService.getPostCnt(boardNo, page); 
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);
		
		return "board/main";
		
	}
	
	//게시물 검색(아작스 이용)
	@GetMapping("/searchList")
	public @ResponseBody List<PostDTO> searchList(
	@RequestParam("type") String type, 
	@RequestParam("keyword") String keyword, 
	@RequestParam("boardNo") int boardNo, Model model) throws Exception{

		PostDTO searchListPostDTO = new PostDTO(); 
		searchListPostDTO.setBoardNo(boardNo); 
		searchListPostDTO.setType(type); 
		searchListPostDTO.setKeyword(keyword); 
		
		List<PostDTO> searchList = boardService.searchList(searchListPostDTO);  
		model.addAttribute("searchList", searchList);
		
		return searchList; 
	} 
	
	
	
	//2. 글쓰기페이지로 이동 
	@RequestMapping("/write") 
	public String write(Model model, @RequestParam("boardNo") int boardNo){
		model.addAttribute("boardNo", boardNo); //게시판 일련번호(인덱스)
		return "board/write";
	}
	
	
	//3. 게시글 등록 Creating 
	@RequestMapping("/writeProcess")
    public  @ResponseBody PostDTO writeProcess
    (HttpServletRequest request, HttpServletResponse response, PostDTO writePostDTO, MultipartFile imageFile) throws Exception{	
		
		PostDTO postDTO = boardService.writeProcess(writePostDTO);
        return postDTO;
    }
	
	
	//7. 글 수정 페이지로 이동
	@RequestMapping("/modify")
	public String modify(@RequestParam("postNo") int postNo, @ModelAttribute("modifyPostDTO") PostDTO modifyPostDTO, Model model) {
				
		model.addAttribute("postNo", postNo);
					
		PostDTO PostDTOfromDB = boardService.read(postNo); 
		model.addAttribute("PostDTOfromDB", PostDTOfromDB);
		//수정하고자 하는 그 글! 
					
			return "board/modify";	
	}
	
	
	
	//게시판 수정과정
	@RequestMapping("/modifyProcess")
	public @ResponseBody PostDTO modify
	(HttpServletRequest request, HttpServletResponse response, PostDTO modifyPostDTO, MultipartFile imageFile) throws Exception{
		
		PostDTO postDTO = boardService.modify(modifyPostDTO); //수정하겠다고 하는 그 글들이 입력되어 고쳐쓴 새로운 PostDTO가 된다. 
		return postDTO;
	
	}
	
	//9. 이미지 첨부파일 삭제
	@RequestMapping("/deleteImageFile")
	public @ResponseBody PostDTO deleteImageFile(HttpServletRequest request, HttpServletResponse response, PostDTO imageFilePostDTO) {
		PostDTO afterDeletingImageFile = boardService.deleteImageFile(imageFilePostDTO); 
		return afterDeletingImageFile;
	}


	//4. 글읽기 Reading (댓글 포함)
	@RequestMapping("/read")
	public String read(@RequestParam("postNo") int postNo, @ModelAttribute("readPostDTO") PostDTO postDTO, Model model) {
		
		PostDTO readPostDTO = boardService.read(postNo);
		
		model.addAttribute("readPostDTO", readPostDTO); 
		model.addAttribute("postNo", postNo);
				
		//조회수 증가 
		boardService.increasingViewCount(postNo);
		
		//댓글출력 
		List<ReplyDTO> replyList =  replyService.replyList(postNo);
		model.addAttribute("replyList", replyList); 
		
		return "board/read";
		
	}
		
	//5. 글 삭제 Deleting
	@RequestMapping("/deleteBoard")
    public @ResponseBody PostDTO deleteBoard(HttpServletRequest request, HttpServletResponse response, int postNo) throws Exception{
        PostDTO postDTO = boardService.deleteBoard(postNo); 
        return postDTO;
    }
	
	//9. 댓글삭제
	@RequestMapping("/removeReply")
	public @ResponseBody ReplyDTO removeReply(HttpServletRequest request, HttpServletResponse response, int replyNo) {
		ReplyDTO ReplyDTO = replyService.removeReply(replyNo); 
		return ReplyDTO;
	}
	
	
	//6. 좋아요(추천, 공감)
	@RequestMapping("/like") 
	public @ResponseBody PostDTO like(HttpServletRequest request, HttpServletResponse response, int postNo) throws Exception {
		PostDTO likePostDTO = boardService.like(postNo);
		return likePostDTO;
	}
	
	//8. 댓글등록 
	@RequestMapping("/writeReplyProcess")
    public @ResponseBody ReplyDTO writeReplyProcess(HttpServletRequest request, HttpServletResponse response, ReplyDTO writeReplyDTO) {	
		
		ReplyDTO ReplyDTO = replyService.writeReplyProcess(writeReplyDTO);
		
        return ReplyDTO;
    }


}