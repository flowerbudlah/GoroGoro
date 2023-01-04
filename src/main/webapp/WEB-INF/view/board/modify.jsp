<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 수정</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- 게시글 번호 -->
<% String postNo = request.getParameter("postNo");%> 
<c:set var="postNo" value="<%=postNo %>"/> 
<script type="text/javascript">
	
	$(document).ready(function(){        });
	
	//1. 글 수정 아작스
	function modifyProcess(){

        var title = $("#title").val();
        var content = $("#content").val();
        var postNo = $("#postNo").val();    
        
        var formData = new FormData($('#modifyPostDTO')[0]);	
        
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
        
        var yn = confirm("게시글을 수정하시겠습니까?");        
        
        if(yn){
                
            $.ajax({    
                
               url      : "modifyProcess",
               enctype  : "multipart/form-data",
               data     : formData,
               contentType: false, //이것을 붙이고 나서 수정 업로드가 된것이다. 
               processData: false, // 이것을 붙이고 수정 업로드가 되었다. 
               cache    : false,
               async    : true,
               type     : "POST",    
               success  : function(obj) { updateBoardCallback(obj); },           
               error    : function(xhr, status, error) {}
            });
        }
    }
    
	//2.글 수정 콜백함수
	function updateBoardCallback(obj){
		
		if(obj != null){        
			var result = obj.result;
            
            if(result == "SUCCESS"){                
				alert("게시글 수정을 성공하였습니다."); 
				location.href = "read?postNo=${postNo }";
            } else {                
            	alert("게시글 수정을 실패하였습니다.");    
                return;
            }
        }
    } 
	
	//3. 첨부된 이미지를 삭제(실제는 업데이트기능)하는
	function deleteImageFile(){
		
		var postNo = $("#postNo").val(); 
		var imageFileName = $("#imageFileName").val(); 
		
		var formData = new FormData($('#imageFilePostDTO')[0]);	
		
		var yn = confirm("이미 업로드하신 이미지 첨부파일을 삭제하시겠습니까?");		
		
		if(yn){
			
			$.ajax({   
				url      : "deleteImageFile",
				data     : formData,
				type     : "POST",  
				contentType: false, //이것을 붙이고 나서 수정 업로드가 된것이다. 
				processData: false, // 이것을 붙이고 수정 업로드가 되었다. 
				cache    : false,
				async    : true,
				success  : function(obj){
					if(obj != null){        
						var result = obj.result;
			            
			            if(result == "SUCCESS"){                
							alert("이미지 파일의 제거를 성공하였습니다. "); 
							location.href = "modify?postNo=${postNo }";
			            } else {                
			            	alert("업로드하신 이미지 파일의 제거를 실패하였습니다. ");    
			                return;
			            }
			        }
					
				},           
				error	 : function(request,status,error){ 
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}) //아작스 
		};	//yn의 끝
	}
	
</script>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<!-- 글 수정 -->
<div class="container" style="margin-top:200px; margin-bottom:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7">
			<div class="card shadow-sm">
				<div class="card-body">
					<h4 class="card-title">게시글 번호: ${postNo } </h4>
											 <form id="imageFilePostDTO" name="imageFilePostDTO">
	<input type="hidden" id="postNo" name="postNo" value="${postNo }"/>
	<input type="hidden" id="imageFileName" name="imageFileName" value=""/>
</form>
<c:if test="${PostDTOfromDB.imageFileName != '' }" > 
첨부 이미지: ${PostDTOfromDB.imageFileName }

<button class="badge badge-pill badge-light" onclick="javascript:deleteImageFile();">   이 첨부파일 제거</button>
</c:if> 
					<form id="modifyPostDTO" name="modifyPostDTO" enctype="multipart/form-data">
					 <input type="hidden" name="postNo" value="${postNo }" > 
						<div class="form-group">
							<label for="writer">작성자</label>
							<input type="text" id="writer" name="writer" class="form-control" value="${PostDTOfromDB.writer }" disabled="disabled"/>
						</div>
						<div class="form-group">
							<label for="regDate">작성날짜</label>
							<input type="text" id="regDate" name="regDate" class="form-control" value="<fmt:formatDate value="${PostDTOfromDB.regDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" disabled="disabled"/>
						</div>
						<div class="form-group">
							<label for="title">제목</label>
							<input type="text" id="title" name="title" class="form-control" value="${PostDTOfromDB.title }"/>
						</div>
						<div class="form-group">
							<label for="content">내용</label>
							<textarea id="content" name="content" class="form-control" rows="15" style="resize:none">${PostDTOfromDB.content }</textarea>
						</div>

						<label for="imageFile">
							새로운 첨부 이미지:
							<input type="hidden" value="${PostDTOfromDB.imageFileName }" id="imageFileName" name="imageFileName "/>
						</label>
						<div class="form-group">
							<input type="file" name="imageFile" id="imageFile" class="form-control" accept="image/*"/>					
						</div>
            </form> <!-- 전체수정폼의 끝 -->
            
      		<div class="form-group">
				<div class="text-right">
					<button class="btn btn-primary btn-sm" onclick="javascript:modifyProcess();">수정완료</button>
					<button class="btn btn-info btn-sm" onclick="javascript:history.back();">수정취소</button>
				</div>
			</div>
            
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>
<!-- 
<form id="imageFilePostDTO" name="imageFilePostDTO">
	<input type="hidden" id="postNo" name="postNo" value="${postNo }"/>
	<input type="hidden" id="imageFileName" name="imageFileName" value=""/>
</form>
<c:if test="${PostDTOfromDB.imageFileName != '' }" > 
첨부 이미지: ${PostDTOfromDB.imageFileName }

<button class="badge badge-pill badge-light" onclick="javascript:deleteImageFile();">이 첨부파일 제거</button>
</c:if> 
 -->
<!-- 하단 정보 -->  
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>