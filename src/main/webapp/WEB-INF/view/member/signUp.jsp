<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
<script type="text/javascript">
	//1. 이메일 중복확인 
	function checkEmail(){
		const email = $("#email").val()
		if(email.length == 0){
			alert('가입하실 Email를 입력해주세요!');
			return; 
		}
		
		$.ajax({
			url: '${root}member/checkEmail/'+ email, 
			type: 'get',
			dataType: 'text',
			success: 
				function(result){
					if(result.trim() == 'true'){
						alert('사용하실 수 있습니다. ');
						$('#inputEmail').val('true');
					}else{
						alert('다른 Email을 이용해주세요.');  
						$('#inputEmail').val('false');
					}
      			}//function(result)의 끝
    		})//아작스 끝
  	}//이메일 체크 제이쿼리 끝
	
  	function resetInputEmail(){
		$("#inputEmail").val('false'); 
	}
	
  	//2. 닉네임 중복검사
	function checkNick(){
		const nick = $("#nick").val()
		if(nick.length == 0){
			alert('사용하실 대화명(닉네임)을 입력해주세요!');
			return; 
		}
		
		$.ajax({
			url: '${root}member/checkNick/'+ nick, 
			type: 'get',
			dataType: 'text',
			success: 
				function(result){
					if(result.trim() == 'true'){
						alert('사용하실 수 있습니다. ');
						$('#inputNick').val('true');
					}else{
						alert('다른 대화명(닉네임)을 이용해주세요.');  
						$('#inputNick').val('false');
					}
      			}//function(result)의 끝
    		})//아작스 끝
  	}//대화명 중복 체크 제이쿼리 끝
	function resetInputNick(){
		$("#inputNick").val('false'); 
	}
</script>
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
		<form:form action="${root }member/signUpProcess" modelAttribute="signUpMemberDTO"
		method="post"  id="signUpMemberDTO">
			<form:hidden path="inputEmail" />
			<form:hidden path="inputNick" />
			<%--이메일(아이디) 입력, 중복확인 --%>
			<div class="form-group">
				<form:label path="email">이메일(E-mail address)</form:label>
				<div class="input-group">
				<form:input path="email" class="form-control" onkeypress="resetInputEmail()"/> 			
					<div class="input-group-append">
						<input type="button" class="btn btn-danger" onClick="checkEmail();" value="이메일 중복확인">
					</div>
				</div>
				<form:errors path="email" style="font-size:13px; color:red;" />
			</div>
			<%-- 비밀번호 입력과 한번더 입력해서 확인 --%>    
			<div class="form-group">
					<form:label path="passwords">비밀번호</form:label>
					<form:password path="passwords" class="form-control" />
					<form:errors path="passwords" style="font-size:13px; color:red;" />
				</div>                   
				<div class="form-group">
					<form:label path="passwords2">비밀번호 확인</form:label>
					<form:password path="passwords2" class="form-control" />
					<form:errors path="passwords2" style="font-size:13px; color:red;" />
				</div> 
			<%--대화명(닉네임) 입력, 중복확인 --%>
			<div class="form-group">
				<form:label path="nick">대화명(닉네임)</form:label>
				<div class="input-group">
				<form:input path="nick" class="form-control" onkeypress="resetInputNick()"/> 			
					<div class="input-group-append">
						<input type="button" class="btn btn-danger" onClick="checkNick();" value="닉네임 중복확인">
					</div>
				</div>
				<form:errors path="nick" style="font-size:13px; color:red;" />
			</div>
			<div class="form-group"> 
				<form:label path="question">이메일 또는 비밀번호 분실시 질문</form:label>
				<form:select path="question" class="form-control">
					<form:option value="hometown">당신의 고향은 어디입니까?</form:option>
    				<form:option value="nickname">별명은 무엇인가요? </form:option>
    				<form:option value="firstlove">첫사랑은 누구인가요?</form:option>
    				<form:option value="pet">애완동물의 이름은?</form:option>
    				<form:option value="treasure">당신의 보물1호는 무엇인가요?</form:option>
				</form:select>
			</div> 
			<div class="form-group">
				<form:label path="answer">↑↑↑↑↑ 위 질문에 대한 답</form:label>
				<form:input path="answer" class="form-control"/>
			</div>   
			<div class="text-right" style="margin-top:50px">
				<form:button class="btn btn-danger" onClick="javascript:afterSignUp();">회원가입 완료</form:button>
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