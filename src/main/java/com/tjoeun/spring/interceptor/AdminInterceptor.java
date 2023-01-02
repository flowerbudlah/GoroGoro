package com.tjoeun.spring.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Lazy;
import org.springframework.web.servlet.HandlerInterceptor;

import com.tjoeun.spring.dto.MemberDTO;

//관리자만 관리자 페이지에 입장할 수 있는 인터셉터 (for administrator only)
public class AdminInterceptor implements HandlerInterceptor{

	@Resource(name="signInMemberDTO")
	private @Lazy MemberDTO signInMemberDTO;
	
	@Override
	public boolean preHandle
	(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		HttpSession session = request.getSession(); //로그인 한 것인 세션 가져오기
		
		MemberDTO signInMemberDTO = (MemberDTO) session.getAttribute("signInMemberDTO");
		
		if(signInMemberDTO.getMemberNo() == 1){//즉, 로그인한사람이 관리자인경우로 즉, 관리자가 들어온경우 
			return true;
		}
		
		String contextPath = request.getContextPath();
		response.sendRedirect(contextPath + "/etc/notAdmin");
		return false;
	      
	}
}