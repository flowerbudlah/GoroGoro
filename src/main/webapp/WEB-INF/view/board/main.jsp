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
function searchList(){
	
	const boardNo = $("#boardNo").val(); //내용
	const keyword = $("#keyword").val(); //내용
	const type = $("#type").val();
	
	if (keyword == ""){			
		alert("검색어를 입력해주세요.");
		$("#keyword").focus();
		return;
	}
			
	$.ajax({
		type: 'get',
		url : 'searchList',
		data : $("form[name=search-form]").serialize(), 
		success : 	
			function(result){
	
				const searchPageDTO = result['searchPageDTO'];
				const searchList = result['searchList'];
				const searchCount = result['searchCount']; 
	
				const type = result['type'];
				const keyword = result['keyword'];
				const boardNo = result['boardNo']; 
				
				<!-- http://localhost:8090/GoroGoroCommunity/board/ -->
				
				$("#resultLength").html("총"+searchCount+"개의 글이 검색되었습니다.");
				$('#boardtable').empty(); 	//테이블 초기화
				
				if(searchList.length>=1){//검색결과가 하나라도 있다.  
					
					searchList.forEach(function(item){
					
						str="<tr>"
							str+="<td><center>"+item.postNo+"</center></td>"; //글번호
							str+="<td><a href='read?postNo=" +item.postNo+ "'>" + item.title + "<font color='red'>["+ item.replyCount+"]</font></a></td>"; //제목
							str+="<td><center>"+item.writer+"</center></td>"; //작성자
							str+="<td><center>"+item.reg_date+"</center></td>"; //작성날짜
							str+="<td><center>"+item.viewCount+"</center></td>"; //조회수
							str+="<td><center>"+item.sameThinking+"</center></td>"; //공감수
						str+="</tr>"
					
						$('#boardtable').append(str);
			  
					})//forEach의 끝
        	
					$('#page').empty(); 
					
					<!-- 이전 -->
					if(searchPageDTO.prePage <= 0){
str="<li class='page-item disabled'><a href='#' class='page-link'>이전</a></li>"; 
					}else{
str+="<li class='page-item'><a href='searchResult?boardNo="+boardNo+"&type="+type+"&keyword="+keyword+"&page="+searchPageDTO.prePage+"'class='page-link'>이전</a></li>";	
					}
					
					<!--1 2 3 4 5 6 7 8 9 10-->
					for(var idx = searchPageDTO.min; idx <= searchPageDTO.max; idx++ ){
						if(idx == searchPageDTO.currentPage){
								
//str+="<li class='page-item active'><a href='searchResult/boardNo="+boardNo+"&type="+type+"&keyword="+keyword+"&page="+idx+"' class='page-link'>"+idx+"</a></li>";
str+="<li class='page-item active'><a href='searchResult?boardNo="+boardNo+"&type="+type+"&keyword="+keyword+"&page="+idx+"' class='page-link'>"+idx+"</a></li>";	
						}else{
							
str+="<li class='page-item'><a href='searchResult?boardNo="+boardNo+"&type="+type+"&keyword="+keyword+"&page="+idx+"' class='page-link'>"+idx+"</a></li>"; 					
						
						}
					}		
						<!--다음-->
						if(searchPageDTO.max >= searchPageDTO.pageCount){
str+="<li class='page-item disabled'><a href='#' class='page-link'>다음</a></li>"; 
						}else{
str+="<li class='page-item'><a href='searchResult?boardNo="+boardNo+"&type="+type+"&keyword="+keyword+"&page="+searchPageDTO.nextPage+"' class='page-link'>다음</a></li>"; 
						}
						
						$('#page').html(str);
						
				}else{
						str='검색결과가 없습니다.'; 
						$('#boardtable').append(str);
						
						$('#page').empty(); 
					
				}//else의 끝
			}, //성공 function의 끝
			error: function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			
			
			
		}) //ajax의 끝
}//searchList의 function의 끝	

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
	<!-- <img src="/GoroGoroCommunity/image/convenientStore.png"> -->
	<img src="/GoroGoroCommunity/image/candy.png">
</article>
<!--Post List(게시글 리스트)-->
<div class="container" style="margin-top:30px; margin-bottom:30px;">
	<!-- <div class="card shadow-none">-->
	
		<!-- 검색 기능 -->			
		<form action="javascript:searchList()" name="search-form" autocomplete="off" class="text-center" style="margin-top:30px;">
			<select id="type" name="type">
				<option value="titleANDcontent">제목+내용</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="writer">작성자</option>
			</select>			
			<input type="text" value="" name="keyword" id="keyword" required="required"/>
			<input type="hidden" id="boardNo" name="boardNo" value="${boardNo }"/>
			<input type="button" onclick="javascript:searchList()" class="btn btn-warning btn-sm" value="검색"/>
		</form>
		<!-- 검색기능끝 -->	
	
	
		<div class="card-body">	
			<h1 class="card-title">${boardName }</h1>
			<font id="resultLength" size="3"></font>
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
				
				
				
				<!-- 검색결과 -->
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
				<c:when test="${signInMemberDTO.signIn == true }"><!-- 글쓰기버튼은 로그인을 한 사람만 보인다. -->
					<c:choose>
						<%--즉, 관리자인경우, 관리자게시판에만 해당 --%>
						<c:when test="${boardNo == 1 }">
							<c:choose>
								<c:when test="${signInMemberDTO.memberNo == 1}">
									<div class="text-right">
										<a href="write?boardNo=${boardNo }" class="btn btn-warning">글쓰기</a>
									</div>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<div class="text-right">
								<a href="write?boardNo=${boardNo }" class="btn btn-warning">글쓰기</a>
							</div>
						</c:otherwise>
					</c:choose>
				</c:when>	
				<c:otherwise></c:otherwise>
			</c:choose>
			
			
			<c:choose>
			
				<c:when test="${searchListPageDTO.prePage >= 0 }">
				</c:when>
				<c:otherwise>
						<!-- 메인 게시판의 그 페이징(Paging) -->			
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
				<!-- 리셋해야할 부분 -->	
				</ul>
			</div>
				</c:otherwise>
			</c:choose>
			
			
			
		
			
		<!-- 검색 페이징(Paging) -->		
		<c:choose>
			
			<c:when test="${searchListPageDTO.prePage >= 0 }">
			<div class="d-none d-md-block">
				<ul class="pagination justify-content-center">
				<!-- 이전 -->
				<c:choose>
					<c:when test="${searchListPageDTO.prePage <= 0 }" >
						<li class="page-item disabled">
							<a href="#" class="page-link">이전</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="searchLst?boardNo=${boardNo}&page=${pageDTO.prePage}" class="page-link">이전</a>
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
				<!-- 리셋해야할 부분 -->	
				</ul>
			</div>
			</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>	
			
			


		</div>
</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>