<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고로고로(ゴロゴロ)</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="css/slide.css" /><!-- 슬라이드 관련 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
<style>
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
.card-title{font-family: 'Single Day', cursive; }

body{
	 background-image: url(http://localhost:8090/GoroGoroCommunity/image/bottom-bg.jpg);
	 background-repeat: no-repeat; background-position: center bottom; background-attachment: fixed; 
	}
h4{ background-color: #222; color: white; text-align: center; padding: 10px; }
</style>
</head>
<body>
<!-- 슬라이드 -->
<div class="slide slide_wrap">
	<div class="slide_item item1"></div>
	<div class="slide_item item2"></div>
	<div class="slide_item item3"></div>
	<div class="slide_prev_button slide_button"></div>
	<div class="slide_next_button slide_button"></div>
	<ul class="slide_pagination"></ul>
</div>
<script src="${root }js/slide.js"></script>
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!--메인화면에 내용 들어가는 부분  -->
<div style="padding-top:50px; padding-bottom:100px">
<div class="container">
  <div>
    <h4>앞으로 해야할 것 </h4>
    <p class="text-center">
    	<strong>
    	1. 첨부파일을 업로드(이미지 파일 업로드하는 것은 함) <br>
    	2. 첨부파일 수정 <br>
    	</strong>
    </p>
  </div>
<br><br><br>
  <div>
    <h4>회원기능</h4>
    <p class="text-center">
    	1. 로그인<br>
    	2. 로그아웃 <br>
    	3. 회원가입, 회원정보수정, 회원탈퇴, 비밀번호 찾기<br>
    	4. 개인 프로필 기능(사진 업로드, 본인이 신고당한 건수)<br>
    	5. 게시글 신고(신고당한사람은 플래그가 증가한다. 더티지수증가)
    </p>
  </div>
<br><br><br>
  <div>
    <h4>관리자 기능</h4>
    <p class="text-center">
    	1. 게시글 삭제<br>
    	2. 지속적으로 악성댓글을 쓰는사람은 회원강퇴(더티지수가 100이상인경우)<br>
    	3. 신고된 게시글 처리<br>
    </p>
  </div>

    

</div>
</div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>