<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고로고로(ゴロゴロ)</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){	});

	function reportProcess(){
		
		var postNo = ${"#postNo"}.val(); 
		var reporter = $("#reporter").val(); //신고자
 		var reason = $("#reason").val(); //신고사유(제목)
		var detail = $("#detail").val();
	
		var formData = new FormData($('#submitReportDTO')[0]);	
	
		if (detail == ""){			
			alert("내용을 입력해주세요.");
			$("#detail").focus();
			return;
		}
			
		var yn = confirm("게시글을 등록하시겠습니까?"); //작동
		
		if(yn){
			
			 $.ajax({   
	                url      : "${root}board/reportProcess", 
	                enctype  : "multipart/form-data",
	                data     : formData,
	                cache    : false,
	                async    : true,
	                contentType: false, //이것을 붙이고 나서 업로드가 된것이다. 
	                processData: false, // 이것을 붙이고 업로드가 되었다. 
	                type     : "POST",    
	                success  : function(obj) {
	                	insertBoardCallback(obj);	
	                },           
	                error: function(request,status,error){
	                	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	                }
				}) //아작스 
			};	//yn의 끝
		} //reportProcess()의 끝
			
	/** 게시판 - 작성 콜백 함수 */
	function insertBoardCallback(obj){
	
		if(obj != null){		
			
			var result = obj.result;
			
			if(result == "SUCCESS"){				
				alert("해당게시글이 관리자에게 신고되었습니다. 영업일(월~금) 1~2일내에 관리자의 판단하에 처리(삭제 또는 보존)됩니다. ");				
				return;
			} else {				
				alert("게시글 등록을 실패하였습니다.");	
				return;
			}
		}
	} 
</script>
<style>
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
body{ background-color: white; }
</style>
</head>
<body>
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<article class="slider">
	<img src="${root }image/yamamotoshinji_sapporo_clockTower.jpg">
</article>
<!-- 글쓰기 부분 시작 -->
<div class="container" style="margin-top:100px; margin-bottom:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7">
			<div class="card shadow-sm">
				<div class="card-body">
				<h5 class="card-title">게시글 신고양식</h5>
				<p>양식에 맞게 신고를 하시면 관리자에게 <strong>해당 글(글 번호:${postNo })</strong>의 신고접수가 됩니다.
				<br>신고가 접수된 게시물은 관리자의 판단 하에 처리되며, 법적처벌을 받을 수도 있습니다. </p>
				
				<form id="submitReportDTO" name="submitReportDTO" method="post" enctype="multipart/form-data">
					
					<input type="hidden" id="postNo" name="postNo" value="${postNo }">
					<input type="hidden" id="reporter" name="reporter" value="${signInMemberDTO.nick }">
					
					<div class="form-group">
						<label for="reporter">신고자</label>
						<input type="text" value="${signInMemberDTO.nick }" class="form-control" disabled/>
					</div>
					
					<div class="form-group">
						<label>받는사람</label>
						<input type="text" value="관리자" class="form-control" disabled/>
					</div>
					
					<div class="form-group">
						<label for="reason">신고사유</label>
						<select name="reason" id="reason" class="form-control">
							<option value="insult">명예훼손, 모욕, 비방, 허위사실 유포 등</option>
    						<option value="advertisement">광고, 도배 등</option>
    						<option value="porn">음란물</option>
    						<option value="personalInformation">개인정보침해</option>
    						<option value="copyright">저작권침해</option>
    						<option value="etc">기타(해당 게시판의 주제와 맞지않는내용 등)</option>
						</select>
					</div>
					
					<div class="form-group">
						<label for="detail">구체적인 내용</label>
						<textarea id="detail" name="detail" class="form-control" rows="10" style="resize:none"></textarea>
					</div>		
					<div class="form-group">
						<label for="imageFile">첨부 이미지</label>
						<input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*">						
					</div>
				</form>
				
				<div class="form-group">
					<div class="text-right">
						<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back();">이전페이지로 돌아가기</button>
						<button type="button" class="btn btn-info btn-sm" onClick="javascript:reportProcess();">관리자에게 제출하기</button>
					</div>	
				</div>
				</div>
			</div>
		</div><div class="col-sm-3"></div>
	</div>
</div>
<!-- 하단 정보 -->  
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>