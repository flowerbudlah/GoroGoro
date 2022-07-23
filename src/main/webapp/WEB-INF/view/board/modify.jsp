<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url var="root" value="${pageContext.request.contextPath }/" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 수정</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- 게시글 번호 -->
<% String postNo = request.getParameter("postNo");%> 
<c:set var="postNo" value="<%=postNo %>"/> 


<script type="text/javascript">
	
	$(document).ready(function(){        
	
	});
	
	
    
	/*수정 Ajax*/
	function modifyProcess(){

        var title = $("#title").val();
        var content = $("#content").val();
        var postNo = $("#postNo").val();    
        
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
               data     : $("#boardForm").serialize(),
               dataType : "JSON",
               cache    : false,
               async    : true,
               type     : "POST",    
               success  : function(obj) {
            	   updateBoardCallback(obj); 
				},           
               error    : function(xhr, status, error) {}
    
            });
        }
    }
    
	/** 게시판 - 수정 콜백 함수 */
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
					<h4 class="card-title">${postNo } </h4>
					
					<form id="boardForm" name="boardForm">
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
						
						
						<div class="form-group">
							<label for="board_file">첨부 이미지</label>
							<img src="${root }image/logo.png" width="100%"/>	
							<input type="file" name="board_file" id="board_file" class="form-control" accept="image/*"/>					
						</div>
			
            </form>
            
      		<div class="form-group">
				<div class="text-right">
				<button type="button" class="btn btn-primary btn-sm" onclick="javascript:modifyProcess();">수정완료</button>
					<button type="button" class="btn btn-info btn-sm" onclick="javascript:history.back();">수정취소</button>
					
				</div>
			</div>
            
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