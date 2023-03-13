<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고로고로(ゴロゴロ)</title>
<link rel="icon" type="image/x-icon" href="/GoroGoroCommunity/image/favicon.png">
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
<script type="text/javascript">    

</script>
<style>
.slider img{display:block; width:100%; max-width:100%; height:300px; } /* 슬라이더 영역 CSS */
body{
	background-image: url(http://localhost:8090/GoroGoroCommunity/image/bottom-bg.jpg); 
	background-repeat: no-repeat; background-position: center bottom; background-attachment: fixed; }
thead{background-color:gold; }
h1{ font-family: 'Single Day', cursive; }
</style>
</head>
<body>
<!-- 상단 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!-- 그 게시판 윗 부분 그림-->
<article class="slider">
	<img src="/GoroGoroCommunity/image/candy.png">
</article>
<!--Post List(게시글 리스트)-->
<div class="container" style="margin-top:50px; margin-bottom:100px;">
	<!-- <div class="card shadow-none">-->
	<div class="card-body">	
		<h1 class="card-title">${boardName }</h1>
		<c:choose>
			<c:when test="${searchCount == null}"></c:when>
			<c:otherwise>총 ${searchCount}개의 글이 검색되었습니다. </c:otherwise>
		</c:choose>
		<table class="table table-hover">
			<thead>
				<tr>
					<th class="text-center d-none d-md-table-cell">글번호</th>
					<th class="w-50">제목</th>
					<th class="text-center d-none d-md-table-cell">작성자</th>
					<th class="text-center d-none d-md-table-cell">작성날짜</th>
					<th class="text-center d-none d-md-table-cell">조회수</th>
					<th class="text-center d-none d-md-table-cell">공감수</th>
				</tr>
			</thead>
			<tbody id="boardtable">
			<!-- 해당 게싶판에 게시글 리스트 -->
			<c:forEach var="postDTO" items="${postList }" >
				<tr>
					<td class="text-center d-none d-md-table-cell">${postDTO.postNo }</td>
					<td>
						<%--제목 부분--%>
						<a href='read?postNo=${postDTO.postNo}' style="color:black">
							<c:choose>
								<c:when test="${boardNo == 1 }">[${boardName }]</c:when>
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
					<td class="text-center d-none d-md-table-cell">
						<c:choose>
							<c:when test="${postDTO.boardNo == 2 }">익명</c:when>
							<c:otherwise>
								${postDTO.writer}
							</c:otherwise>
						</c:choose>
					</td>
					<td class="text-center d-none d-md-table-cell">
						<fmt:formatDate value="${postDTO.regDate }" pattern="yyyy-MM-dd"/>
					</td>
					<td class="text-center d-none d-md-table-cell">${postDTO.viewCount }</td>
					<td class="text-center d-none d-md-table-cell">${postDTO.sameThinking }</td>
				</tr>
			</c:forEach>
			<!-- 검색결과 게시글-->
			<c:forEach var="postDTO" items="${searchList }" >
				<tr>
					<td class="text-center d-none d-md-table-cell">${postDTO.postNo }</td>
					<td>
						<%--제목 부분--%>
						<a href='read?postNo=${postDTO.postNo}' style="color:black">
							<c:choose>
								<c:when test="${boardNo == 1 }">[${boardName }]</c:when>
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
					<td class="text-center d-none d-md-table-cell">
						<c:choose>
							<c:when test="${postDTO.boardNo == 2 }">익명</c:when>
							<c:otherwise>${postDTO.writer}</c:otherwise>
						</c:choose>
					</td>
					<td class="text-center d-none d-md-table-cell">
						<fmt:formatDate value="${postDTO.regDate }" pattern="yyyy-MM-dd"/>
					</td>
					<td class="text-center d-none d-md-table-cell">${postDTO.viewCount }</td>
					<td class="text-center d-none d-md-table-cell">${postDTO.sameThinking }</td>
				</tr>
			</c:forEach>
			<!-- 검색 끝 -->
			</tbody>
		</table>
		<!-- 글쓰기버튼 -->
		<c:choose>
			<c:when test="${signInMemberDTO.signIn == true }">
			<!-- 글쓰기버튼은 로그인을 한 사람만 보인다. -->
				<c:choose>
					<c:when test="${boardNo == 1 }">
					<%--관리자게시판 인경우 --%>
						<c:choose>
							<c:when test="${signInMemberDTO.memberNo == 1}">
							<%--관리자게시판 인경우, 관리자만 글쓰기 버튼을 보고 --%>
								<div class="text-right">
									<a href="write?boardNo=${boardNo }" class="btn btn-warning">글쓰기</a>
								</div>
							</c:when>
							<c:otherwise></c:otherwise>
							<%--관리자게시판 인경우, 관리자가 아니라면 글쓰기버튼은 안보인다.  --%>
						</c:choose>
					</c:when>
					<c:otherwise>
					<%--관리자게시판이 아닌 경우, 글쓰기 버튼은 로그인을 한 사람이라면 다 보인다.  --%>
						<div class="text-right">
							<a href="write?boardNo=${boardNo }" class="btn btn-warning">글쓰기</a>
						</div>
					</c:otherwise>
				</c:choose>
			</c:when>	
			<c:otherwise></c:otherwise>
		</c:choose>
		<!-- [이전]1 2 3 4 5 6 7 8 9 10 [다음] 페이지 시작 -->
		<c:choose>
			<c:when test="${searchListPageDTO.prePage >= 0 }">
			<!-- 검색을 한 경우의 페이지 -->
			<div class="d-none d-md-block">
				<ul class="pagination justify-content-center" id="page">
				<!-- 이전 -->
				<c:choose>
					<c:when test="${searchListPageDTO.prePage <= 0 }" >
						<li class="page-item disabled"><a href="#" class="page-link">이전</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="searchResult?boardNo=${boardNo}&type=${type }&keyword=${keyword }&page=${pageDTO.prePage}" class="page-link">이전</a>
						</li>
					</c:otherwise>
				</c:choose>
				<!-- 1 2 3 4 5 6 7 8 9 10 -->
				<c:forEach var="idx" begin="${searchListPageDTO.min }" end="${searchListPageDTO.max }">
				<c:choose>
					<c:when test="${idx == searchListPageDTO.currentPage }">
						<li class="page-item active">
							<a href="searchResult?boardNo=${boardNo}&type=${type }&keyword=${keyword }&page=${idx}" class="page-link">${idx}</a>
							<!-- http://localhost:8090/GoroGoroCommunity/board/      main?boardNo=2&page=1 -->
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="searchResult?boardNo=${boardNo}&type=${type }&keyword=${keyword }&page=${idx}" class="page-link">${idx}</a>
						</li>
					</c:otherwise>
				</c:choose>
				</c:forEach>  
				<!-- 다음 -->
				<c:choose>
					<c:when test="${searchListPageDTO.max >= searchListPageDTO.pageCount }">
					<!--맨 마지막 페이지인 경우에는 다음 버튼이 안 보이도록 함 (최대페이지가 전체페이지개수보다 크면 다음이 안 보이도록 함) -->
						<li class="page-item disabled">
							<a href="#" class="page-link">다음</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="searchResult?boardNo=${boardNo }&type=${type }&keyword=${keyword }&page=${searchPageDTO.prePage}" class='page-link'>다음</a>
						</li>
					</c:otherwise>
				</c:choose>
				</ul>
			</div>
			</c:when>
			<c:otherwise>
			<!-- 메인 게시판의 그 일반적인 그 페이징(Paging) -->			
			<div class="d-none d-md-block">
				<ul class="pagination justify-content-center" id="page">
				<!-- 이전 -->
				<c:choose>
					<c:when test="${pageDTO.prePage <= 0 }" >
						<li class="page-item disabled">
							<a href="#" class="page-link">이전</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="main?boardNo=${boardNo}&page=${pageDTO.prePage}" class="page-link">이전</a>
						</li>
					</c:otherwise>
				</c:choose>
				<!-- 1 2 3 4 5 6 7 8 9 10 -->
				<c:forEach var="idx" begin="${pageDTO.min }" end="${pageDTO.max }">
				<c:choose>
					<c:when test="${idx == pageDTO.currentPage }">
						<li class="page-item active">
							<a href="main?boardNo=${boardNo}&page=${idx}" class="page-link">${idx}</a>
								<!-- http://localhost:8090/GoroGoroCommunity/board/      main?boardNo=2&page=1 -->
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="main?boardNo=${boardNo}&page=${idx}" class="page-link">${idx}</a>
						</li>
					</c:otherwise>
				</c:choose>
				</c:forEach>  
				<!-- 다음 -->
				<c:choose>
					<c:when test="${pageDTO.max >= pageDTO.pageCount }">
					<!--맨 마지막 페이지인 경우에는 다음 버튼이 안 보이도록 함 (최대페이지가 전체페이지개수보다 크면 다음이 안 보이도록 함) -->
						<li class="page-item disabled">
							<a href="#" class="page-link">다음</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="main?boardNo=${boardNo}&type=${type }&keyword=${keyword }&page=${pageDTO.nextPage}" class="page-link">다음</a>
						</li>
					</c:otherwise>
				</c:choose>
				</ul>
			</div>
			</c:otherwise>
		</c:choose>
		<!-- 페이징 끝 -->
		<!-- <div class="card-body">	 -->	
		</div>
		<!-- 검색 기능 -->		
		<!-- http://localhost:8090/GoroGoroCommunity/GoroGoroCommunity/searchResult?type=titleANDcontent&keyword=test&boardNo=2 -->	
		<form action="searchResult" name="search-form" autocomplete="off" class="text-center" style="margin-top:30px;">
			<select id="type" name="type">
				<option value="titleANDcontent">제목+내용</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<c:choose>
					<c:when test="${boardNo == 2 }">
					<%--익명 게시판인 경우, 작성자가 안나온다.  --%>
					</c:when>
					<c:otherwise>
						<option value="writer">작성자</option>		
					</c:otherwise>
				</c:choose>
			</select>			
			<input type="text" value="" name="keyword" id="keyword" required="required"/>
			<input type="hidden" id="boardNo" name="boardNo" value="${boardNo }"/>
			<button onclick="searchResult" class="btn btn-warning btn-sm">검색</button>
		</form>
		<!-- 검색기능끝 -->
</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>