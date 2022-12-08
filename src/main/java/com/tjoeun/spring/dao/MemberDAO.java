package com.tjoeun.spring.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tjoeun.spring.dto.MemberDTO;


@Repository
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
		
	//1. 회원가입
	public void signUpProcess(MemberDTO signUpMemberDTO) {
		sqlSessionTemplate.insert("member.signUpProcess", signUpMemberDTO);
	}

	//2. 아이디 대용인 이메일 중복체크
	public String checkEmail(String email) {
		return sqlSessionTemplate.selectOne("member.checkEmail", email);
	}

	//3. 대화명 중복체크
	public String checkNick(String nick) {
		String checkingNick = sqlSessionTemplate.selectOne("member.checkNick", nick);
		return checkingNick;
	}

	//4. Log In or Sign In
	public MemberDTO signIn(MemberDTO tmpLoginMemberDTO) {
		return sqlSessionTemplate.selectOne("member.signIn", tmpLoginMemberDTO);
	}
	

	
	
	
	
	
		

}
