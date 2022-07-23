package com.tjoeun.spring.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.tjoeun.spring.dto.ReplyDTO;


@Repository
public class ReplyDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//1. 댓글 작성
	public int writeReplyProcess(ReplyDTO writeReplyDTO) {
		return sqlSessionTemplate.insert("reply.writeReplyProcess", writeReplyDTO); 
	}
	
	//2. 댓글 목록 가져오기
	public List<ReplyDTO> replyList(int postNo){
	    return sqlSessionTemplate.selectList("reply.replyList", postNo);
	}
	
	//3. 댓글삭제
	public int removeReply(int replyNo) {
		return sqlSessionTemplate.delete("reply.removeReply", replyNo);
	}
	
	
	
	
	
	
	
	
}
