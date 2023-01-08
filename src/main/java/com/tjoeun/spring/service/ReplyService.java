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
	
	//1. 댓글 작성 Create 
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
	
	//2. 댓글리스트 조회 Read
	public List<ReplyDTO> replyList(int postNo){
		return replyDAO.replyList(postNo);
	}

	//3. 댓글삭제 delete
	public ReplyDTO removeReply(int replyNo) {
		
		ReplyDTO replyDTO = new ReplyDTO();
		
		int removeCount = replyDAO.removeReply(replyNo); 
		
		if(removeCount > 0) { //댓글삭제 성공
			replyDTO.setResult("SUCCESS");
		}else{ //댓글삭제 미성공
			replyDTO.setResult("FAIL"); //대소문자가 중요합니다. 
		}
		
		return replyDTO;
	}
	

	
}
