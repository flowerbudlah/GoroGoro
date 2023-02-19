package com.tjoeun.spring.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.dto.ReportDTO;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//1. 1) 전체게시물이 있는 게시판 메인화면(페이지 작업 수행 rowBounds)으로 간다. 
	public List<PostDTO> goMain(int boardNo, RowBounds rowBounds){
		List<PostDTO> postList = sqlSessionTemplate.selectList("board.goMain", boardNo, rowBounds); 
		return postList;
	}
	
	//1. 2) 해당 게시판에 있는 전체게시물의 수(페이지 작업때문에 필요함.)
	public int getPostCnt(int boardNo) {
		int postCnt = sqlSessionTemplate.selectOne("board.getPostCnt", boardNo);
		return postCnt;
	}
	
	
	//1. 3) 게시판 이름 가져오기 
	public String getBoardName(int boardNo) {
		return sqlSessionTemplate.selectOne("board.getBoardName", boardNo);
	}
	
	//2. 1) 글쓰기 Create
	public int writeProcess(PostDTO writePostDTO) {
		return sqlSessionTemplate.insert("board.writeProcess", writePostDTO); 
	}
	
	//2. 2) 관리자에게 신고하기  
	public int reportProcess(ReportDTO submitReportDTO) {
		return sqlSessionTemplate.insert("board.reportProcess", submitReportDTO); 
	}
		
	//3. 1) 특정한 글 하나 읽기 Read
	public PostDTO read(int postNo){
		PostDTO readPostDTO = sqlSessionTemplate.selectOne("board.read", postNo);
		return readPostDTO;
	}

	//3. 2) 조회수 증가 
	public void increasingViewCount(int postNo) {
		sqlSessionTemplate.update("board.increasingViewCount", postNo); 
	}
	
	//4. 특정 글 삭제하기 Delete
	public int deletePost(int postNo) throws Exception { 
		return sqlSessionTemplate.delete("board.deletePost", postNo);
	}
		
	//5. 1) 글 수정 Updating
	public int modify(PostDTO modifyPostDTO) {
		return sqlSessionTemplate.update("board.modify", modifyPostDTO);
	}

	//5. 2) 글 수정시 아예 이미지 파일을 없애는 쿼리
	public int deleteImageFile(PostDTO imageFilePostDTO) {
		return sqlSessionTemplate.update("board.deleteImageFile", imageFilePostDTO);
	}

	//6. 좋아요 버튼
	public int like(int postNo) throws Exception {
		return sqlSessionTemplate.update("board.like", postNo); 
	}
	
	//7.1) 마이페이지에서 내가 쓴 게시물보기
	public List<PostDTO> goMyPosts(int memberNo, RowBounds rowBounds){
		List<PostDTO> myPostList = sqlSessionTemplate.selectList("board.goMyPosts", memberNo, rowBounds); 
		return myPostList;
	}
	
	//7. 2) 마이페이지의 내가 쓴글 그 해당 게시판에 있는 전체게시물의 수(페이지 작업때문에 필요함.)
	public int takeCountOfMyPost(int memberNo) {
		int countOfMyPost = sqlSessionTemplate.selectOne("board.takeCountOfMyPost", memberNo);
		return countOfMyPost;
	}
	

	//1. 4) 메인 게시판에서 글 검색
	public List<PostDTO> searchList(PostDTO searchListPostDTO, RowBounds rowBounds) throws Exception {
			
		List<PostDTO> searchList = sqlSessionTemplate.selectList("board.searchList", searchListPostDTO, rowBounds);
		return searchList; 
		
	}	
	

	//아작스로 검색 시 검색결과 수(아작스로 페이징 작업때문에 필요) 
	public int searchCount(PostDTO searchListPostDTO) {
		int searchCount = sqlSessionTemplate.selectOne("board.searchCount", searchListPostDTO);
		return searchCount; 
	}
	
	
	
	

	
	
}