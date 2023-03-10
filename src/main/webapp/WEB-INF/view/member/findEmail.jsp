<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 찾기</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">



</script>
<style>
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
							
	
	
	
	
	
				</div>
		</div>
	</div>
</div>
<div class="col-sm-3"></div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>