package com.tjoeun.spring.controller;

import java.io.IOException;

import java.util.UUID;

import javax.annotation.Resource;

import java.util.Properties;

import javax.mail.*;


import javax.mail.Message;
import javax.mail.MessagingException;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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
	
	//1. 3) 닉네임 중복체크(회원가입시)
	@RequestMapping("/verifyEmail")
	public @ResponseBody String verifyEmail(String email) {
		
		String verificationResult = memberService.checkEmail(email);
		if(verificationResult == null){
			return "verificationOK"; //검증완료
		} else {
			return "verificationFail"; //검증불가
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
	public String modify
	(@ModelAttribute("modifyMemberDTO") MemberDTO modifyMemberDTO) {
		memberService.takeMemberDTO(modifyMemberDTO); //회원정보를 수정할 대상을 가져온다. 
		return "member/modify";
	}
		
	//3.2) 닉네임 중복체크(at 회원정보수정 페이지)
	@RequestMapping("/checkNickInModify")
	public @ResponseBody String checkNickInModify(String nick) {
		System.out.println("===================================Test==================================="); 
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
	
	//이메일 분실시 이메일 찾는 페이지로 간다. 
	@RequestMapping("/findEmail")
	public String fineEmail() {
		return "member/findEmail";
	}

	//아이디 대용인 이메일을 분실했을경우, 사용하던 닉네임을 입력한 뒤에 질문을 보여준다. 
	@GetMapping("/takeQuestion")
	public @ResponseBody MemberDTO takeQuestion(@RequestParam("nick") String nick, Model model) {
		
		MemberDTO toFindEmail = memberService.takeQuestion(nick);
		model.addAttribute("toFindEmail", toFindEmail);
		
		return toFindEmail;  //result
	}
	
	//이메일(아이디용)을 분실했을경우, 사용하던 닉네임을 입력한 뒤에 질문을 보여준다. 
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
	
	
	//비밀번호 분실시 비밀번호 찾는 페이지로 간다. 
	@RequestMapping("/findPasswords")
	public String finePasswords() {
		return "member/findPasswords";
	}
	
	//로그인시 패쓰워드를 분실했을경우, 로그인을 할때 입력하던 이메일 주소를 입력한 뒤 
	@GetMapping("/findPassword")
	public @ResponseBody MemberDTO findPassword(@RequestParam("email") String email, Model model) throws Exception {
		
		MemberDTO memberDTOtoFindPasswords = memberService.findPasswords(email);
		model.addAttribute("memberDTOtoFindPasswords", memberDTOtoFindPasswords);
		
		if( memberDTOtoFindPasswords != null) {
			
			UUID uid = UUID.randomUUID(); //임시비밀번호를 발급한다
			String tempPasswords = uid.toString().substring(0,6);
			
			memberDTOtoFindPasswords.setPasswords(tempPasswords); //암호화 시킨 비밀번호를 저장 
			memberService.makeTemporaryPasswords(memberDTOtoFindPasswords); //암호화 시킨 비밀번호를 DB까지 저장 
						
			sendTempPasswords(tempPasswords, email); //임시비밀번호를 이메일로 보낸다. 

		} else {}
		
		return memberDTOtoFindPasswords;  //result
	}

	
	//발신인은 관리자인 flowerbudlah_project@naver.com 또는 flowerbudlah@gmail.com
	//수신인 이메일은 email, 보낼내용은 임시비밀번호 tempPasswords 
	public void sendTempPasswords(String tempPasswords, String email){
		String recipient =email; 
		String code = tempPasswords;
	 
		// 1. 발신자의 메일 계정과 비밀번호 설정
		final String user = "flowerbudlah@gmail.com";
		final String password = "gepkhwdixvpnoldc";//구글 앱 비밀번호 
		
		// 2. Property에 SMTP 서버 정보 설정
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
	 
		// 3. SMTP 서버정보와 사용자 정보를 기반으로 Session 클래스의 인스턴스 생성
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password); 
			}
		});
		
		// 4. Message 클래스의 객체를 사용하여 수신자와 내용, 제목의 메시지를 작성한다. 
		MimeMessage message = new MimeMessage(session);
		
		try {
			message.setFrom(new InternetAddress(user));
	 
			// 수신자 메일 주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
			
			// Subject
			message.setSubject("고로고로(GoroGoroCommunity) 임시비밀번호입니다. ");
			
			// Text
			message.setText("임시비밀번호는 "+code+" 입니다.감사합니다. ");
			
			// 5. Transport 클래스를 사용하여 작성한 메세지를 전달한다. send message
			Transport.send(message);
			System.out.println("전송성공"); 
	 
		} catch (AddressException e) {
	            e.printStackTrace();
		} catch (MessagingException e) {
	            e.printStackTrace();
		}
	}
	
	
	
}