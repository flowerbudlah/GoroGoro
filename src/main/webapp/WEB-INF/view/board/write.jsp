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
	
	$(document).ready(function(){		
	});
	
	/** 게시판 - 목록 페이지 이동 */
	function goMain(){
		var boardNo = $("#boardNo").val();
		location.href = "${root}board/main?boardNo=${boardNo}";
	}

	/** 게시판 - 작성  */
	function writeProcess(){
		
		var boardNo = $("#boardNo").val(); //게시판 번호
		var writer = $("#writer").val(); //작성자
 		var title = $("#title").val(); //제목
		var content = $("#content").val(); //내용
		
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
			
		
		var yn = confirm("게시글을 등록하시겠습니까?");		
		
		
		if(yn){
				
			 $.ajax({   
	                url      : "${root}board/writeProcess",
	              
	                data     : $("#writePostDTO").serialize(), 
	                dataType : "JSON",
	                 
	                cache    : false,
	                async    : true,
	                type     : "POST",    
	                success  : function(obj) { insertBoardCallback(obj);},           
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
				alert("게시글 등록을 성공하였습니다.");				
				goMain();				 
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
				<div class="card-body"><h4 class="card-title">글쓰기</h4>

				<form id="writePostDTO" method="post" name="writePostDTO" enctype="multipart/form-data">	
				
					<input type="hidden" name="boardNo" id="boardNo" value="${boardNo }">
				
					<div class="form-group">
						<label for="writer">작성자</label>
						<input type="text" id="writer" name="writer" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="title">제목</label>
						<input type="text" id="title" name="title" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea id="content" name="content" class="form-control" rows="15" style="resize:none"></textarea>
					</div>
					
					<div class="form-group">
						<label for="uploadFile">첨부 이미지</label>
						<input type="file" id="uploadFile" name="uploadFile" class="form-control" accept="image/*" multiple="true"/>
					</div>
									
					<div class="form-group">
						<div class="text-right">
							
							<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:goMain();">목록으로</button>
							<button type="button" class="btn btn-info btn-sm" onclick="javascript:writeProcess();">등록하기</button>
							
						</div>	
					</div>
			
					</form>
					
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>
<!-- 하단 정보 -->  
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>