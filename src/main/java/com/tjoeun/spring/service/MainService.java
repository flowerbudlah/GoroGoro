package com.tjoeun.spring.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tjoeun.spring.dao.BoardDAO;
import com.tjoeun.spring.dto.PostDTO;

@Service
public class MainService {
	
	@Autowired
	private BoardDAO boardDAO;
	
	
	public List<PostDTO> getMainList() {
		
		RowBounds rowBounds = new RowBounds(0, 3);//게시물은 3개만 등장 
		
		List<PostDTO> postList = boardDAO.goMain(1, rowBounds);//즉, BoardNo=1이면 공지사항만 등장 
		
		return postList;
	}
	

}
