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

import com.tjoeun.spring.dto.AdminReplyDTO;
import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.PostDTO;

import com.tjoeun.spring.dto.ReportDTO;
import com.tjoeun.spring.service.AdminService;

import com.tjoeun.spring.service.MyPageService;


@Controller
@RequestMapping("/myPage")
public class MyPageController {
	
	@Autowired
	private MyPageService myPageService; 
	
	@Autowired
	private AdminService adminService;
	
	//내가 신고한 내역보기 
	@RequestMapping("/reportList")
	public String myProfile
	(@RequestParam("reporter") String reporter, 
	@RequestParam(value="page", defaultValue="1") int page, Model model){
		model.addAttribute("reporter", reporter); //게시판 일련번호(인덱스)
		
		List<ReportDTO> myReportList = myPageService.takeMyReportedPost(reporter, page); 
		model.addAttribute("myReportList", myReportList);//게시판 이름
		
		//페이징
		PageDTO pageDTO = myPageService.mainPageDTO(reporter, page); 
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);
		
		return "myPage/reportList";
		
	}
	
	//검색과 페이지(페이지 [이전] 1 2 3 4 5 6 7 8 9 10 [다음])
	//"내가 쓴 게시글" (In My Page)
	@RequestMapping("/searchReport")
	public String searchReport
	(Model model, 
	@RequestParam("type") String type, 
	@RequestParam("keyword") String keyword, 
	@RequestParam("reporter") String reporter, 
	@RequestParam(value="page", defaultValue="1") int page ) throws Exception {
								
		ReportDTO searchListReportDTO = new ReportDTO(); 
						
		searchListReportDTO.setType(type); 
		searchListReportDTO.setKeyword(keyword); 
		searchListReportDTO.setReporter(reporter); 
					
		//내가 쓴 글 검색결과 리스트
		List<PostDTO> searchReportList = myPageService.searchReportList(searchListReportDTO, page); 
		model.addAttribute("searchReportList", searchReportList); 
					
		//검색결과 수 searchCount
		int searchReportCount = myPageService.searchReportCount(searchListReportDTO); 
		model.addAttribute("searchReportCount", searchReportCount);

		//페이징(검색 이후의 )
		PageDTO searchReportPageDTO = myPageService.searchReportPageDTO(searchListReportDTO, page);			
		model.addAttribute("searchReportPageDTO", searchReportPageDTO);
		model.addAttribute("page", page);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("reporter", reporter);
			
		return "myPage/reportList";
		
	} 
	
	
	
	//2.1) 신고내용 읽기 Reading (댓글 포함)
	@RequestMapping("/reportedPost")
	public String readReportDTO
	(@ModelAttribute("readReportDTO") ReportDTO reportDTO, @RequestParam("reportNo") int reportNo, Model model){
			
		ReportDTO readReportDTO = myPageService.readReportDTO(reportNo); 
			
		model.addAttribute("reportNo", reportNo);		
		model.addAttribute("readReportDTO", readReportDTO); 
			
		List<AdminReplyDTO> adminReplyList =  adminService.replyAdminList(reportNo); //관리자 답변 댓글출력 
		model.addAttribute("adminReplyList", adminReplyList); 
				
		return "myPage/reportedPost";		
	}
		
	//5. 신고내용 삭제(Deleting)
	@RequestMapping("/deleteReportDTO")
	public @ResponseBody ReportDTO deleteReportDTO(
		
		HttpServletRequest request, HttpServletResponse response, int reportNo) throws Exception{
		
		ReportDTO reportDTO = myPageService.deleteReportDTO(reportNo); 
		return reportDTO;
		
	}

	
	//내가 쓴 게시물 
	@RequestMapping("/myPosts")
	public String myPost
	(Model model, 
	@RequestParam("memberNo") int memberNo, 
	@RequestParam(value="page", defaultValue="1") int page){
		
		model.addAttribute("memberNo", memberNo); //게시판 일련번호(인덱스)
			
		List<PostDTO> myPostList = myPageService.goMyPosts(memberNo, page);
		model.addAttribute("myPostList", myPostList); //내가 쓴 글의 목록
		
		//페이징
		PageDTO pageDTO = myPageService.takeCountOfMyPost(memberNo, page); 
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);
		
		return "myPage/myPosts";
	}
	
	//검색과 페이지(페이지 [이전] 1 2 3 4 5 6 7 8 9 10 [다음])
	//"내가 쓴 게시글" (In My Page)
	@RequestMapping("/searchResult")
	public String searchResult
	(Model model, 
	@RequestParam("type") String type, 
	@RequestParam("keyword") String keyword, 
	@RequestParam("writer") String writer, 
	@RequestParam(value="page", defaultValue="1") int page ) throws Exception {
							
		PostDTO searchListPostDTO = new PostDTO(); 
					
		searchListPostDTO.setType(type); 
		searchListPostDTO.setKeyword(keyword); 
		searchListPostDTO.setWriter(writer); 
				
		//내가 쓴 글 검색결과 리스트
		List<PostDTO> mySearchList = myPageService.searchList(searchListPostDTO, page); 
		model.addAttribute("mySearchList", mySearchList); 
				
		//검색결과 수 searchCount
		int searchCount = myPageService.searchCount(searchListPostDTO); 
		model.addAttribute("searchCount", searchCount);

		//페이징
		PageDTO searchListPageDTO = myPageService.searchPageDTO(searchListPostDTO, page);			
		model.addAttribute("searchListPageDTO", searchListPageDTO);
		model.addAttribute("page", page);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("writer", writer);
		
		return "myPage/myPosts";
	} 

	
}