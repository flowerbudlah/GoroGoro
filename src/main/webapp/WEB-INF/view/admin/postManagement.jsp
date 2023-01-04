<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 관리</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
body{ background-color: white; }
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
<div style="margin-top:50px; padding-top:0px; padding-bottom:30px">
	<div class="container">
		<h4>관리자 전용 페이지(For the Administrator Only)</h4>
		<h5>관리자(Admin)에게 신고 접수된 게시물들을 보여줍니다.</h5>

	
	
	
	
	


	</div>
</div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>