<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">

	function signOutAfterLeave(){ //회원탈퇴가 되고 사인아웃되서 
	
	$.ajax({   
		url      : "${root}member/signOut", 
		type     : "POST",    
		success  : function(){
			
		},           
		error    : function(request,status,error){
			alert('회원탈퇴 후 로그아웃 실패'); 
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
		}
	}) //아작스		
} 	


	function goMain(){
		location.href = "${root}main";
	}

	$(document).ready(function(){// 취소
			$("#submit").on("click", function(){
			
				if($("#passwords").val()==""){
					alert("회원님의 비밀번호를 입력해주세요.");
					
					$("passwords").focus();
					return false;
				} 			
			});
	})
	
	
	//2. 1) 회원탈퇴
	function leave(){
		
		var email = $("#email").val();
		var passwords = $("#passwords").val();
		
		var yn = confirm("회원탈퇴를 하시겠습니까?");        
		
		if(yn){
	        
	        $.ajax({    
	         	url      : "leave", // "deletePost"성공
	            type     : "POST",    
	            data 	 : { email: email, passwords: passwords },
	            dataType : "JSON",
	            success  : function(obj) { 
	            	
	            	 if(obj != null){        
	            	        
	            	        var result = obj.result;
	            	        
	            	        if(result == "SUCCESS"){  
	            	            alert("회원탈퇴를 성공했습니다. 이용해주셔서 감사합니다. 안녕히가세요. ");  
	            	            
	            	            signOutAfterLeave(); //로그아웃(사인아웃)되서 세션풀기 
	            	            
	            	            goMain(); //메인화면으로 돌아간다. 
	            	        } else {     
	            	            alert("회원탈퇴 실패했습니다. ");    
	            	            return;
	            	        }
	            	    }
	            },           
	            error    : function(request, status, error) {
	            	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);	
	            }
	            
	         });
	    } //yn 끝        
	} //deletePost
		
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
<article class="slider">
	<img src="${root }image/yamamotoshinji_sapporo_clockTower.jpg">
	<!-- root = http://localhost:8090/GoroGoroCommunity/            
						image/yamamotoshinji_sapporo_clockTower.jpg -->
</article>
<!-- 로그인 폼 -->
<div class="container" style="margin-top:50px; margin-bottom:50px; ">
	<div class="row">
		 <div class="col-lg-4 col-sm-6"></div>
		
				<div class="card-body">
				<p>
					회원탈퇴를 원하세요? <br>
					탈퇴 전 정보 확인을 위해서 회원님의 <strong>비밀번호</strong>를 입력해주세요. <br>
					그 동안 <strong>고로고로커뮤니티(GoroGoroCommunity)</strong>를 이용해 주셔서 감사합니다.<br>
					안녕히 가세요! 
				</p>
				
				
				
				<form method="post" id="memberDTOisLeaving" name="memberDTOisLeaving">
					<input type="hidden" id="email" name="email" value="${signInMemberDTO.email}"/>
					<div class="form-group">
						<input type="password" id="passwords" name="posswords" size="30" />
					</div>		
					<div class="form-group">
						<input type="button" onClick="javascript:goMain();" class="btn btn-danger" value="탈퇴취소"/>
						<button id="submit" class="btn btn-success" onclick="javascript:leave();">회원탈퇴</button>
					</div>
				</form>
				
				
				
			<div>
				<c:if test="${msg == false}">비밀번호가 정확하지 않아요.</c:if>
			</div>	
			</div>		
		</div>
	</div>
<div class="col-sm-3"></div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>