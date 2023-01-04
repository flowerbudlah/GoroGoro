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
	
	/* 글 작성  */
	function submit(){
		var writer = $("#writer").val(); //신고자
 		var title = $("#title").val(); //신고사유(제목)
		var content = $("#content").val(); //구체적인 신고내용
	
		var formData = new FormData($('#writePostDTO')[0]);	
		
		if (writer == ""){			
			alert("작성자를 입력해주세요.");
			$("#writer").focus();
			return;
		}
			
		if (title == ""){			
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return;
		}
		
		if (content == ""){			
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return;
		}
			
		var yn = confirm("게시글을 등록하시겠습니까?"); //작동
		
		if(yn){
			
			 $.ajax({   
	                url      : "${root}board/writeProcess", 
	                enctype  : "multipart/form-data",
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
		} //writeProcess()의 끝
			
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
<article class="slider"><img src="${root }image/yamamotoshinji_sapporo_clockTower.jpg">	</article>
<!-- 글쓰기 부분 시작 -->
<div class="container" style="margin-top:100px; margin-bottom:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7">
			<div class="card shadow-sm">
				<div class="card-body">
				<h5 class="card-title">게시글 신고양식</h5>
				<p>양식에 맞게 신고를 하시면 관리자에게 해당 글<strong>(글 번호:${postNo })</strong>의 신고접수가 됩니다.
				<br>신고가 접수된 게시물은 관리자의 판단 하에 처리되며, 법적처벌을 받을 수도 있습니다. </p>
				<form id="writePostDTO" name="writePostDTO" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label for="writer">신고자</label>
						<input type="text" id="writer" name="writer" readonly value="${signInMemberDTO.nick } (${signInMemberDTO.email })" class="form-control"/>
					</div>
					<div class="form-group">
						<label>받는사람</label>
						<input type="text" value="관리자 (admin@gorogoro.com)" disabled class="form-control"/>
					</div>
					<div class="form-group">
						<label for="title">신고사유</label>
						<select name="title" id="title" class="form-control">
							<option value="hometown">명예훼손, 모욕, 비방, 허위사실 유포</option>
    						<option value="nickname">광고, 도배</option>
    						<option value="firstlove">음란물</option>
    						<option value="">개인정보침해</option>
    						<option value="">저작권침해</option>
    						<option value="">기타(해당 게시판의 주제와 맞지않는내용 등)</option>
						</select>
					</div>
					<div class="form-group">
						<label for="content">구체적인 내용</label>
						<textarea id="content" name="content" class="form-control" rows="10" style="resize:none"></textarea>
					</div>		
					<!-- 첨부파일 시작-->
					<div class="form-group">
					<!-- private String imageFileName; //업로드한 사진의 이름
						 private MultipartFile imageFile; //업로드한 사진파일  -->
						<label for="imageFile">첨부 이미지 (증거 이미지)</label>
						<input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*">						
					</div>
					<!-- 첨부파일 끝 -->	
				</form>
				<div class="form-group">
					<div class="text-right">
						<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back();">이전페이지로 돌아가기</button>
						<button type="button" class="btn btn-info btn-sm" onclick="javascript:submit();">관리자에게 제출하기</button>
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