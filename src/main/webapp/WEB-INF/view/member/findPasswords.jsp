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

function findPasswords(){
	
	$.ajax(
			{
			type: 'get',
			url : '${root}member/findPassword',
			data : $("form[name = toFindPasswords]").serialize(), 
			success : 
				function(result){
					$('#findPasswords').empty(); 	//테이블 초기화
					
					if(result.length == 0){//검색결과가 전혀없는 경우 
						
						str="<img src='${root }image/banner/cryingPeko.jpg' width='100px;'><br>"; 
						str+="입력하신 이메일의 회원정보가 없으니 다시 한번 확인하시고 입력해주세요!<br><br>"; 
						str+="<a href='${root }member/findPasswords' class='btn btn-success btn-sm'>이전 페이지로 돌아가기</a>"; 
						$('#findPasswords').append(str);
						
					}else{
						str="입력하신 이메일로 임시비밀번호가 발급되었습니다. 해당 이메일을 확인해주세요!";
						$('#findPasswords').append(str);
					}
			}  //function(result)
		}
	) //ajax의 끝
}//function의 끝	

</script>
<style>
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
body{  
background-image: url(http://localhost:8090/GoroGoroCommunity/image/bottom-bg.jpg); 
background-repeat: no-repeat; background-position: center bottom; background-attachment: fixed;   }
</style>
</head>
<body>
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!--가운데 그림-->
<article class="slider"><img src="${root }image/candy03.jpg"></article>
<!-- 로그인 폼 -->
<div class="container" style="margin-top:50px; margin-bottom:50px; ">
	<div class="row">
		<div class="col-lg-3 col-sm-7"></div>
			<div class="card-body" id="findPasswords">
			비밀번호를 잊으셨나요?<br>
			먼저 로그인을 하실때 입력하셨던 이메일을 입력해주세요!('_')
			<form action="javascript:findPasswords()" name="toFindPasswords" autocomplete="off" style="margin-top:20px;">
				<input type="email" id="email" name="email">
				<button class="btn btn-info btn-sm">제출하기</button>
			</form>
	
			</div>
		</div>
	</div>
<div class="col-sm-3"></div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>