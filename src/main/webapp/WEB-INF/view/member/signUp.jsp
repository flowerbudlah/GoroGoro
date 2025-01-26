<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${root }js/validation.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
	});

	function signIn() {
		location.href = "${root}member/signIn";
	}

	// 1. 회원가입 완료버튼 누르고, 회원가입 
	function signUpProcess() {

		var email = $("#email").val(); // 이메일(아이디)
		var nick = $("#nick").val(); // 대화명
		var question = $("#question").val(); // 질문
		var answer = $("#answer").val(); // 답
		var passwords = $("#passwords").val(); // 비밀번호1
		var passwordsConfirm = $("#passwordsConfirm").val(); //비밀번호2 

		var emailValidity = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); //이메일 유효성 검사

		var formData = new FormData($('#signUpMemberDTO')[0]);

		if (email == "") {
			alert("이메일을 입력해주세요.");
			$("#email").focus();
			return;
		}

		if (nick == "") {
			alert("닉네임을 입력해주세요.");
			$("#nick").focus();
			return;
		}

		if (passwords == "" || passwordsConfirm == "") {
			alert("패스워드를 입력해주세요.");
			$("#passwords").focus();
			return;
		}

		var yn = confirm("회원가입을 하시겠습니까?");

		if (yn) {

			if ((passwords == passwordsConfirm) && (emailValidity.test($("#email").val()))) {

				$.ajax({
					url : "${root}member/checkEmail",
					type : "post",
					data : {email : email},
					success :
						
						function(data) {
							
							if (data == "unavailable") {
								
								alert("이미 그 아이디는 누가 사용하고 있기에 사용불가입니다. ");
							
							// 입력한 이메일이 중복된 이메일이 아니기에 사용가능하다면, 	
							} else if (data == "available") {

									// 닉네임 중복검사
									$.ajax({
										url : "${root}member/checkNick",
										type : "post",
										data : {nick : nick},
										success :
											function(data) {
												
												if (data == "unavailable") {
													
													alert("입력하신 닉네임은 이미 누가 사용중이기에 사용할 수 없습니다. 다른 닉네임을 입력해주세요! ");
												
												// 사용가능 한 닉네임이라면,
												} else if (data == "available") {
													
													// 회원가입 진행한다. 
													$.ajax({
														url : "${root}member/signUpProcess",
														data : formData,
														cache : false,
														async : true,
														contentType : false, //이것을 붙이고 나서 업로드가 된것이다. 
														processData : false, // 이것을 붙이고 업로드가 되었다. 
														type : "POST",
														success : function(obj) {
																	
																	if (obj != null) {
																		
																		var result = obj.result;
																		
																		if (result == "success") {
																			
																			alert("회원가입을 성공하였습니다. 로그인 페이지로 이동하겠습니다.");
																			signIn();
																		
																		} else {
																			
																			alert("회원가입에 실패하였습니다. ");
																			return;
																		}
																	}
																},
														error : function(request, status, error) {
																	alert("code:" + request.status + 
																	"\n" + "message:" + request.responseText + 
																	"\n" + "error:" + error);
																}
														}) // 회원가입 아작스의 끝
													} // 사용가능한 닉네임 체크여부 else if의 끝
												} // 닉네임 체크 function(data)
											})// 닉네임 중복 아작스
											
							} // 이메일 중복 체크 아작스 
						} // 이메일 중복체크 function(data)
					})// 이메일 중복 아작스
			
			} else if (passwords != passwordsConfirm) {
				alert("패스워드는 같아야합니다.");
			} else if (!emailValidity.test($("#email").val())) {
				alert("이메일 형식에 맞게 입력을 해주시고 다시한번 회원가입 시도해주세요!");
			}

		}//yn의 끝
	} //signUpProcess()의 끝
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
<article class="slider"><img src="${root }image/Camping.jpg"></article>
<!-- 회원가입 폼 -->
<div class="container" style="margin-top:50px; margin-bottom:50px;">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7"><h4>회원가입</h4>
		<div class="card shadow-none">
		<div class="card-body">
		<form name="signUpMemberDTO" method="post" id="signUpMemberDTO">
			<table>
				<tr>
					<td>이메일(E-mail address)</td>
	  				<td>
	  					<div class="input-group">
	  						<input type="email" id="email" name="email" class="form-control"/>
						</div>
						<font id="checkId" size="2"></font>
	  				</td>			
				</tr>
				<tr>
	 	 			<td>비밀번호</td>
	  				<td><input type="password" name="passwords" id="passwords" class="form-control pw"/></td>
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
	  				<td>
	  					<input type="text" id="nick" name="nick" class="form-control">
	  					<font id="checkNick" size="2"></font>
	  				</td>
				</tr>
				<tr>
					<td>이메일 또는 비밀번호 분실시 질문&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						<select name="question" id="question" class="form-control">
							<option value="당신의 고향은 어디입니까?">당신의 고향은 어디입니까?</option>
    						<option value="별명은 무엇인가요?">별명은 무엇인가요? </option>
    						<option value="첫 사랑은 누구인가요?">첫 사랑은 누구인가요?</option>
    						<option value="애완동물의 이름은?">애완동물의 이름은?</option>
    						<option value="당신의 보물1호는 무엇인가요?">당신의 보물1호는 무엇인가요?</option>
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
							<button type="button" class="btn btn-danger" onclick="javascript:signUpProcess();">회원가입 완료</button>
						</div>
	  				</td>
				</tr>
			</table>
		</form>
<script>

	// 비밀번호와 확인용 비밀번호의 일치여부 체크
	$('.pw').focusout(function() {

		let isPassOk = false;

		let passwords = $("#passwords").val();
		let passwordsConfirm = $("#passwordsConfirm").val();

		if (passwords != "" && passwordsConfirm != "") {
			if (passwords == passwordsConfirm) {
				let isPassOk = true;
				$("#checkPw").html('비밀번호가 일치합니다. ');
				$("#checkPw").attr('color', 'green');
			} else {
				let isPassOk = false;
				$("#checkPw").html('불일치 합니다. 다시한번 확인해주세요!');
				$("#checkPw").attr('color', 'red');
			}
		}
	})

	// 아이디용 이메일 검사
	$("#email").keyup(
			
			function() {
				
				var emailValidity = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);

				//이메일 유효성 검사
				if (!emailValidity.test($("#email").val())) { //이메일 형식에 맞지않는경우, 
					$("#checkId").html('이메일형식에 맞게 입력해주세요.');
					$("#checkId").attr('color', 'red');
					return false;
				}
				
				$.ajax({
					url : "${root}member/checkEmail",
					type : "post",
					data : {email : $("#email").val()},
					success : 
						function(data) {
							if (data == "unavailable") {
								$("#checkId").html('아이디 중복');
								$("#checkId").attr('color', 'red');
							} else if (data == "available") {
								$("#checkId").html('아이디 사용가능');
								$("#checkId").attr('color', 'green');
							}
						}
					});
				});
	
	// 닉네임 중복검사
	$("#nick").blur(
			
			function() { //foucusout, keyup, change, blur
				
				$.ajax({
					url : "${root}member/checkNick",
					type : "post",
					data : {nick : $("#nick").val()},
					success : function(result) {
						if (result == "unavailable") {
							$("#checkNick").html('중복된 닉네임! 사용불가');
							$("#checkNick").attr('color', 'red');
						} else if (result == "available") {
							$("#checkNick").html('사용가능합니다.');
							$("#checkNick").attr('color', 'green');
						}
					}
				})
				
			});
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