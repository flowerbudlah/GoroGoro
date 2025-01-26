package com.tjoeun.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.spring.dto.AdminReplyDTO;
import com.tjoeun.spring.dto.BoardDTO;
import com.tjoeun.spring.dto.CategoryDTO;
import com.tjoeun.spring.dto.FlagDTO;
import com.tjoeun.spring.dto.LoginRecordDTO;
import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.ReportDTO;
import com.tjoeun.spring.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;

	// 1. 회원 관리 페이지로 이동 (go to the Member management Page)
	@RequestMapping("/memberManagement")
	public String memberManagement(Model model) {

		List<MemberDTO> allMemberList = adminService.takeMemberList();
		model.addAttribute("allMemberList", allMemberList);

		return "admin/memberManagement";
	}

	// 1.1) 회원 관리 페이지에서 회원 검색(with using ajax)
	@GetMapping("/searchMemberList")
	public @ResponseBody List<MemberDTO> searchMemberList(@RequestParam("type") String type,
			@RequestParam("keyword") String keyword, Model model) throws Exception {

		MemberDTO searchListMemberDTO = new MemberDTO();
		searchListMemberDTO.setType(type);
		searchListMemberDTO.setKeyword(keyword);

		List<MemberDTO> searchMemberList = adminService.searchMemberList(searchListMemberDTO);
		model.addAttribute("searchMemberList", searchMemberList);
		return searchMemberList;
	}

	// 1.2) 로그인 기록 페이지로 이동
	@RequestMapping("/realTimeAboutLogin")
	public String realTimeAboutLogin(Model model, @RequestParam(value = "nick") String nick) {

		List<LoginRecordDTO> realTimeLoginRecordList = adminService.takeLoginRecord(nick);
		model.addAttribute("realTimeLoginRecordList", realTimeLoginRecordList);
		model.addAttribute("nick", nick);

		return "admin/realTimeAboutLogin";
	}

	// 2. 게시물 관리 페이지로 이동 (관리자에게 신고 접수된 게시물들을 보여준다. This page show administrator the reported Posts. )
	@RequestMapping("/postManagement")
	public String postManagement(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {

		List<ReportDTO> reportedPostList = adminService.takeReportedPost(page);
		model.addAttribute("reportedPostList", reportedPostList);

		// 페이징
		PageDTO pageDTO = adminService.reportedPost(page);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);

		return "admin/postManagement";
	}

	// 3. 게시판 관리 페이지로 이동 (go to the bulletin board management Page)
	@RequestMapping("/boardManagement")
	public String boardManagement() {
		return "admin/boardManagement";
	}

	// 3. 4) (카테고리에 포함된)게시판을 생성
	@RequestMapping("/makeBulletinBoard")
	public @ResponseBody BoardDTO makeBulletinBoard(BoardDTO BoardDTOinCategory) {

		// 변수로 들어온 값이 문자열이 전혀 없는 공란(" ", blank)뿐 이라면 불가
		if (BoardDTOinCategory.getBoardName().trim().isEmpty()) {

			return null;

		} else {

			// 입력된 카테고리 이름의 앞뒤 공란을 제거하는 처리
			BoardDTOinCategory.setBoardName(BoardDTOinCategory.getBoardName().trim()); 
			// trim() 이 기능이 특징이 만약에 공란(" ", blank)만 나오면 트림기능 작동못함.
			
			// 해당 카테고리 이름 중복되지 않았기에 사용가능한 경우, 
			if (this.checkBoardNameInTheSameCategory(BoardDTOinCategory)) {
				// 새로운 카테고리 생성
				return adminService.makeBoard(BoardDTOinCategory);

			// 해당 카테고리 이름이 이미 존재하기에 사용불가
			} else {

				return null;
			}
		}
	}

	// 게시판 관리 페이지 안에서 게시판 이름 변경한다.
	@RequestMapping("/changeBoardName")
	public @ResponseBody BoardDTO changeBoardName(BoardDTO boardDTOinCategory) {
		
		System.out.println("-----------------------------------------"); 
		System.out.println(boardDTOinCategory.getBoardCategoryNo()); 

		// 변수로 들어온 값이 문자열이 전혀 없는 공란(" ", blank)뿐 이라면 불가
		if (boardDTOinCategory.getBoardName().trim().isEmpty()) {

			return null;

		} else {

			// 입력된 카테고리 이름의 앞뒤 공란을 제거하는 처리
			boardDTOinCategory.setBoardName(boardDTOinCategory.getBoardName().trim());
			// trim() 이 기능이 특징이 만약에 공란(" ", blank)만 나오면 트림기능 작동못함.

			// 해당 카테고리 이름 중복되지 않았기에 사용가능한 경우, 
			if (this.checkBoardNameInTheSameCategory(boardDTOinCategory)) {

				// 이름 변경
				return adminService.changeBoardName(boardDTOinCategory);

			// 해당 카테고리 이름이 이미 존재하기에 사용불가
			} else {

				return null;
			}
		}
	}

	// 새로운 게시판을 만드는 경우, 같은 카테고리안에 있는 게시판의 이름이 같으면 만들 수 없는 기능
	public boolean checkBoardNameInTheSameCategory(BoardDTO boardNameAndCategoryNo) {

		String result = adminService.checkBoardNameInTheSameCategory(boardNameAndCategoryNo);

		if (result == null) {
			return true; // 사용가능
		} else {
			return false; // 사용불가
		}
	}

	// 3. 1) 게시판 관리 페이지 안에서 게시판 카테고리(게시판 대분류)를 생성한다.
	@RequestMapping("/makeCategory")
	public @ResponseBody CategoryDTO make(String boardCategoryName) {

		// 변수로 들어온 값이 문자열이 전혀 없는 공란(" ", blank)뿐 이라면 불가
		if (boardCategoryName.trim().isEmpty()) {

			return null;

		} else {

			// 입력된 카테고리 이름의 앞뒤 공란을 제거하는 처리
			boardCategoryName = boardCategoryName.trim();
			// trim() 이 기능이 특징이 만약에 공란(" ", blank)만 나오면 트림기능 작동못함.

			// 해당 카테고리 이름 중복되지 않았기에 사용가능한 경우, 
			if (this.checkCategoryName(boardCategoryName)) {
				// 새로운 카테고리 생성
				return adminService.makeCategory(boardCategoryName);

			// 해당 카테고리 이름이 이미 존재하기에 사용불가
			} else {

				return null;
			}
		}
	}

	// 3. 2) 카테고리 이름 중복체크 
	public boolean checkCategoryName(String boardCategoryName) {

		String result = adminService.checkCategory(boardCategoryName);

		// 입력한 해당 카테고리 이름은 없기에 사용가능
		if (result == null) {
			return true;
			
		// 해당 카테고리 이름이 이미 존재하기에 사용불가(해당 이름 중복)
		} else {
			return false; 
		}
	}

	// 3. 3) 카테고리 삭제
	@RequestMapping("/deleteCategory")
	public @ResponseBody CategoryDTO deleteCategory(int boardCategoryNo) {
		CategoryDTO categoryDTO = adminService.deleteCategory(boardCategoryNo);
		return categoryDTO;
	}

	// 1.5) 게시판 삭제
	@RequestMapping("/boardManagement/deleteBoard")
	public String deleteBoard(int boardNo) {
		adminService.deleteBoard(boardNo);
		return "redirect:/admin/boardManagement";
	}

	// 1.6) 게시판이 속한 대분류 카테고리 변경 Updating
	@RequestMapping("/boardManagement/changeCategory")
	public String changeCategory(BoardDTO BoardDTOinCategory) {
		adminService.changeCategory(BoardDTOinCategory);
		return "redirect:/admin/boardManagement";
	}
	
	// 관리자의 신고된 글에 대한 검색과 페이지(페이지 1 2 3 4 5 6 7 8 9 10)
	@RequestMapping("/searchResult")
	public String searchResult(Model model, @RequestParam("type") String type, @RequestParam("keyword") String keyword, @RequestParam(value = "page", defaultValue = "1") int page) throws Exception {

		ReportDTO searchListReportDTO = new ReportDTO();
		searchListReportDTO.setType(type);
		searchListReportDTO.setKeyword(keyword);

		// 검색결과 리스트
		List<ReportDTO> searchList = adminService.searchList(searchListReportDTO, page);
		model.addAttribute("searchList", searchList);
		// result.put("searchList", searchList);

		// 검색결과 수 searchCount
		int searchCount = adminService.searchCount(searchListReportDTO);
		model.addAttribute("searchCount", searchCount);
		// result.put("searchCount", searchCount);

		// 페이징
		PageDTO searchListPageDTO = adminService.searchPageDTO(searchListReportDTO, page);
		// result.put("searchListPageDTO", searchListPageDTO); // 페이징
		model.addAttribute("searchListPageDTO", searchListPageDTO);

		// result.put("page", page);
		model.addAttribute("page", page);

		// result.put("type", type);
		model.addAttribute("type", type);

		// result.put("keyword", keyword);
		model.addAttribute("keyword", keyword);

		// result.put("boardNo", boardNo);
		// ResponseEntity.ok(result);
		return "admin/postManagement";
	}

	// 6.1) 관리자가 신고된 글에대한 답글을 다는것
	@RequestMapping("/writeAdminReplyProcess")
	public @ResponseBody AdminReplyDTO writeReplyProcess(HttpServletRequest request, HttpServletResponse response, AdminReplyDTO writeAdminReplyDTO) {

		AdminReplyDTO adminReplyDTO = adminService.writeAdminReplyProcess(writeAdminReplyDTO);
		return adminReplyDTO;

	}

	// 6.2) 관리자의 신고된 글에 대한 댓글삭제
	@RequestMapping("/removeAdminReply")
	public @ResponseBody AdminReplyDTO removeAdminReply(HttpServletRequest request, HttpServletResponse response, int replyNo) {

		AdminReplyDTO ReplyDTO = adminService.removeAdminReply(replyNo);
		return ReplyDTO;
	}


	
}