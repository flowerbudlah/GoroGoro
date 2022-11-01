package com.tjoeun.spring.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.spring.dto.MemberDTO;


@Repository
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
		
	public int signUpProcess(MemberDTO signUpMemberDTO) {
		return sqlSessionTemplate.insert("member.signUpProcess", signUpMemberDTO);
	}
	
	
	
	
	
	

}
