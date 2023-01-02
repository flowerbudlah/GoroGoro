<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="root" value="${pageContext.request.contextPath }/" />

<style>
.main{ text-align: center; margin: 0;  padding: 0; font-size:14px; }
.main li {display: inline-block; font-weight: bolder; list-style: none; }
.main ul{opacity: 0; transition: opacity 0.5s; pointer-events: none; position: absolute; padding-left: 0px; }
.main:after{ content: ''; display: block; clear: both; }
.main > li {font-color:white;  margin-right: 20px;  margin-left: 20px;  margin-top: 10px; margin-bottom: 10px; line-height: 30px; }
.main > li ul li{ float: left; list-style: none; font-weight: bolder; font-size: 14px;  position: relative; margin:0 auto; }
.main > li:hover ul{ opacity: 1; pointer-events: auto; }
.ml-auto{ font-size:14px;}
</style>
<script type="text/javascript">
function signOut(){ //사인아웃
	
	$.ajax({   
		url      : "${root}member/signOut", 
		type     : "POST",    
		success  : function(){
			alert("로그아웃 되었습니다. ");
			location.reload();
		},           
		error    : function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
		}
	}) //아작스		
} 	
</script>
<nav class="navbar navbar-expand-md bg-light navbar-dark fixed-top shadow-lg">
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navMenu">
		<span class="navbar-toggler-icon"></span>
	</button>
	
	<!-- 배너 들어갈 자리 -->
	<a class="navbar-brand" href="${root }main">
		<img src="${root}image/banner/pinkPeko.gif" height="50px">
		<img src="${root}image/banner/banner.png" height="50px"><!-- 고로고로 배너 -->	
	</a>
	
	<!-- "게시판 메뉴"와 마이페이지과 관리자전용페이지, 로그인, 회원가입 등장 -->
	<div class="collapse navbar-collapse" id="navMenu">
	<!-- 게시판 메뉴 -->
		<ul class="navbar-nav main"> 
		<c:forEach var="CategoryListDTO" items="${CategoryList}">
			<li class="nav-item">${CategoryListDTO.boardCategoryName } <!-- 카테고리 나오는 부분 -->
				<ul>
				<c:forEach var="BoardListDTO" items="${BoardList }"> 
					<c:choose>
						<c:when test="${CategoryListDTO.boardCategoryNo == BoardListDTO.boardCategoryNo }">		
        					<li><!-- 진짜 메뉴 나오는 부분! -->
        						<a href="${root }board/main?boardNo=${BoardListDTO.boardNo}" style="color:black;'">
        							${BoardListDTO.boardName }
        						</a>
        					</li><br>
        				</c:when>
        				<c:otherwise></c:otherwise>    
        			</c:choose>
        		</c:forEach>  
        		</ul>
			</li> 
		</c:forEach>
		</ul>
	    <!-- 게시판 메뉴의 끝 -->

		<ul class="navbar-nav main">
			<li>마이 페이지
				<ul> 
					<li><a href="" style="color:black;">내 프로필 보기</a></li><br>
					<li><a href="" style="color:black;">회원정보수정</a></li><br>
					<li><a href="" style="color:black;">나의 게시물</a></li>
				</ul>
			</li>
			<li>관리자 페이지
				<ul> 
				<c:choose>
      				<c:when test="${signInMemberDTO.signIn == true }"> <!-- 로그인을 해야지 보이는 관리자 페이지 -->
						<li><a href="${root }admin/memberManagement" style="color:black;">회원 관리</a></li><br>
						<li><a href="${root }admin/postManagement" style="color:black;">게시물 관리</a></li><br>
						<li><a href="${root }admin/boardManagement" style="color:black;">게시판 관리</a></li>
					</c:when>
				<c:otherwise></c:otherwise>     
				</c:choose>
				</ul>
			</li>	
		</ul>
		<!-- 로그인 회원가입 부분(회원정보수정, 로그아웃, 호원탈퇴)-->
		<ul class="navbar-nav ml-auto">
		<c:choose>
			<c:when test="${signInMemberDTO.signIn == true }"><!--로그인 된상태 -->
				<strong>${signInMemberDTO.nick }</strong>님께서 로그인을 하셨습니다.&emsp;
				<li><a href="${root }member/modify" style="color:black;">회원정보수정</a></li>&emsp;
				<li><a href="javascript:signOut();" attr-a="onclick : attr-a" style="color:black;">로그아웃</a></li>
			</c:when>
			<c:otherwise><!-- 로그인 안된상태 -->
			
				<li class="nav-item"><a href="${root }member/signIn" style="color:black;">로그인</a></li>&emsp;
				<li class="nav-item"><a href="${root }member/signUp" style="color:black;">회원가입</a></li>
			</c:otherwise>   
		</c:choose>
		</ul>
			<a class="navbar-brand">
				<img src="${root}image/banner/smilingPekko.png" height="50px"> <!-- 뒤에 페코사진 들어갈 자리 -->
			</a>
	</div><!-- 게시판 메뉴와 회원부분 끝 -->
</nav>