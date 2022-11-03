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
<script type="text/javascript">
	
	//1. 회원가입 완료버튼 누르고, 회원가입 
	function signUpProcess(){
		
		var email = $("#email").val(); //이메일(아이디)
		var nick = $("#nick").val(); // 대화명
		var question = $("#question").val(); //질문
		var answer = $("#answer").val(); //답
		var passwords = $("#passwords").val(); //작성자
		
		var formData = new FormData($('#signUpMemberDTO')[0]);	
		
		if(email == ""){			
			alert("아이디로 사용하실 이메일(E-mail)을 입력해주세요.");
			$("#email").focus();
			return;
		}
			
		if(nick == ""){			
			alert("대화명으로 사용하실 닉네임을 입력해주세요.");
			$("#nick").focus();
			return;
		}
		
		if(passwords == ""){			
			alert("패스워드를 입력해주세요.");
			$("#passwords").focus();
			return;
		}
		
		if(question == ""){			
			alert("아이디 분실시 사용하실 질문를 입력해주세요.");
			$("#question").focus();
			return;
		}
		
		if(answer == ""){			
			alert("아이디 분실시 사용실 답을 입력해주세요.");
			$("#answer").focus();
			return;
		}
		
		var yn = confirm("회원가입 하시겠습니까?");		
		
		if(yn){
			
			 $.ajax({   
	                url      : "${root}member/signUpProcess", 
	            	data     : $("#signUpMemberDTO").serialize(), 
	                dataType : "json",
	                cache    : false,
	                async    : true,
	                type     : "POST",    
	                success  : function(obj) { insertBoardCallback(obj); },           
	                error	 : function(request,status,error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); }
				}) //아작스 
			};	//yn의 끝
		} //signUpProcess()의 끝
			
		
	//회원가입 완료 콜백함수
	function insertBoardCallback(obj){
	
		if(obj != null){		
			
			var result = obj.result;
			
			if(result == "SUCCESS"){				
				alert("회원가입을 성공하였습니다. 로그인 페이지로 이동하겠습니다.");				
				goToTheSignIn();				 
			} else {				
				alert("회원가입에 실패하였습니다. ");	
				return;
			}
		}
	}
	//2. 로그인 페이지로 이동(회원가입 한 뒤 로그인 페이지로 이동합니다. )
	function goToTheSignIn(){
		location.href = "${root}member/signIn";
	}

	//3. 이메일(아이디) 중복확인 쿼리와 대화명(닉네임) 중복확인 쿼리
	//1) 이메일 중복확인 
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

	//2) 닉네임 중복검사
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
<article class="slider"><img src="${root }image/Camping.jpg"></article>
<!-- 회원가입 폼 -->
<div class="container" style="margin-top:50px; margin-bottom:50px;">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7"><h4>회원가입</h4>
		<div class="card shadow-none">
		<div class="card-body">
			
			<form action="" name="signUpMemberDTO" method="post" id="signUpMemberDTO">
			<%--이메일(아이디) 입력, 중복확인 --%>
			<div class="form-group">
				<label for="email">이메일(E-mail address)</label>
				<div class="input-group">
				
				<input type="text" id="email" name="email" class="form-control" onkeypress="resetInputEmail()"/>
					
					<div class="input-group-append">
						<input type="button" class="btn btn-danger" onClick="checkEmail();" value="이메일 중복확인">
					</div>
				</div>
			</div>
			<%-- 비밀번호 입력과 한번더 입력해서 확인 --%>    
			<div class="form-group">
				<label for="passwords">비밀번호</label>
				<input type="password" name="passwords" id="passwords" class="form-control" />
				
			</div>                   
			<div class="form-group">
				<label for="passwords2">↑↑↑↑↑ 위 비밀번호 확인</label>
				<input type="password" name="passwords2" id="passwords2" class="form-control" />
				
			</div> 
			<%--대화명(닉네임) 입력, 중복확인 --%>
			<div class="form-group">
				<label for="nick">대화명(닉네임)</label>
				<div class="input-group">
				<input type="text" name="nick" id="nick" class="form-control" onkeypress="resetInputNick()"/>
					<div class="input-group-append">
						<input type="button" class="btn btn-danger" onClick="checkNick();" value="대화명 중복확인">
					</div>
				</div>
			</div>
			
			<div class="form-group"> 
				<label for="question">이메일 또는 비밀번호 분실시 질문</label>
				<select name="question" id="question" class="form-control">
					<option value="hometown">당신의 고향은 어디입니까?</option>
    				<option value="nickname">별명은 무엇인가요? </option>
    				<option value="firstlove">첫사랑은 누구인가요?</option>
    				<option value="pet">애완동물의 이름은?</option>
    				<option value="treasure">당신의 보물1호는 무엇인가요?</option>
				</select>
			</div> 
			<div class="form-group">
				<label for="answer">↑↑↑↑↑ 위 질문에 대한 답</label>
				<input type="text" name="answer" id="answer" class="form-control"/>
			</div>   
			<div class="text-right" style="margin-top:50px">
				<button class="btn btn-danger" onclick="javascript:signUpProcess();">회원가입 완료</button>
			</div>
			</form>
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