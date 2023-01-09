<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고로고로(ゴロゴロ)</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<link rel="stylesheet" href="css/slide.css" /><!-- 슬라이드 관련 -->
<!-- Bootstrap CDN -->
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
    	<h4>관리자 기능(관리자만 들어갈수있는 관리자페이지 만들기)</h4>
		<p class="text-center">
    	1. 게시글 삭제, 신고된 게시글 처리(관리자 페이지 만들기)<br><br>
    	2. 지속적으로 악성댓글을 쓰는사람은 회원강퇴(유효한 신고건수가 50이상인경우)
    	4. 개인 프로필 기능(프로필누르면 새로운 팝업창이 뜨고 사진 업로드, 본인이 신고당한 건수)<br>
    	5. 게시글 신고(신고당한사람은 플래그가 증가한다. 더티지수증가)
    	</p>
	</div>
	<br><br>
<!-- 공지사항 미리보기 부분 -->
<div class="container" style="margin-top:0px; margin-bottom:0px">
	<div class="row">
		<div class="col-lg-12" style="margin-top:20px; ">
			<div class="card-body">
				<h4>공지사항</h4>
					<table class="table table-hover">
					<thead>
						<tr>
							<th class="text-center d-none d-md-table-cell" style="color:black">글번호</th>
							<th class="w-50" style="color:black">제목</th>
							<th class="text-center d-none d-md-table-cell" style="color:black">작성자</th>
							<th class="text-center d-none d-md-table-cell" style="color:black">작성날짜</th>
							<th class="text-center d-none d-md-table-cell" style="color:black">조회수</th>
							<th class="text-center d-none d-md-table-cell" style="color:black">공감수</th>
						</tr>
					</thead>
					
					<tbody>
					<c:forEach var="postDTO" items="${postList }">
					<tr>
						<td class="text-center">${postDTO.postNo }</td>
						<td>
							<!-- http://localhost:8090/GoroGoroCommunity/board/read?postNo=7 -->
							<a href='${root }board/read?&postNo=${postDTO.postNo}' style="color:black">
								${postDTO.title }
								<!-- 업로드 파일이 있다면 -->
								<c:if test="${postDTO.imageFileName != '' }">
									<img src="/GoroGoroCommunity/image/uploadingPhoto.png" width=20px;>
								</c:if>
								<!-- 댓글이 있을경우, 댓글 수-->
						 		<font color="red">[${postDTO.replyCount }]</font>
							</a>
						</td>
						<td class="text-center">${postDTO.writer }</td> 
						<td class="text-center">
							<fmt:formatDate value="${postDTO.regDate }" pattern="yyyy-MM-dd"/>
						</td>
						<td class="text-center">${postDTO.viewCount }</td>
						<td class="text-center">${postDTO.sameThinking }</td>
					</tr>
					</c:forEach>
					</tbody>
					</table>
					
					<div class="text-right">
						<a href="${root }board/main?boardNo=1" class="btn btn-danger" style="color:white">
							더 보기
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 게시판 미리보기 부분 끝-->
</div>
</div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>