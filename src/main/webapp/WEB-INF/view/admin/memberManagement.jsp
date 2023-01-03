<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
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
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
body{ background-color: white; }
table{border: 1px solid gray; }
th{color: black; background-color: gold; text-align:center; border: 1px solid black;}
td{text-align:center; border: 1px solid black;}
</style>
</head>
<body>
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!--가운데 그림-->
<article class="slider"><img src="${root }image/yamamotoshinji_sapporo_clockTower.jpg"></article>
<!--메인화면에 내용 들어가는 부분  -->
<div style="padding-top:50px; padding-bottom:100px">
<div class="container">
<h4>관리자 전용 페이지(For the Administrator Only)</h4>
	<!-- 검색 기능 -->			
	<form action="javascript:searchList()" name="search-form" autocomplete="off" class="text-center" style="margin-top:30px; margin-bottom:30px;">
			<select name="type">
				<option value="email">email</option>
				<option value="nick">닉네임</option>
			</select>			
				<input type="text" value="" name="keyword" id="keyword" required="required"/> <!-- required="required"  -->
				<input type="button" onclick="javascript:searchList()" class="btn btn-warning btn-sm" value="회원검색"/>
	</form>
	<!-- 검색기능끝 -->
	<table style="width: 1100px; margin: auto;">
		<thead>
			<tr>
				<th style="text-align: center;">No</th>
				<th style="text-align: center;">Email</th>
				<th style="text-align: center;">닉네임</th>
				<th style="text-align: center;">게시글수</th>
				<th style="text-align: center;">댓글수</th>
				<th style="text-align: center;">신고게시글수</th>
				<th style="text-align: center;">가입일</th>
				<th style="text-align: center;"></th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${allMemberList}" var="allMemberList">
			<tr>
				<td style="text-align: center;">${allMemberList.memberNo }</td>
				<td style="text-align: center;">${allMemberList.email}</td>
				<td style="text-align: center;">
					<a href="">${allMemberList.nick }</a>
				</td>
				<td style="text-align: center;">
					<a href="">${allMemberList.postCount}</a>
				</td>
				<td style="text-align: center;">${allMemberList.replyCount}</td>
				<td style="text-align: center;">${allMemberList.reportCount}</td>
				<td style="text-align: center;">
					<fmt:formatDate pattern="yyyy-MM-dd(E) hh시 mm분 ss초" value="${allMemberList.signUpDate }" />
				</td>
				<td style="text-align: center;">강제탈퇴시키기</td>
			</tr>
		</c:forEach>
		</tbody>
</table> 
</div>
</div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>