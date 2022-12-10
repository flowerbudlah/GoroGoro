<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!--가운데 그림-->
<article class="slider"><img src="${root }image/yamamotoshinji_sapporo_clockTower.jpg"></article>
<!-- 로그인 폼 -->
<div class="container" style="margin-top:50px; margin-bottom:50px; ">
	<div class="row">
		 <div class="col-lg-4 col-sm-6"></div>
			<div class="card shadow-none">
				<div class="card-body">
					<form action="${root }member/signInProcess" modelAttribute="signInMemberDTO" method="post" name="" id="" >
					
						<div class="form-group">
							<label for="email">이메일(아이디)</label>
							<input type="text" name="email" id="email" class="form-control"/>
                           
						</div>
						<div class="form-group">
							<label for="passwords">비밀번호</label>
							<input type="password" name="passwords" id="passwords" class="form-control"/>
                     
						</div>
						
						<div class="form-group ">
							<div class="text-left">
								<a href="${root }member/find_id_form" style="">
								이메일(아이디)
								</a>
								또는 
								<a href="${root }member/find_password_question" style="">
								비밀번호
								</a>
								를 잊으셨습니까? 
							</div>
							<br>
							<div class="text-right">
								<button class="btn btn-danger" onclick="javascript:signIn();" >로그인</button>
							</div>
						</div>
						
					</form>
				</div>
			</div>
		</div>
		</div>
		<div class="col-sm-3"></div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>