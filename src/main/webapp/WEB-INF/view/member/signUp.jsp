<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
body{ background-color: white; }
</style>
</head>
<body>
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!--가운데 그림-->
<article class="slider">	
	<img src="${root }image/Camping.jpg">
</article>

<!-- 회원가입 폼 -->
<div class="container" style="margin-top:50px; margin-bottom:50px;">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7"><h5>회원가입</h5>
		<div class="card shadow-none">
		<div class="card-body">
			<form:form action="${root }member/join_proc" method="post" modelAttribute="joinMemberDTO" id="joinMemberDTO">
			<form:hidden path="inputMemberID" />
			<form:hidden path="inputMemberEmail" />
			
				<div class="form-group" >
					<form:label path="member_name">이름</form:label>
					<form:input path="member_name" class="form-control"/>
					<form:errors path="member_name" style="color:red;" />
				</div> 
				
				<%--아이디 입력 시작 --%>	
				<div class="form-group" >
					<form:label path="member_id">아이디</form:label>
					<div class="input-group">
						<form:input path="member_id" class="form-control" onkeypress="resetInputMemberID()"/>
						<div class="input-group-append">
							<button type="button" class="btn btn-danger" onClick="checkID();">아이디 중복확인</button>
						</div>
					</div>
					<form:errors path="member_id" style="color:red;" />
				</div>
				<%--아이디 입력 끝 --%>	    
				           
				<div class="form-group">
					<form:label path="member_pw">비밀번호</form:label>
					<form:password path="member_pw" class="form-control" />
					<form:errors path="member_pw" style="color:red;" />
				</div>                   
				<div class="form-group">
					<form:label path="member_pw2">비밀번호 확인</form:label>
					<form:password path="member_pw2" class="form-control" />
					<form:errors path="member_pw2" style="color:red;" />
				</div> 
				<div class="form-group">
					<form:label path="member_tel">연락처</form:label>
					<form:input path="member_tel" class="form-control"/>
				</div> 
				
				<%--이메일중복 --%>
				<div class="form-group">
				<form:label path="member_email">E-mail</form:label>
				<div class="input-group">
				<form:input path="member_email" class="form-control" onkeypress="resetInputMemberEmail()"/>
					<div class="input-group-append">
						<button type="button" class="btn btn-danger" onClick="checkEmail();">이메일 중복확인</button>
					</div>
				</div>
				<form:errors path="member_email" style="color:red;"/>
				</div>
				
				<%--주소입력 --%>
				<div class="form-group">
					<form:label path="member_address">주소</form:label>
					<div class="input-group-append">
						<input type="text" id="postcode" name="postcode" placeholder="우편번호" class="form-control">&nbsp;
						<input type="button" class="btn btn-danger btn-sm" id="searchAdd" value="우편번호 찾기" >
					</div>
					<form:input path="member_address" placeholder="상세주소" id="roadAddress" class="form-control"/>
				</div>
				
			
           
				<div class="text-right" style="margin-top:100px">
					<form:button class="btn btn-danger" onclick="javascript:join_success();">회원가입 완료</form:button>
				</div>
			</form:form>
		</div>
		</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>