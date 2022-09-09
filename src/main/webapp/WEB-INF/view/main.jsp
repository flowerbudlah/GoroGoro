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

body{ background-image: url(http://localhost:8090/GoroGoroCommunity/image/bottom-bg.jpg);
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
    <h4>HTML5</h4>
    <p>Non minim qui consequat dolor minim amet consequat est est excepteur anim ex proident. Esse tempor nulla dolore occaecat est fugiat qui dolor mollit aliqua. Lorem dolor amet veniam quis duis labore aute fugiat eiusmod cillum exercitation nulla. Pariatur enim mollit do deserunt incididunt non duis. Irure id fugiat duis veniam enim enim ullamco velit enim duis qui eu occaecat. Enim adipisicing irure id irure excepteur in laborum tempor. Quis ut esse quis proident.</p>
  </div>
<br><br><br>
  <div>
    <h4>CSS3</h4>
    <p>Non minim qui consequat dolor minim amet consequat est est excepteur anim ex proident. Esse tempor nulla dolore occaecat est fugiat qui dolor mollit aliqua. Lorem dolor amet veniam quis duis labore aute fugiat eiusmod cillum exercitation nulla. Pariatur enim mollit do deserunt incididunt non duis. Irure id fugiat duis veniam enim enim ullamco velit enim duis qui eu occaecat. Enim adipisicing irure id irure excepteur in laborum tempor. Quis ut esse quis proident.</p>
  </div>
<br><br><br>
  <div>
    <h4>Javascript</h4>
    <p>Non minim qui consequat dolor minim amet consequat est est excepteur anim ex proident. Esse tempor nulla dolore occaecat est fugiat qui dolor mollit aliqua. Lorem dolor amet veniam quis duis labore aute fugiat eiusmod cillum exercitation nulla. Pariatur enim mollit do deserunt incididunt non duis. Irure id fugiat duis veniam enim enim ullamco velit enim duis qui eu occaecat. Enim adipisicing irure id irure excepteur in laborum tempor. Quis ut esse quis proident.</p>
  </div>

    

</div>
</div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>