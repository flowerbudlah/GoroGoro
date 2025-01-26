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
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.dto.ReplyDTO;
import com.tjoeun.spring.dto.ReportDTO;
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
	public String main(
	@RequestParam("boardNo") int boardNo, 
	@RequestParam(value="page", defaultValue="1") int page, Model model) {
		
		model.addAttribute("boardNo", boardNo); //게시판 일련번호(인덱스)
		
		String boardName = boardService.getBoardName(boardNo); 
		model.addAttribute("boardName", boardName);//게시판 이름
		
		List<PostDTO> postList = boardService.goMain(boardNo, page);
		model.addAttribute("postList", postList); //글 목록
		
		//페이징
		PageDTO pageDTO = boardService.mainPageDTO(boardNo, page); 
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);
	
		return "board/main";
	}
	
	/*
	//1. 1) 게시판 메인화면에서 게시물 검색(with using The Ajax)
	@GetMapping("/searchList")
	public @ResponseBody List<PostDTO> searchList
	(Model model, 
	@RequestParam("type") String type, 
	@RequestParam("keyword") String keyword, 
	@RequestParam("boardNo") int boardNo, 
	@RequestParam(value="page", defaultValue="1") int page) throws Exception {
		
		PostDTO searchListPostDTO = new PostDTO(); 
		
		searchListPostDTO.setBoardNo(boardNo); 
		searchListPostDTO.setType(type); 
		searchListPostDTO.setKeyword(keyword); 
		
		//검색결과 리스트
		List<PostDTO> searchList = boardService.searchList(searchListPostDTO, page);  
		model.addAttribute("searchList", searchList);
		
		//페이징
		PageDTO searchPageDTO = boardService.searchPageDTO(searchListPostDTO, page); 
		
		model.addAttribute("searchPageDTO", searchPageDTO);
		model.addAttribute("page", page);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("boardNo", boardNo); 
		
		return searchList; 			
	} 
	*/
	
	/*
	//검색과 페이지(아작스)
	@RequestMapping("/searchList")
	public @ResponseBody ResponseEntity< HashMap<String, Object> > searchList
	(Model model, 
	@RequestParam("type") String type, 
	@RequestParam("keyword") String keyword, 
	@RequestParam("boardNo") int boardNo, 
	@RequestParam(value="page", defaultValue="1") int page 
	) throws Exception {
	
		HashMap<String, Object> result = new HashMap<>();
		
		PostDTO searchListPostDTO = new PostDTO(); 
			
		searchListPostDTO.setBoardNo(boardNo); 
		searchListPostDTO.setType(type); 
		searchListPostDTO.setKeyword(keyword); 
		
		//검색결과 리스트
		List<PostDTO> searchList = boardService.searchList(searchListPostDTO, page); 
		result.put("searchList", searchList);	
		
		//검색결과 수 searchCount
		int searchCount = boardService.searchCount(searchListPostDTO); 
		result.put("searchCount", searchCount); 
		model.addAttribute("searchCount", searchCount); 
		
		//페이징
		PageDTO searchPageDTO = boardService.searchPageDTO(searchListPostDTO, page); 
		
		result.put("searchPageDTO", searchPageDTO); // 페이징
		result.put("page", page);
		result.put("type", type);
		result.put("keyword", keyword);
		result.put("boardNo", boardNo); 
	 
		return ResponseEntity.ok(result);		
	
	} 
	*/
	
	//검색과 페이지(페이지 1 2 3 4 5 6 7 8 9 10)
	@RequestMapping("/searchResult")
	public String searchResult
	(Model model, 
	@RequestParam("boardNo") int boardNo, 
	@RequestParam("type") String type, 
	@RequestParam("keyword") String keyword, 
	@RequestParam(value="page", defaultValue="1") int page 
	) throws Exception {
		
		//HashMap<String, Object> result = new HashMap<>();
		
		String boardName = boardService.getBoardName(boardNo); 
		model.addAttribute("boardName", boardName);//게시판 이름
			
		PostDTO searchListPostDTO = new PostDTO();
		searchListPostDTO.setBoardNo(boardNo); 
		searchListPostDTO.setType(type); 
		searchListPostDTO.setKeyword(keyword); 
			
		//검색결과 리스트
		List<PostDTO> searchList = boardService.searchList(searchListPostDTO, page); 
		model.addAttribute("searchList", searchList); 
		//result.put("searchList", searchList);	
			
		//검색결과 수 searchCount
		int searchCount = boardService.searchCount(searchListPostDTO); 
		model.addAttribute("searchCount", searchCount);
		//result.put("searchCount", searchCount); 
			
		//페이징
		PageDTO searchListPageDTO = boardService.searchPageDTO(searchListPostDTO, page); 
		
		model.addAttribute("boardNo", boardNo); //게시판 일련번호(인덱스)
		
		//result.put("searchListPageDTO", searchListPageDTO); // 페이징
		model.addAttribute("searchListPageDTO", searchListPageDTO);
		
		//result.put("page", page);
		model.addAttribute("page", page);
		
		//result.put("type", type);
		model.addAttribute("type", type);
		
		//result.put("keyword", keyword);
		model.addAttribute("keyword", keyword);
		
		//result.put("boardNo", boardNo); 
		//ResponseEntity.ok(result); 
		return "board/main";
	} 

	//2. 글쓰기 페이지로 이동 
	@RequestMapping("/write") 
	public String write(Model model, @RequestParam("boardNo") int boardNo){
		model.addAttribute("boardNo", boardNo); //게시판 일련번호(인덱스)
		return "board/write";
	}

	//2.1) 게시글 등록 Creating 
	@RequestMapping("/writeProcess")
    public @ResponseBody PostDTO writeProcess
    (HttpServletRequest request, HttpServletResponse response, PostDTO writePostDTO, MultipartFile imageFile) throws Exception{	
		PostDTO postDTO = boardService.writeProcess(writePostDTO);
        return postDTO;
    }

	// 3.글 수정 페이지로 이동(Updating)
	@RequestMapping("/modify")
	public String modify
	(@RequestParam("postNo") int postNo, @ModelAttribute("modifyPostDTO") PostDTO modifyPostDTO, Model model) {
				
		model.addAttribute("postNo", postNo);
		
		PostDTO PostDTOfromDB = boardService.read(postNo); 
		model.addAttribute("PostDTOfromDB", PostDTOfromDB); //수정하고자 하는 그 글! 
					
		return "board/modify";	
	}
	
	//3.1) 게시판 수정완료(Complete Updating)
	@RequestMapping("/modifyProcess")
	public @ResponseBody PostDTO modifyProcess
	(HttpServletRequest request, HttpServletResponse response, PostDTO modifyPostDTO, MultipartFile imageFile) throws Exception{
		PostDTO postDTO = boardService.modify(modifyPostDTO); 
		//수정하겠다고 하는 그 글들이 입력되어 고쳐쓴 새로운 PostDTO가 된다. 
		return postDTO;
	}
	
	//4. 글읽기 Reading (댓글 포함)
	@RequestMapping("/read")
	public String read
	(@RequestParam("postNo") int postNo, @ModelAttribute("readPostDTO") PostDTO postDTO, Model model) {
			
		PostDTO readPostDTO = boardService.read(postNo);
			
		model.addAttribute("readPostDTO", readPostDTO); 
		model.addAttribute("postNo", postNo);
					
		boardService.increasingViewCount(postNo); //조회수 증가 
			
		List<ReplyDTO> replyList =  replyService.replyList(postNo); //댓글출력 
		model.addAttribute("replyList", replyList); 
			
		return "board/read";
		
	}

	//5. 글삭제(Deleting)
	@RequestMapping("/deletePost")
    public @ResponseBody PostDTO deleteBoard
    (HttpServletRequest request, HttpServletResponse response, int postNo) throws Exception{
        PostDTO postDTO = boardService.deletePost(postNo); 
        return postDTO;
    }
	
	//6.1) 댓글등록 
	@RequestMapping("/writeReplyProcess")
    public @ResponseBody ReplyDTO writeReplyProcess
    (HttpServletRequest request, HttpServletResponse response, ReplyDTO writeReplyDTO) {	
		
		ReplyDTO ReplyDTO = replyService.writeReplyProcess(writeReplyDTO);
		
        return ReplyDTO;
    }
	
	//6.2) 댓글삭제
	@RequestMapping("/removeReply")
	public @ResponseBody ReplyDTO removeReply
	(HttpServletRequest request, HttpServletResponse response, int replyNo) {
	
		ReplyDTO ReplyDTO = replyService.removeReply(replyNo); 
		return ReplyDTO;
		
	}
	
	//7. 이미지 첨부파일 삭제
	@RequestMapping("/deleteImageFile")
	public @ResponseBody PostDTO deleteImageFile(HttpServletRequest request, HttpServletResponse response, PostDTO imageFilePostDTO) {
		PostDTO afterDeletingImageFile = boardService.deleteImageFile(imageFilePostDTO); 
		return afterDeletingImageFile;
	}

	//8. 좋아요(추천, 공감, Recommend)
	@RequestMapping("/like") 
	public @ResponseBody PostDTO like(HttpServletRequest request, HttpServletResponse response, int postNo) throws Exception {
		PostDTO likePostDTO = boardService.like(postNo);
		return likePostDTO;
	}

	//9.1) 게시글 신고페이지로 이동! 
	@RequestMapping("/report")
	public String report(@RequestParam("postNo") int postNo, Model model) {
		model.addAttribute("postNo", postNo);
		return "board/report";		
	}
	
	//9.2) 게시글 신고
	@RequestMapping("/reportProcess")
	public @ResponseBody ReportDTO reportProcess
	(HttpServletRequest request, HttpServletResponse response, ReportDTO submitReportDTO, MultipartFile imageFile) throws Exception{	
		ReportDTO reportDTO = boardService.reportProcess(submitReportDTO);
		return reportDTO;
	}
	
}