<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고로고로(ゴロゴロ)</title>
<link rel="icon" type="image/x-icon" href="/GoroGoroCommunity/image/favicon.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">    

</script>
<style>
.slider img{display:block; width:100%; max-width:100%; height:300px;} /* 슬라이더 영역 CSS */
thead{background-color: gold; }
</style>
</head>
<body>
<!-- 상단 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!-- 그 게시판 윗 부분 그림-->
<article class="slider">
	<img src="/GoroGoroCommunity/image/convenientStore.png">
</article>
<!--Post List(게시글 리스트)-->
<div class="container" style="margin-top:50px; margin-bottom:50px;">
	<div class="card shadow-none">
		<div class="card-body">	
			<h4 class="card-title">내가 신고한 내역</h4>
			<p>${signInMemberDTO.nick }님께서 관리자에게 신고 접수한 게시물들을 보여줍니다.</p><br>
			<table class="table table-hover">
				<thead>
					<tr>
						<th class="text-center d-none d-md-table-cell">신고번호</th>
						<th class="w-50">신고사유</th>
						<th class="text-center d-none d-md-table-cell">신고자</th>
						<th class="text-center d-none d-md-table-cell">신고일짜</th>
					</tr>
				</thead>
				<tbody id="boardtable">
				<c:forEach var="reportDTO" items="${myReportList }" >
					<tr>
						<td class="text-center d-none d-md-table-cell">${reportDTO.reportNo }</td>
						<td>
							<a href="http://localhost:8090/GoroGoroCommunity/myPage/reportedPost?reportNo=${reportDTO.reportNo }" style="color:black">
								${reportDTO.reason}	(게시글 번호: ${reportDTO.postNo })
								<br>
								<c:choose>
									<c:when test="${reportDTO.replyCount == 0 }">
									</c:when>
									<c:otherwise>
										<font color="red">관리자의 답글이 도착했습니다.</font>
									</c:otherwise>
								</c:choose>
							
							</a>
						</td>
						<td class="text-center d-none d-md-table-cell">${reportDTO.reporter }</td>
						<td class="text-center d-none d-md-table-cell">
							<fmt:formatDate value="${reportDTO.reportDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
			<!-- 페이징(Paging) -->			
			<div class="d-none d-md-block">
				<ul class="pagination justify-content-center">
				<!-- 이전 -->
				<c:choose>
					<c:when test="${pageDTO.prePage <= 0 }" >
						<li class="page-item disabled">
							<a href="#" class="page-link">이전</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="${root }admin/postManagement?page=${pageDTO.prePage}" class="page-link">
								이전
							</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<!-- 1 2 3 4 5 6 7 8 9 10 -->
				<c:forEach var="idx" begin="${pageDTO.min }" end="${pageDTO.max }">
				<c:choose>
					<c:when test="${idx == pageDTO.currentPage }">
						<li class="page-item active">
							<a href="${root }admin/postManagement?page=${idx}" class="page-link">
								${idx}
							</a>
							<!-- http://localhost:8090/GoroGoroCommunity/board/      main?boardNo=1&page=1 -->
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="${root }admin/postManagement?page=${idx}" class="page-link">${idx}</a>
						</li>
					</c:otherwise>
				</c:choose>
				</c:forEach>  
				<!-- 다음 -->
				<!--맨 마지막 페이지인 경우에는 다음 버튼이 안 보이도록 함 (최대페이지가 전체페이지개수보다 크면 다음이 안 보이도록 함) -->
				<c:choose>
					<c:when test="${pageDTO.max >= pageDTO.pageCount }">
						<li class="page-item disabled">
							<a href="#" class="page-link">다음</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="${root }admin/postManagement?page=${pageDTO.nextPage}" class="page-link">다음</a>
						</li>
					</c:otherwise>
				</c:choose>
				</ul>
			</div>
			<!-- 검색 기능 -->			
			<form action="javascript:searchList()" name="search-form" autocomplete="off" class="text-center" style="margin-top:30px; margin-bottom:30px;">
				
				<select name="type">
					<option value="reason">신고사유</option>
					<option value="reporter">신고자</option>
				</select>			
				<input type="text" value="" name="keyword" id="keyword"/> <!-- required="required"  -->
				<input type="button" onclick="javascript:searchList()" class="btn btn-warning btn-sm" value="검색"/>
			</form> 
			<!-- 검색기능끝 -->	
		</div>
	</div>
</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>