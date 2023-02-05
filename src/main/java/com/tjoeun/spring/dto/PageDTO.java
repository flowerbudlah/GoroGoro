package com.tjoeun.spring.dto;

import lombok.Data;

@Data
public class PageDTO {

	private int min; // 최소 페이지 번호
	private int max; // 최대 페이지 번호
	
	private int prePage; // 이전 버튼 누르면 이동하는 페이지 번호
	private int nextPage;   // 다음 버튼 누르면 이동하는 페이지 번호
	
	private int pageCount; 	// 전체 페이지 개수
	private int currentPage; // 현재 페이지 번호
	
	/*
	  전체 게시글의 개수, 페이지당 게시글의 개수, 현재 페이지 번호 --> 이 값들을 가지고 위의 값들을 계산함
	    
	  이 작업은 생성자에서 함
	  생성자의 매개변수로
	  int postCnt     : 전체 게시글의 개수
	  int currentPage    : 현재 페이지 번호
	  int postPageCnt : 페이지당 게시글의 개수
	  int paginationCnt  : 페이지 버튼의 개수
	  를 선언함   
	*/
	
	public PageDTO(int contentCnt, int currentPage, int contentPageCnt, int paginationCnt) {
		// contentCnt    : database 에서 가져옴 (BoardMapper)
		// currentPage   : page parameter로 전달함
		// contentPageCnt, paginationCnt : option.properties 에 설정함
		
		
		this.currentPage = currentPage; // 현재 페이지 번호
		
		pageCount = contentCnt / contentPageCnt; //전체 페이지 개수 = 전체 글개수 / 페이지당 글개수
		
		if(contentCnt % contentPageCnt > 0) {
			pageCount++; 
		}
	  
		min = ((currentPage - 1) / contentPageCnt) * contentPageCnt + 1;
		max = min + paginationCnt - 1;  //  최대페이지 번호 = 최소페이지 번호 + 페이지 버튼의 개수 - 1
    
		if(max > pageCount) {
			max = pageCount;
		}

		prePage = min - 1;
		nextPage = max + 1;
    
		//다음페이지버튼 번호가 전체페이지 개수를 넘어가지 않도록 함
		if(nextPage > pageCount) {
			nextPage = pageCount; 
		} 
    
    
	}
	
	
	
	

}