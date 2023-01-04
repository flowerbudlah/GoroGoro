package com.tjoeun.spring.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.servlet.HandlerInterceptor;

import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.service.BoardService;

//글쓴이만 자기가 쓴글의 삭제와 수정이 가능하다. 
public class CheckWriterInterceptor implements HandlerInterceptor {
	
	@Resource(name="signInMemberDTO")
	private @Lazy MemberDTO signInMemberDTO;
	
	@Autowired
	private BoardService boardService;
	
	//로그인한 사람과 작성한 사람이 같은지 검사하기--이번 Interceptor는 수정할 때와 삭제할 때만 반응하도록 함
	@Override
	public boolean preHandle
	(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
  
		System.out.println("======================================================================="); 
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		PostDTO tmpPostDTO = boardService.read(postNo); 
		
		if( tmpPostDTO.getWriter().equalsIgnoreCase(signInMemberDTO.getNick()) ){
			//글쓴사람이랑 로그인을 한 사람이 같으면, 
			
			return true;
		}else {
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath + "/board/notWriter");
  			return false;
		}
			
	}
}