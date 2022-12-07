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
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

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
<div class="container" style="margin-top:50px; margin-bottom:100px;">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7"><h4>회원가입</h4>
		<div class="card shadow-none">
		<div class="card-body">
			<table>
				<tr>
					<td>이메일(E-mail address)</td>
	  				<td>
	  					<input type="text" id="email" name="email" class="form-control"/>
	  					<font id = "checkId" size = "2"></font>
	  				</td>	
	  						
				</tr>
				<tr>
	 	 			<td>비밀번호</td>
	  				<td>
	  					<input type="password" name="passwords" id="passwords" class="form-control pw"/>
	  				</td>
				</tr>
				<tr>
	  				<td>↑ 위 비밀번호 확인</td>
	  				<td>
						<input type="password" name="passwordsConfirm" id="passwordsConfirm" class="form-control pw"/>
						<font id="checkPw" size="2"></font>
	  				</td>
				</tr>
			
				<tr>
	  				<td>닉네임</td>
	  				<td><input type="text" name="display_name" class="form-control"></td>
				</tr>
				<tr>
					<td>이메일 또는 비밀번호 분실시 질문&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						<select name="question" id="question" class="form-control">
							<option value="hometown">당신의 고향은 어디입니까?</option>
    						<option value="nickname">별명은 무엇인가요? </option>
    						<option value="firstlove">첫사랑은 누구인가요?</option>
    						<option value="pet">애완동물의 이름은?</option>
    						<option value="treasure">당신의 보물1호는 무엇인가요?</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>↑ 위 질문에 대한 답</td>
					<td><input type="text" name="answer" id="answer" class="form-control"/></td>
				</tr>
				<tr>
	  				<td colspan = "2" align = "center">
	  					<div class="text-right" style="margin-top:50px; margin-bottom:50px;">
							<input type = "submit" class="btn btn-danger" value="회원가입 완료" onclick="javascript:signUpProcess();">
						</div>
	  				
	  				</td>
				</tr>
			</table>
			
			<script>
$('.pw').keyup(function(){
	
	let pass1 = $("#passwords").val();
    let pass2 = $("#passwordsConfirm").val();
    
    if (pass1 != "" && pass2 != ""){
    	if (pass1 == pass2){
        	$("#checkPw").html('비밀번호가 일치합니다. ');
        	$("#checkPw").attr('color','green');
        } else {
        	$("#checkPw").html('불일치 합니다. 다시한번 확인해주세요!');
            $("#checkPw").attr('color','red');
        }
    }
})
</script>
			
			
			
			
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