package com.tjoeun.spring.controller;

import java.io.IOException;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Lazy
	@Resource(name="signInMemberDTO") 
	private MemberDTO signInMemberDTO; //로그인, 세션 쿠키와 관련있는 부분

	//1. 1) 회원가입 페이지로 이동
	@RequestMapping("/signUp")
	public String signUp(){ //회원가입 페이지로 이동
		return "member/signUp";
	}
	
	//1. 2) 아이디용인 이메일 중복체크(at 회원가입 페이지)
	@RequestMapping("/checkEmail")
	public @ResponseBody String checkEmail(String email) {
		
		String result = memberService.checkEmail(email);
			
		if(result == null){
			return "available"; //사용가능
		} else {
			return "unavailable"; //사용불가
		}
	}
	
	//1. 3) 닉네임 중복체크(회원가입시)
	@RequestMapping("/checkNick")
	public @ResponseBody String checkNick(String nick) {
		String result = memberService.checkNick(nick);
		if(result == null){
			return "available"; //사용가능
		} else {
			return "unavailable"; //사용불가
		}
	}
	
	//2. 회원가입 완료버튼 누르고 회원가입 하기(Creating)
	@RequestMapping("/signUpProcess")
	public @ResponseBody MemberDTO signUpProcess(MemberDTO signUpMemberDTO){
		MemberDTO newMemberDTO = memberService.signUpProcess(signUpMemberDTO); //회원가입 완료
		return newMemberDTO; 
	}
	
	
	
	//3.1) "회원정보수정페이지(modification)"로 이동한다. 
	@GetMapping("/modify")
	public String modify(@ModelAttribute("modifyMemberDTO") MemberDTO modifyMemberDTO) {
		memberService.takeMemberDTO(modifyMemberDTO); //회원정보를 수정할 대상을 가져온다. 
		return "member/modify";
	}
		
	//3.2) 닉네임 중복체크(at 회원정보수정 페이지)
	@RequestMapping("/checkNickInModify")
	public @ResponseBody String checkNickInModify(String nick) {
		
		System.out.println("===================================Test=============================================="); 
		System.out.println("signInMemberDTO: "+signInMemberDTO.getNick());
		System.out.println(nick); 
			
		String result = memberService.checkNick(nick);
		System.out.println("result: " +result); 
		System.out.println(signInMemberDTO.getNick().equalsIgnoreCase(result)); // 
			
		if(result == null){ //그 닉네임을 넣어봤더니 사용하고 있는 사람이 없다. 
			return "available"; //사용가능
		} else { //그 닉네임을 넣어봤더니 사용하고 있는 사람이 있으니 그 닉네임 사용할수없다. 
			if( result.equalsIgnoreCase(signInMemberDTO.getNick()) ) {
				return "available"; //사용가능
			} else {
				return "unavailable"; //사용불가
			}
		}
	}
	
	
	//4. 회원정보수정 완료 버튼 누르고, 진짜 회원정보 수정이 이뤄지는 그 과정
	@RequestMapping("/modifyProcess")
	public @ResponseBody MemberDTO modifyMemberDTO(MemberDTO modifyMemberDTO){
		
		//수정할 대상인 회원정보를 수정한 뒤에 정보수정을 완료한 새로운 memberDTO를 가져온다. 
		MemberDTO memberDTOAfter = memberService.modifyMemberDTO(modifyMemberDTO);
		return memberDTOAfter;
	}
		
	//5.1) 로그인 페이지로 입장
	@RequestMapping("/signIn")
	public String signIn() {
		return "member/signIn";
	}
	
	//5.2) 로그인버튼을 누르고 로그인성공하기. 
	@PostMapping("/signInProcess")
	public void signInProcess
	(HttpServletRequest request, HttpServletResponse response, MemberDTO tmpSignInMemberDTO) {
				
		memberService.signIn(tmpSignInMemberDTO); //로그인 시도 
			
		if(signInMemberDTO.isSignIn() == true) {//이것은 로그인이 성공했다는 의미
		} else if(signInMemberDTO.isSignIn() ==  false ) { //이것은 로그인 실패 
			try {
				response.getWriter().write("loginFail");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	

	//6. 로그아웃(Sign Out)
	@ResponseBody 
	@RequestMapping("/signOut")
	public void signOut(HttpSession session) {
		signInMemberDTO.setSignIn(false); //로그인 풀리고, 
		session.invalidate(); //세션 종료
	}
	

	//7. 회원탈퇴 페이지로 간다. 
	@RequestMapping("/getOut")
	public String getOut() {
		return "member/getOut";	
	}
	
	
	//회원본인이 원해서 회원탈퇴한다.(아작스)
	@RequestMapping("/leave")
	public @ResponseBody MemberDTO leave(MemberDTO memberDTOisLeaving) throws Exception{
		
		MemberDTO memberDTO = memberService.leave(memberDTOisLeaving); 
		return memberDTO;

	}
	
	@RequestMapping("/findPasswords")
	public String finePasswords() {
		return "member/findPasswords";
	}
		
	
	@RequestMapping("/findEmail")
	public String fineEmail() {
		return "member/findEmail";
	}
	
	
	//아이디 대용인 이메일을 분실했을경우, 사용하던 닉네임을 입력한 뒤에 질문을 보여준다. 
	@GetMapping("/findIDemail")
	public @ResponseBody String findEmail
	(@RequestParam("nick") String nick, @RequestParam("answer") String answer, Model model) {
		
		MemberDTO memberDTOtoFindEmail = new MemberDTO(); 
		memberDTOtoFindEmail.setNick(nick);  
		memberDTOtoFindEmail.setAnswer(answer);  
		
		String email = memberService.findEmail(memberDTOtoFindEmail); 		
		model.addAttribute("email", email);
		return email;

	}
	

	//아이디 대용인 이메일을 분실했을경우, 사용하던 닉네임을 입력한 뒤에 질문을 보여준다. 
	@GetMapping("/takeQuestion")
	public @ResponseBody MemberDTO takeQuestion(@RequestParam("nick") String nick, Model model) {
		
		MemberDTO toFindEmail = memberService.takeQuestion(nick);
		model.addAttribute("toFindEmail", toFindEmail);
		
		return toFindEmail;  //result
	}
	
	
	
	
	
	
	
	
	
	
	
	
}