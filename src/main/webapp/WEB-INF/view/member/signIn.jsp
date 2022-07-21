<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
<c:import url="/WEB-INF/view/include/top_menu.jsp"/>
<!--가운데 그림-->
<article class="slider">	
	<img src="${root }image/yamamotoshinji_sapporo_clockTower.jpg">
</article>

<!-- 회원가입 폼 -->
<div class="container" style="margin-top:50px; margin-bottom:50px; ">
	<div class="row">
		 <div class="col-lg-4 col-sm-6"></div>
			<div class="card shadow-none">
				<div class="card-body">
                  <c:if test="${failure == true }" >
					<div class="alert alert-danger"><h3>로그인 실패</h3><p>아이디 비밀번호를 확인해주세요</p></div>
                  </c:if>
						<form:form action="${root }member/login_proc" method="post" modelAttribute="tmpLoginMemberDTO" >
						<div class="form-group">
							<form:label path="member_id">아이디</form:label>
							<form:input path="member_id" class="form-control"/>
                            <form:errors path="member_id" style="color: red;"/>
						</div>
						<div class="form-group">
							<form:label path="member_pw">비밀번호</form:label>
							<form:password path="member_pw" class="form-control"/>
                            <form:errors path="member_pw" style="color: red;"/>
						</div>
						<div class="form-group ">
						<div class="text-left">
							<a href="${root }member/find_id_form" style="">아이디</a>또는 <a href="${root }member/find_password_question" style="">비밀번호</a>를 잊으셨습니까? 
						</div>
						<br>
						<div class="text-right">
							<form:button class="btn btn-danger">로그인</form:button>
						</div>
						</div>
						
						
						</form:form>
				</div>
			</div>
		</div>
		</div>
		<div class="col-sm-3"></div>
	
	
	
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottom_info.jsp" />
</body>
</html>