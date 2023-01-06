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
	
	
	//1. 전체게시물이 있는 게시판 메인화면(페이지 작업 수행 rowBounds)으로 간다. 
	public List<PostDTO> goMain(int boardNo, RowBounds rowBounds){
		List<PostDTO> postList = sqlSessionTemplate.selectList("board.goMain", boardNo, rowBounds); 
		return postList;
	}
	
	//마이페이지에서 내가 쓴 게시물
	public List<PostDTO> goMyPosts(int memberNo, RowBounds rowBounds){
		List<PostDTO> myPostList = sqlSessionTemplate.selectList("board.goMyPosts", memberNo, rowBounds); 
		return myPostList;
	}
	
	
	//2. 해당 게시판에 있는 전체게시물 리스트(페이지 작업때문에 필요함.)
	public int getPostCnt(int boardNo) {
		int postCnt = sqlSessionTemplate.selectOne("board.getPostCnt", boardNo);
		return postCnt;
	}

	//2. 글쓰기 Create
	public int writeProcess(PostDTO writePostDTO) {
		return sqlSessionTemplate.insert("board.writeProcess", writePostDTO); 
	}
	
	
	//신고하기 
	public int submit(ReportDTO submitReportDTO) {
		return sqlSessionTemplate.insert("board.submit" ,submitReportDTO);
	}
	
	
	
	//3. 특정한 글 하나 읽기 Read
	public PostDTO read(int postNo){
		PostDTO readPostDTO = sqlSessionTemplate.selectOne("board.read", postNo);
		return readPostDTO;
	}

	//4. 특정 글 삭제하기
	public int deletePost(int postNo) throws Exception { 
		return sqlSessionTemplate.delete("board.deletePost", postNo);
	}
		
	//7. 좋아요 버튼
	public int like(int postNo) throws Exception {
		return sqlSessionTemplate.update("board.like", postNo); 
	}
	
	//5. 게시판 이름 가져오기 
	public String getBoardName(int boardNo) {
		return sqlSessionTemplate.selectOne("board.getBoardName", boardNo);
	}
	
	//6. 조회수 증가 
	public void increasingViewCount(int postNo) {
		sqlSessionTemplate.update("board.increasingViewCount", postNo); 
	}
	
	//8. 글 수정
	public int modify(PostDTO modifyPostDTO) {
		return sqlSessionTemplate.update("board.modify", modifyPostDTO);
	}

	//글 수정시 아예 이미지 파일을 없애는 쿼리
	public int deleteImageFile(PostDTO imageFilePostDTO) {
		return sqlSessionTemplate.update("board.deleteImageFile", imageFilePostDTO);
	}

	//게시판 글 검색
	public List<PostDTO> searchList(PostDTO searchListPostDTO) throws Exception {
		return sqlSessionTemplate.selectList("board.searchList", searchListPostDTO); 
	}

	
	

	
	
	
	
}