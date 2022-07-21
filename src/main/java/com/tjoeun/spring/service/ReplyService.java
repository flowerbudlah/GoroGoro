package com.tjoeun.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.tjoeun.spring.dao.ReplyDAO;

import com.tjoeun.spring.dto.ReplyDTO;

@Service
public class ReplyService {

	@Autowired
	private ReplyDAO replyDAO; 
	
	//1. 댓글 작성
	public ReplyDTO writeReplyProcess(ReplyDTO writeReplyDTO) {
		
		ReplyDTO replyDTO = new ReplyDTO();
			
		int writingCount = 0;
		
		writingCount = replyDAO.writeReplyProcess(writeReplyDTO); 
			
		if (writingCount > 0) {
			replyDTO.setResult("SUCCESS");
		} else {
			replyDTO.setResult("FAIL"); 
		}
			
		return replyDTO;				
	}
	
	
	//2. 댓글리스트 조회
	public List<ReplyDTO> replyList(int postNo){
		return replyDAO.replyList(postNo);
	}

	
	
	
	
	
	
}
