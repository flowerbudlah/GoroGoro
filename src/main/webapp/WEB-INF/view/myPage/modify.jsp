<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자에게 신고한 내역 수정</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
$(document).ready(function(){        });

//1. 글 수정 아작스
function modifyProcess(){

	var detail = $("#detail").val();
  
   	if (detail == ""){            
        alert("내용을 입력해주세요.");
        $("#detail").focus();
        return;
    }
   	
    var formData = new FormData($('#modifyReportDTO')[0]);	
    
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
           success  : function(obj) { 
        	 
        		if(obj != null){        
        			var result = obj.result;
        	        
        	        if(result == "success"){                
        				alert("게시글 수정을 성공하였습니다."); 
        				location.href = "reportedPost?reportNo=${reportNo }";
        				//http://localhost:8090/GoroGoroCommunity/myPage/         read?postNo=
        				//http://localhost:8090/GoroGoroCommunity/myPage/reportedPost?reportNo=16
        					
        	        } else {                
        	        	alert("게시글 수정을 실패하였습니다.");    
        	            return;
        	        }
        	    }
      
           },           
           error    : function(xhr, status, error) {}
        });
    }
}

//3. 첨부된 이미지를 삭제(실제는 업데이트기능)하는
function deleteImageFile(){

	
	var formData = new FormData($('#imageFileReportDTO')[0]);	
	
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
						location.href = "modify?reportNo=${reportNo }";
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
<style>
.slider img{display:block; width:100%; max-width:100%; height:300px;} /* 슬라이더 영역 CSS */
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<!-- 그 게시판 윗 부분 그림-->
<article class="slider">
	<img src="/GoroGoroCommunity/image/bluePond01.png">
</article>
<!-- http://localhost:8090                 /GoroGoroCommunity/image/bluePond01.png -->
<!-- 글 수정 -->
<div class="container" style="margin-top:100px; margin-bottom:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7">
			<div class="card shadow-sm">
				<div class="card-body">
					<h4 class="card-title">${reportNo }번 신고내역 수정하기 </h4>
					
					
					<form id="imageFileReportDTO" name="imageFileReportDTO">
						<input type="hidden" id="reportNo" name="reportNo" value="${reportNo }"/>
						<input type="hidden" id="imageFileName" name="imageFileName" value=""/>
					</form>
					
					<c:if test="${ReportDTOfromDB.imageFileName != '' }" > 
						첨부 증거 이미지: ${ReportDTOfromDB.imageFileName }
						<button class="badge badge-pill badge-light" onclick="javascript:deleteImageFile();">이 첨부파일 제거</button>
					</c:if>
					
					 
					<form id="modifyReportDTO" name="modifyReportDTO" enctype="multipart/form-data" style="margin-top:50px; margin-bottom:100px">
						<input type="hidden" name="reportNo" value="${reportNo }" > 
						<div class="form-group">
							<label for="reason">신고사유</label>
								${reason }
								<select name="reason" id="reason" class="form-control">
									<option value="${ReportDTOfromDB.reason }">${ReportDTOfromDB.reason }</option>
									<option value="명예훼손, 모욕, 비방, 허위사실 유포 등">명예훼손, 모욕, 비방, 허위사실 유포 등</option>
		    						<option value="광고, 도배 등">광고, 도배 등</option>
		    						<option value="음란물">음란물</option>
		    						<option value="개인정보침해">개인정보침해</option>
		    						<option value="저작권침해">저작권침해</option>
		    						<option value="기타(해당 게시판의 주제와 맞지않는내용 등)">기타(해당 게시판의 주제와 맞지않는내용 등)</option>
		   						</select>
						</div>
						<div class="form-group">
							<label for="detail">신고내용</label>
							<textarea id="content" name="detail" class="form-control" rows="15" style="resize:none">${ReportDTOfromDB.detail }</textarea>
						</div>

						<label for="imageFile">
							새로운 첨부 이미지:<input type="hidden" value="${ReportDTOfromDB.imageFileName }" id="imageFileName" name="imageFileName "/>
						</label>
						<div class="form-group">
							<input type="file" name="imageFile" id="imageFile" class="form-control" accept="image/*"/>					
						</div>
            </form>
             <!-- 전체수정폼의 끝 -->
            
      		<div class="form-group" >
				<div class="text-right">
					<button class="btn btn-primary" onclick="javascript:modifyProcess();">신고내용 수정완료</button>
					<button class="btn btn-info" onclick="javascript:history.back();">수정취소</button>
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