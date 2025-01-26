<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고로고로(ゴロゴロ)</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<link rel="stylesheet" href="css/slide.css" />
<!-- 슬라이드 관련 -->
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
<style>
/* 슬라이더 영역 CSS */
.slider img {
	display: block;
	width: 100%;
	max-width: 100%;
	height: 300px;
}

.card-title {
	font-family: 'Single Day', cursive;
}

body {
	background-image:
		url(http://localhost:8090/GoroGoroCommunity/image/bottom-bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
	background-attachment: fixed;
}

h3 {
	background-color: #222;
	color: white;
	text-align: center;
	padding: 10px;
	font-family: 'Single Day', cursive;
}

thead {
	background-color: gold;
}
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
	<c:import url="/WEB-INF/view/include/topMenu.jsp" />
	<!--메인화면에 내용 들어가는 부분  -->
	<!-- 공지사항 미리보기 부분 -->
	<div class="container" style="margin-top: 50px; margin-bottom: 100px">
		<div class="row">
			<div class="col-lg-12">
				<div class="card-body">
					<div>
						<h3>추가 예정 기능</h3>
						<p class="text-center" style="margin-bottom: 100px">
							1. 관리자 로그인후, 관리자 페이지에서 게시판관리 부분 수정필요(중복처리)<br>
							2. 지속적으로 악성댓글을 쓰는사람은 일정기간 로그인이 불가능하게 하는 조치 (유효한 신고건수flag가 5이상인경우)<br>
							3. 실제 주소를 갖게되는 웹 호스팅 -> 이 기능만 해도 포트폴리오는 완성이라고 볼수있다. <br>
							4. 사진파일을 하나가 아닌 여러건을 올릴수있게<br>
							5. 사진 파일뿐아니라 pdf, 음악파일등을 업로드 할 수 있는 기능
						</p>
					</div>
					<h3>공지사항</h3>
					<table class="table table-hover">
						
						<thead>
							<tr>
								<th class="text-center d-none d-md-table-cell" style="color: black">글번호</th>
								<th class="w-50" style="color: black">제목</th>
								<th class="text-center d-none d-md-table-cell" style="color: black">작성자</th>
								<th class="text-center d-none d-md-table-cell" style="color: black">작성날짜</th>
								<th class="text-center d-none d-md-table-cell" style="color: black">조회수</th>
								<th class="text-center d-none d-md-table-cell" style="color: black">공감수</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="postDTO" items="${postList }">
								<tr>
									<td class="text-center">${postDTO.postNo }</td>
									<td>
										<!-- http://localhost:8090/GoroGoroCommunity/board/read?postNo=7 -->
										<a href='${root }board/read?&postNo=${postDTO.postNo}' style="color: black"> <c:choose>
												<c:when test="${postDTO.boardNo == 1 }">[공지사항]</c:when>
												<c:otherwise></c:otherwise>
											</c:choose> ${postDTO.title } 
											<!-- 업로드 파일이 있다면 --> 
											<c:if test="${postDTO.imageFileName != '' }">
												<img src="/GoroGoroCommunity/image/uploadingPhoto.png" width=20px;>
											</c:if> 
											<!-- 댓글이 있을경우, 댓글 수--> 
											<font color="red">[${postDTO.replyCount }]</font>
									</a>
									</td>
									<td class="text-center">${postDTO.writer }</td>
									<td class="text-center"><fmt:formatDate
											value="${postDTO.regDate }" pattern="yyyy-MM-dd" /></td>
									<td class="text-center">${postDTO.viewCount }</td>
									<td class="text-center">${postDTO.sameThinking }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<div class="text-right">
						<a href="${root }board/main?boardNo=1" class="btn btn-danger" style="color: white">More...</a>
					</div>
				</div>
				<!-- 카드바디 -->
			</div>
		</div>
	</div>
	<!-- 게시판 미리보기 부분 끝-->
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>