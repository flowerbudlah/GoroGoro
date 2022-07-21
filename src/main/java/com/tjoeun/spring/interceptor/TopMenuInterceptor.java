package com.tjoeun.spring.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.tjoeun.spring.dto.BoardDTO;
import com.tjoeun.spring.dto.CategoryDTO;
import com.tjoeun.spring.service.TopMenuService;

public class TopMenuInterceptor implements HandlerInterceptor{

	
	@Autowired
	private TopMenuService topMenuService;
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		List<CategoryDTO> CategoryList = topMenuService.getCategoryList();//위 메뉴부분의 대 분류 카테고리
		request.setAttribute("CategoryList", CategoryList);
	

		List<BoardDTO> BoardList = topMenuService.getBoardList(); //카테고리에 속해있는 게시판 부분 
		request.setAttribute("BoardList", BoardList);
	

		return true;
	}
	
	
	
	
	
	
	
}
