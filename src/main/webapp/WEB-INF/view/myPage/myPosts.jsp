<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script type="text/javascript">    
function searchList(){
	
	const keyword = $("#keyword").val(); //내용
	if (keyword == ""){			
		alert("검색어를 입력해주세요.");
		$("#keyword").focus();
		return;
	}
			
	$.ajax({
		type: 'get',
		url : 'searchList',
		data : $("form[name=search-form]").serialize(), 
		success : function(result){
			$('#boardtable').empty(); 	//테이블 초기화
			
			if(result.length>=1){
				result.forEach(function(item){
					
					str='<tr>'
						str+="<td><center>"+item.postNo+"</center></td>"; //글번호
						str+="<td><a href='read?postNo=" +item.postNo+ "'>" + item.title + "<font color='red'>["+ item.replyCount+"]</font></a></td>"; //제목
						str+="<td><center>"+item.writer+"</center></td>"; //작성자
						str+="<td><center>"+item.reg_date+"</center></td>"; //작성날짜
						str+="<td><center>"+item.viewCount+"</center></td>"; //조회수
						str+="<td><center>"+item.sameThinking+"</center></td>"; //공감수
					str+="</tr>"
					$('#boardtable').append(str);
        		})		
			}else{
					str='검색결과가 없습니다.'; 
					$('#boardtable').append(str);
			}
		}  //function의 끝
	}) //ajax의 끝
}//function의 끝	
</script>
<style>
.slider img{display:block; width:100%; max-width:100%; height:300px;} /* 슬라이더 영역 CSS */
body{
	 background-image: url(http://localhost:8090/GoroGoroCommunity/image/bottom-bg.jpg);
	 background-repeat: no-repeat; background-position: center bottom; background-attachment: fixed; 
}
</style>
</head>
<body>
<!-- 상단 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!-- 그 게시판 윗 부분 그림-->
<article class="slider">
	<img src="/GoroGoroCommunity/image/convenientStore.png"> 
</article>
<!--Post List(내가 쓴 게시글 리스트)-->
<div class="container" style="margin-top:100px; margin-bottom:100px;">
	<div class="card-body">	
			<h4 class="card-title">내가 쓴 게시물</h4>
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
				
				
				<c:forEach var="postDTO" items="${myPostList }" >
					<tr>
						<td class="text-center d-none d-md-table-cell">${postDTO.postNo }</td>
						<td>
							<a href='http://localhost:8090/GoroGoroCommunity/board/read?postNo=${postDTO.postNo}' style="color:black">
								[${postDTO.boardName}]	${postDTO.title }
								<!-- 업로드 파일이 있다면 -->
								<c:if test="${postDTO.imageFileName != '' }">
									<img src="/GoroGoroCommunity/image/uploadingPhoto.png" width=20px;>
								</c:if>
								<!-- 댓글이 있을경우, 댓글 수-->
						 		<font color="red">[${postDTO.replyCount }]</font>
						 	</a>
						</td>
						<td class="text-center d-none d-md-table-cell">${postDTO.writer}</td>
						<td class="text-center d-none d-md-table-cell"><fmt:formatDate value="${postDTO.regDate }" pattern="yyyy-MM-dd"/></td>
						<td class="text-center d-none d-md-table-cell">${postDTO.viewCount }</td>
                        <td class="text-center d-none d-md-table-cell">${postDTO.sameThinking }</td>
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
							<a href="${root }myPosts?memberNo=${memberNo}&page=${pageDTO.prePage}" class="page-link">이전</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<!-- 1 2 3 4 5 6 7 8 9 10 -->
				<c:forEach var="idx" begin="${pageDTO.min }" end="${pageDTO.max }">
				<c:choose>
					<c:when test="${idx == pageDTO.currentPage }">
						<li class="page-item active">
						
							<a href="${root }myPosts?memberNo=${memberNo}&page=${idx}" class="page-link">${idx}</a>
							<!-- http://localhost:8090/GoroGoroCommunity/board/      main?boardNo=1&page=1 -->
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="${root }myPosts?memberNo=${memberNo }&page=${idx}" class="page-link">${idx}</a>
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
							<a href="${root }myPosts?memberNo=${memberNo}&page=${pageDTO.nextPage}" class="page-link">다음</a>
						</li>
					</c:otherwise>
				</c:choose>
				</ul>
			</div>
			<!-- 검색 기능 -->			
			<form action="javascript:searchList()" name="search-form" autocomplete="off" class="text-center" style="margin-top:30px; margin-bottom:30px;">
				<input type="hidden" name="memberNo" value="${memberNo }"/>
				<select name="type">
					<option value="titleANDcontent">제목+내용</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
				</select>			
				<input type="text" value="" name="keyword" id="keyword"/> <!-- required="required"  -->
				<input type="button" onclick="javascript:searchList()" class="btn btn-warning btn-sm" value="검색"/>
			</form>
			<!-- 검색기능끝 -->	
		</div>
	</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>