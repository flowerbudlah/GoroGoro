<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>신고내용 읽기</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
.reply{ font-size: 12px; }
.replyWriter{ text-align:left; position: absolute; }
.replyRegDate{ text-align:right;  position: relative; }
.slider img{display:block; width:100%; max-width:100%; height:300px;} /* 슬라이더 영역 CSS */
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<!-- 그 게시판 윗 부분 그림-->  
<article class="slider"><img src="/GoroGoroCommunity/image/convenientStore.png"> </article>
<!-- 본문 -->
<div class="container" style="margin-top:100px; margin-bottom:100px;">
	<div class="row">
	<div class="col-sm-3"></div>
	<div class="col-sm-7">
	<div class="card shadow-none">
	<div class="card-body">
	<h4 class="card-title">${readReportDTO.postNo}번 게시글 신고내역</h4> 
		
			<a href='http://localhost:8090/GoroGoroCommunity/board/read?postNo=${readReportDTO.postNo}' style="color:black">
			신고 게시글 상세 보기
			</a>	
	
		<div>
			<label for="reportNo">신고번호</label>
			<input type="text" id="reportNo" name="reportNo" class="form-control" value="${readReportDTO.reportNo}" disabled/>
		</div>
		<div class="form-group">
			<label for="writer">신고자</label>
		 	<input type="text" id="reporter" name="reporter" class="form-control" value="${readReportDTO.reporter}" disabled="disabled"/>
		</div>
		<div class="form-group">
			<label for="reportDate">신고일짜</label>
			<input type="text" id="reportDate" name="reportDate" class="form-control" value="<fmt:formatDate value="${readReportDTO.reportDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" disabled="disabled"/>
		</div>
		<div class="form-group">
			<label for="title">신고사유</label>
			<input type="text" id="reason" name="reason" class="form-control" value="${readReportDTO.reason}" disabled="disabled"/>
		</div>
		<div class="form-group">
			<label for="detail">신고내용</label>
			<textarea id="detail" name="detail" class="form-control" rows="10" style="resize:none" disabled="disabled">${readReportDTO.detail}</textarea>
		</div>
		<div class="form-group">
			<c:if test="${readReportDTO.imageFileName != ''}">
          		<label for="fileName">첨부 이미지 파일</label>
          		<a href="http://localhost:8090/GoroGoroCommunity/upload/${readReportDTO.imageFileName}">
        
        			${readReportDTO.imageFileName} 
          		</a> 
        		 
          	</c:if>  
		</div>
		<!-- 첨부이미지와 내용 end -->
		<div class="form-group">
			<label for="board_content">관리자 댓글[]</label>
		</div>


<!-- 댓글 작성 부분(로그인을 한 회원만 보이게) -->
<c:choose>
	<c:when test="${signInMemberDTO.memberNo == 1 }">
	<form id="writeReplyDTO" name="writeReplyDTO">
		<input type="hidden" name="reportNo" id="reportNo" value="">
		<!-- 댓글 작성 폼 -->	
		<div class="reply">
			<input type="hidden" id="replyWriter" name="replyWriter" value="${signInMemberDTO.nick }"/>
			<textarea id="replyContent" name="replyContent" class="form-control" rows="3" style="resize:none" placeholder="관리자님께서 하시고 싶은 말씀을 입력해주세요.">
			</textarea>
			<div class="text-right">
				<button type="button" class="btn btn-info btn-sm" onclick="javascript:writeReplyProcess();">작성완료</button>
			</div>
		</div>	
	</form>
	</c:when>
	<c:otherwise></c:otherwise>
</c:choose>
<!-- 댓글 작성 부분(로그인을 한 회원만 보이게) -->
		</div>

	
	<div class="form-group">
		<div class="text-right">
			<button type="button" class="btn btn-primary btn-sm" onclick="javascript:goMain();">이전으로</button>
			<a href="modify?postNo=${postNo }" class="btn btn-info btn-sm">신고내용 수정하기</a>
			<!--http://localhost:8090/GoroGoroCommunity/board/modify?postNo=1  -->
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:deletePost();">신고취소</button>
			&emsp;
		</div>
	</div>
          
   </div>
	</div>
	</div>
	<div class="col-sm-3"></div>
</div>
<!-- 하단 정보 -->  
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>