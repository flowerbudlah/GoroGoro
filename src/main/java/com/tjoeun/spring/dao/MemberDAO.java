package com.tjoeun.spring.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.tjoeun.spring.dto.MemberDTO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
		
	//1. 1) 회원가입
	public int signUpProcess(MemberDTO signUpMemberDTO) {
		return sqlSessionTemplate.insert("member.signUpProcess", signUpMemberDTO);
	}

	//1. 2) 아이디 대용인 이메일 중복체크
	public String checkEmail(String email) {
		return sqlSessionTemplate.selectOne("member.checkEmail", email);
	}
	
	//1. 3) 대화명 중복체크
	public String checkNick(String nick) {
		return sqlSessionTemplate.selectOne("member.checkNick", nick);
	}

	//2. Log In or Sign In
	public MemberDTO signIn(MemberDTO tmpSignInMemberDTO) {
		return sqlSessionTemplate.selectOne("member.signIn", tmpSignInMemberDTO);
	}
	
	//3. 1) 수정할 회원정보 가져오기 
	public MemberDTO takeMemberDTO(int memberNo) {                      
		MemberDTO fromDBMemberDTO = sqlSessionTemplate.selectOne("member.takeMemberDTO", memberNo);
		return fromDBMemberDTO;
	} 
		
	//3. 2) 회원정보 수정
	public int modifyMemberDTO(MemberDTO modifyMemberDTO){
		return sqlSessionTemplate.update("member.modifyMemberDTO", modifyMemberDTO);
	}
	
	//회원 본인이 원해서 회원탈퇴
	public int leave(MemberDTO MemberDTOIsLeaving) {
		return sqlSessionTemplate.delete("member.leave", MemberDTOIsLeaving);
	}
	
	//아이디 대용인 이메일을 분실했을경우, 사용하던 닉네임을 입력한 뒤에 질문을 보여준다. 
	public MemberDTO takeQuestion(String nick) {
		return sqlSessionTemplate.selectOne("member.takeQuestion", nick);
	}
	
	
	
	


}