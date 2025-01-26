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
//질문을 가져오는 제이쿼리
function takeQuestion(){
	const nick = $("#nick").val(); 
	if (nick == ""){			
		alert("검색어를 입력해주세요.");
		$("#nick").focus();
		return;
	}
			
	$.ajax(
			{
			type: 'get',
			url : '${root}member/takeQuestion',
			data : $("form[name=search-form]").serialize(), 
			success : 
				function(result){
					$('#findEmail').empty(); 	//테이블 초기화
					
					if(result.length == 0){//검색결과가 전혀없는 경우 
						str="<img src='${root }image/banner/cryingPeko.jpg' width='100px;'><br>"; 
						str+="입력하신 닉네임에 대한 회원정보가 없으니<br> 다시 한번 확인하시고 입력해주세요!<br><br>"; 
						str+="<a href='${root }member/findEmail' class='btn btn-success btn-sm'>이전으로 돌아가기</a>    "; 
						$('#findEmail').append(str);
						
					}else{
						str="아래의 질문에 정확히 응답해주세요!<br><br><strong>"+result.question+"</strong><br>";
						str+="<form action='javascript:findEmail()' name='search-form2'>"; 
						str+="<input type='text' id='answer' name='answer'>"; 
						str+="<input type='hidden' value='"+result.nick+"' id='nick' name='nick'>"; 
						str+="<button class='btn btn-warning btn-sm'>제출하기</button></form>  ";
						$('#findEmail').append(str);
					
					}
			}  //function(result)
		}
	) //ajax의 끝
}//function의 끝	

function findEmail(){
	const answer = $("#answer").val(); 
	if (answer == ""){			
		alert("질문에 대한 답을 입력해주세요!");
		$("#answer").focus();
		return;
	}
				
	$.ajax(
			{
		type: 'get',
		url : '${root}member/findIDemail',
		data : $("form[name=search-form2]").serialize(), 
		success : function(result){
					$('#findEmail').empty(); 	//테이블 초기화
					
					if(result.length == 0){//검색결과가 전혀없는 경우 
						str="<img src='${root }image/banner/cryingPeko.jpg' width='100px;'><br>"; 
						str+="입력하신 회원정보가 없으니<br> 다시 한번 확인하시고 입력해주세요!"; 
						str+="      "; 
						$('#findEmail').append(str);
					}else{//이메일이 발견된 경우, 
						str="<img src='${root }image/banner/bluePekko.png' width='100px;'><br>"; 
						str+="이메일은 <strong>"+result+"</strong> 입니다.";
						$('#findEmail').append(str);
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
	background-repeat: no-repeat; background-position: center bottom; background-attachment: fixed;   
	}
#findEmail{ text-align: center;}
</style>
</head>
<body>
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!--가운데 그림-->
<article class="slider">
	<img src="${root }image/candy04.jpg">
</article>
<!-- 로그인 폼 -->
<div class="container" style="margin-top:50px; margin-bottom:50px; ">
	<div class="row">
		<div class="card-body" id="findEmail">
			로그인을 하실 때 입력하셨던 <strong>이메일(Email)을 잊으셨나요?</strong><br>
			먼저 사용하시던 닉네임을 입력해주시고, 아래의 정보확인 질문에 응답을 해주세요! <br><br>
			사용하시던 <strong>닉네임</strong>은 무엇입니까 ? 
			<form action="javascript:takeQuestion()" name="search-form" autocomplete="off" style="margin-top:20px;">
				<input type="text" id="nick" name="nick">
				<button class="btn btn-warning btn-sm">제출하기</button>
			</form>
		</div>
	</div>
</div>
<div class="col-sm-3"></div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>