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
h3{ background-color: #222; color: white; text-align: center; padding: 10px; font-family: 'Single Day', cursive; }
thead{background-color:gold;}
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
<!-- 공지사항 미리보기 부분 -->
<div class="container" style="margin-top:50px; margin-bottom:100px">
	<div class="row">
		<div class="col-lg-12">
			<div class="card-body">
				<div>
    			<h3>추가 예정 기능</h3>
				<p class="text-center" style="margin-bottom:100px">>
    			2. 지속적으로 악성댓글을 쓰는사람은 회원강퇴(유효한 신고건수가 50이상인경우)<br>
    			4. 개인 프로필 기능(프로필누르면 새로운 팝업창이 뜨고 사진 업로드, 본인이 신고당한 건수)<br>
    			6. 게시판에서 아작스로 검색시 페이지가 그 겸색결과에 맞게 조정되는것. ㅠㅠ<br> 
    			</p>
				</div>
				<h3>공지사항</h3>
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
								<c:choose>
									<c:when test="${postDTO.boardNo == 1 }">[공지사항]</c:when>
									<c:otherwise></c:otherwise>
								</c:choose>
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
							more
						</a>
					</div>
				</div><!-- 카드바디 -->
			</div>
		</div>
	</div>
<!-- 게시판 미리보기 부분 끝-->

<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>