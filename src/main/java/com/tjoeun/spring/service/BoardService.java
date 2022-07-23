package com.tjoeun.spring.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.tjoeun.spring.dao.BoardDAO;
import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.PostDTO;


@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class BoardService {
	
	@Value("${path.load}")
	private String pathLoad; //파일 업로드와 관련있다. 파일 경로 
	
	@Value("${page.listcnt}")
	private int page_listcnt; // 한 페이지당 보여주는 글의 개수
	
	@Value("${page.paginationcnt}")
	private int page_paginationcnt;	// 한 페이지당 보여주는 페이지 버튼 개수
	
	@Autowired
	private BoardDAO boardDAO; 
	
	
	
	//1. 게시판 메인 페이지로 이동(페이지 작업 완료)
	public List<PostDTO> goMain(int boardNo, int page) {
		
		int start = (page - 1) * page_listcnt; //한 페이지 
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		
		List<PostDTO> postList = boardDAO.goMain(boardNo, rowBounds);
		return postList;
	}
	
	
	
	//2. 게시판 메인 페이지의 페이징과 관련있는 해당 게시판의 전체 글 수
	public PageDTO getPostCnt(int boardNo, int currentPage) {
		
		int postCnt = boardDAO.getPostCnt(boardNo); //해당 게시판에 들어있는 게시글 수 
		
		PageDTO pageDTO = new PageDTO(postCnt, currentPage, page_listcnt, page_paginationcnt);
		//page_listcnt: 한 페이지당 보여주는 글의 개수
		//page_paginationcnt: 한 페이지당 보여주는 페이지 버튼 개수
		
		return pageDTO;
	}
	
	
	
	//2-2. 글쓰기
	public PostDTO writeProcess(PostDTO writePostDTO) {
				
		PostDTO postDTO = new PostDTO();
		
		int writingCount = 0;
		writingCount = boardDAO.writeProcess(writePostDTO); 
		if (writingCount > 0) {
			postDTO.setResult("SUCCESS");
		} else {
			postDTO.setResult("FAIL"); 
		}
		return postDTO;				
	}
	

	//3. 특정한 게시글 하나 읽기
	public PostDTO read(int postNo){
		PostDTO readPostDTO = boardDAO.read(postNo);
		return readPostDTO;
	}

	
	//4. 게시글 삭제
	public PostDTO deleteBoard(int boardForm) throws Exception {
			
			PostDTO boardDto = new PostDTO();
	 
	        int deleteCnt = boardDAO.deleteBoard(boardForm);
	 
	        if (deleteCnt > 0) {
	            boardDto.setResult("SUCCESS");
	        } else {
	            boardDto.setResult("FAIL");
	        }
	        
	        return boardDto;
	    }


	//7. 좋아요 공감버튼 
	public PostDTO like(int postNo) throws Exception {
			
		PostDTO likePostDTO = new PostDTO();
			
		int like = boardDAO.like(postNo);
			
		if (like > 0) {
			likePostDTO.setResult("SUCCESS");
		 }else{
			 likePostDTO.setResult("FAIL");
		 }
			return likePostDTO;
		}
	
	
	
	
	
	
	
	//5. 게시판 이름 가져오기 
	public String getBoardName(int boardNo) {
		return boardDAO.getBoardName(boardNo);
	}
	
	//6. 조회수 증가
	public void increasingViewCount(int postNo) {
		boardDAO.increasingViewCount(postNo); 	
	}
	
	
	//8. 글수정
	public PostDTO modify(PostDTO modifyPostDTO) {
		
		PostDTO postDTO = new PostDTO(); 
		
		int updateCnt = boardDAO.modify(modifyPostDTO);
		
		if (updateCnt > 0) {
			postDTO.setResult("SUCCESS"); 
		} else {
			postDTO.setResult("FAIL");
		}
		return postDTO;
	}
		
		
		
		
				
		
	}