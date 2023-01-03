<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 전용 페이지(For the Administrator Only)</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
</style>
</head>
<body>
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!--가운데 그림-->
<article class="slider">
	<img src="${root }image/yamamotoshinji_sapporo_clockTower.jpg">
</article>
<!--메인화면에 내용 들어가는 부분  -->
<div style="padding-top:50px; padding-bottom:100px; ">
	<div class="container">
		<h4>관리자 전용 페이지(For the Administrator Only)</h4><br><br>
		<form action="${root }admin/boardManagement/boardCategoryName" style="padding-bottom:10px;">
			<h5><strong>1. 대분류 카테고리</strong></h5>
			1) 카테고리 생성 <br> 
			(1) 생성할 카테고리 이름:  
			<input type="text" id="boardCategoryName" value="" name="boardCategoryName" style="width:300px;">
			<button type="submit" class="btn btn-warning btn-sm" style="text-align:right;">카테고리 생성하기</button>
		</form>
		<form action="${root }admin/boardManagement/deleteCategory" style="padding-bottom:10px;">
			2) 카테고리 삭제<br>
			(1) 삭제할 카테고리 선택: 
			<select name="boardCategoryNo" style="width:300px;">
				<c:forEach var="CategoryListDTO" items="${CategoryList }">	
					<option value="${CategoryListDTO.boardCategoryNo }">${CategoryListDTO.boardCategoryName }</option>
				</c:forEach>	
			</select>
			<button type="submit" class="btn btn-warning btn-sm" style="text-align:right;">해당카테고리 삭제하기</button><br> 
			<font color="red">(카테코리를 삭제할 시 해당 카테고리에 속한 게시판과 게시물도 모두 삭제되니 이점 유념하시길 바랍니다.)</font>
		</form>
		<br><br>
		<form action="${root }admin/boardManagement/boardName" style="padding-bottom:10px;">
			<h5><strong>2. 게시판</strong></h5> 
			1) 게시판 생성<br>
			(1) 대분류 카테고리 선택: 
	 		<select name="boardCategoryNo" style="width:300px;">
				<c:forEach var="CategoryListDTO" items="${CategoryList }">	
					<option value="${CategoryListDTO.boardCategoryNo }">${CategoryListDTO.boardCategoryName }</option>
				</c:forEach>	
			</select><br>
			(2) 새로운 게시판 이름 설정:
			<input type="hidden" id="boardCategoryNo" value="boardCategoryNo" name="boardCategoryNo"/>
			<input type="text" id="boardName" value="" name="boardName" style="width:300px;">
			<button type="submit" class="btn btn-warning btn-sm" style="text-align:right;">새로운 게시판 생성하기</button>	
		</form>
		<form action="${root }admin/boardManagement/changeBoardName" style="padding-bottom:10px;">
			2) 게시판 이름 변경<br>
			(1) 변경대상 게시판: 
			<select name="boardNo" style="width:300px;">
				<c:forEach var="BoardListDTO" items="${BoardList }">	
					<option value="${BoardListDTO.boardNo }">
					${BoardListDTO.boardNo }- ${BoardListDTO.boardName }</option>
				</c:forEach>	
			</select><br>
			2) 변경할 게시판 이름:
			<input type="hidden" id="boardNo" value="boardNo" name="boardNo"/>
			<input type="text" id="boardName" value="" name="boardName" style="width:300px;">
			<button type="submit" class="btn btn-warning btn-sm" style="text-align:right;">게시판 이름 변경하기</button>			
		</form>

		<form action="${root }admin/boardManagement/deleteBoard" style="padding-bottom:10px;">
			3) 게시판 제거<br>
			(1) 삭제할 게시판 선택: 
			<select name="boardNo" style="width:300px;">
				<c:forEach var="BoardListDTO" items="${BoardList }">	
					<option value="${BoardListDTO.boardNo }">${BoardListDTO.boardNo }- ${BoardListDTO.boardName }</option>
				</c:forEach>	
			</select>
			<button type="submit" class="btn btn-warning btn-sm" style="text-align:right;">해당 게시판 삭제하기</button><br> 
			<font color="red">(해당 게시판을 삭제할 시 해당 게시판에 속한 게시물도 모두 삭제되니 이점 유념하시길 바랍니다.)</font>
		</form>
		
		<form action="  " style="padding-bottom:10px;">
			4) 게시판의 카테고리 변경<br>
			(1) 변경할 게시판 선택: 
			<select name="boardNo" style="width:300px;">
				<c:forEach var="BoardListDTO" items="${BoardList }">	
					<option value="${BoardListDTO.boardNo }">${BoardListDTO.boardNo }- ${BoardListDTO.boardName }</option>
				</c:forEach>	
			</select><br>
			(2) 변경하고자 할 카테고리 선택
			<select name="boardCategoryNo" style="width:300px;">
				<c:forEach var="CategoryListDTO" items="${CategoryList }">	
					<option value="${CategoryListDTO.boardCategoryNo }">${CategoryListDTO.boardCategoryName }</option>
				</c:forEach>	
			</select>
			<button type="submit" class="btn btn-warning btn-sm" style="text-align:right;">해당 게시판의 카테고리 변경하기</button><br> 
		
		</form>
	</div>
</div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>