package com.tjoeun.spring.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.spring.dao.BoardDAO;
import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.dto.ReportDTO;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class BoardService {
		
	@Value("${path.load}")
	private String pathLoad; //파일 업로드와 관련있다. 파일이 저장되는 경로

	@Value("${page.listcnt}")
	private int page_listcnt; // 한 페이지당 보여주는 글의 개수
	
	@Value("${page.paginationcnt}")
	private int page_paginationcnt;	// 한 페이지당 보여주는 페이지 버튼 개수
	
	@Autowired
	private BoardDAO boardDAO; 
	
	//1. 1) 게시판 메인 페이지로 이동(페이지 작업 완료)
	public List<PostDTO> goMain(int boardNo, int page) {
		
		int start = (page - 1) * page_listcnt; //한 페이지 
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		
		List<PostDTO> postList = boardDAO.goMain(boardNo, rowBounds);
		return postList;
	}
	
	//1. 2) 메인페이지의 페이징 작업  
	public PageDTO mainPageDTO(int boardNo, int currentPage) {
				
		//게시판 메인 페이지의 페이징과 관련있는 해당 게시판의 전체 글 수
		int postCnt = boardDAO.getPostCnt(boardNo); 
		
		//page_listcnt: 한 페이지당 보여주는 글의 개수, page_paginationcnt: 한 페이지당 보여주는 페이지 버튼 개수
		PageDTO pageDTO = new PageDTO(postCnt, currentPage, page_listcnt, page_paginationcnt);
		return pageDTO;
	}

	//1. 3) 게시판 메인화면 게시글 검색
	public List<PostDTO> searchList(PostDTO searchListPostDTO, int page) throws Exception {
		
		int start = (page - 1) * page_listcnt; //한 페이지 
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		
		List<PostDTO> searchList = boardDAO.searchList(searchListPostDTO, rowBounds);		
		return searchList; 
	}
	
	//1. 2) 메인페이지의 페이징 작업  
	public PageDTO searchPageDTO(PostDTO searchListPostDTO, int currentPage) {
		//아작스로 검색을 했을 때 나오는 게시물 수 
		int searchCount = boardDAO.searchCount(searchListPostDTO);
		PageDTO searchPageDTO = new PageDTO(searchCount, currentPage, page_listcnt, page_paginationcnt);
		return searchPageDTO;
	}
	
	public int searchCount(PostDTO searchListPostDTO) {
		int searchCount = boardDAO.searchCount(searchListPostDTO);
		return searchCount;
	}
	
	
	//1. 4) 게시판 이름 가져오기 
	public String getBoardName(int boardNo) {
		return boardDAO.getBoardName(boardNo);
	}
	

	//2. 1) 글쓰기 
	public PostDTO writeProcess(PostDTO writePostDTO) throws Exception {
		
		PostDTO postDTO = new PostDTO();
		
		//이미지 파일을 업로드
		MultipartFile imageFile = writePostDTO.getImageFile(); 
		String UploadingImageFileName = saveUploadFile(imageFile);
		writePostDTO.setImageFileName(UploadingImageFileName);
				
		int writingCount = boardDAO.writeProcess(writePostDTO); //글 입력
		
		if (writingCount > 0) {
			postDTO.setResult("SUCCESS");
		} else {
			postDTO.setResult("FAIL"); 
		}
		return postDTO;		
	}
	
	//2. 2) 이미지 파일 첨부
	public String saveUploadFile(MultipartFile imageFile) {
				
		String imageFileName = imageFile.getOriginalFilename();
				
		try {
			imageFile.transferTo(new File(pathLoad + "/" + imageFileName));
		} catch (IllegalStateException e){
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return imageFileName;
	}
		
	
	//2. 3) 게시물 신고  Create
	public ReportDTO reportProcess(ReportDTO submitReportDTO) throws Exception {
			
		ReportDTO reportDTO = new ReportDTO();
			
		MultipartFile imageFile = submitReportDTO.getImageFile(); 
		String UploadingImageFileName = saveUploadFile(imageFile);
		submitReportDTO.setImageFileName(UploadingImageFileName);
					
		int submitCount = boardDAO.reportProcess(submitReportDTO); //제출
			
		if (submitCount > 0) {
			reportDTO.setResult("SUCCESS");
		} else {
			reportDTO.setResult("FAIL"); 
		}
		return reportDTO;		
	}

	//3. 1) 글수정
	public PostDTO modify(PostDTO modifyPostDTO) {
			
		PostDTO postDTO = new PostDTO(); 
		
		//글을 수정하면서 이참에 새롭게 이미지를 업로드 하실려는 경우, 
		MultipartFile imageFile = modifyPostDTO.getImageFile(); 
		
		if(imageFile.getSize() > 0) { //원글에서 업로드 된 파일이 있다면 
			String UploadingImageFileName = saveUploadFile(imageFile);
			modifyPostDTO.setImageFileName(UploadingImageFileName);
		}
		
		int updateCnt = boardDAO.modify(modifyPostDTO);
		
		if (updateCnt > 0) {
			postDTO.setResult("SUCCESS"); 
		} else {
			postDTO.setResult("FAIL");
		}
		return postDTO;
	}
	
	//3. 2) 글을 수정하는데 그냥 이미지 파일을 없애는 경우 
	public PostDTO deleteImageFile(PostDTO imageFilePostDTO) {
		
		PostDTO postDTO = new PostDTO(); 
		
		int deleteImageFile = boardDAO.deleteImageFile(imageFilePostDTO); 
		
		if (deleteImageFile > 0) {
			postDTO.setResult("SUCCESS"); 
		} else {
			postDTO.setResult("FAIL");
		}
		return postDTO;
	}
	
	//4. 1) 특정한 게시글 하나 읽기 Read
	public PostDTO read(int postNo){
		PostDTO readPostDTO = boardDAO.read(postNo);
		return readPostDTO;
	}

	//4. 2) 조회수 증가
	public void increasingViewCount(int postNo) {
		boardDAO.increasingViewCount(postNo); 	
	}
		
	//4. 3) 좋아요 공감버튼 
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

	//5. 게시글 삭제 Delete
	public PostDTO deletePost(int postNo) throws Exception {
		PostDTO postDTO = new PostDTO();
		int deleteCnt = boardDAO.deletePost(postNo);

		if (deleteCnt > 0) {
			postDTO.setResult("SUCCESS");
		} else {
			postDTO.setResult("FAIL");
		}
		return postDTO;
	}
	
}