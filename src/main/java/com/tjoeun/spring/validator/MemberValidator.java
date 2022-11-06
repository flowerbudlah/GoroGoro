package com.tjoeun.spring.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.tjoeun.spring.dto.MemberDTO;

//회원가입시 유효성을 검사하는 
public class MemberValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		MemberDTO loginMemberDTO = (MemberDTO)target; //로그인을 한 loginMemberDTO이 타켓이 된다. 
		
		String dtoName = errors.getObjectName();
		System.out.println("dtoName : " + dtoName);
		
		if(dtoName.equals("signUpMemberDTO")) {
		//검증대상이 회원가입을 하고자하는 사람이거나 or 회원정보를 수정하려는 대상이거나 
			
			if(loginMemberDTO.getPasswords().equals(loginMemberDTO.getPasswords2())  == false) {
			//회원가입 시 패스워드를 위아래 두번 맞게 입력해야한다. 그러나, 위아래 패스워드가 다르다면, 아래의 에러를 보낼것이다. 
				errors.rejectValue("passwords", "NotEquals");
				errors.rejectValue("passwords2", "NotEquals");
			}
		}
		
		if(dtoName.equals("signUpMemberDTO")){
		//회원가입시 완료버튼을 누르기 전에, 중복검사 버튼을 눌러서 중복체크를 해야하는데, 그 중복체크를 한번은 수행하도록 
			
			if(loginMemberDTO.isInputEmail() == false) {	
			//아이디 대용인 이메일 검사버튼을 한번은 누르고 검사하고 회원가입 버튼 누르기.  
				errors.rejectValue("email", "CheckDuplicateEmailExist");
			}
		
			if(loginMemberDTO.isInputNick() == false) {	
			//대화명(닉네임) 중복검사버튼을 한번은 누르고 검사하고 회원가입 버튼 누르기. 
				errors.rejectValue("nick", "CheckDuplicateNickExist");
			}
			
			
			
		}
			
	}

	
}
