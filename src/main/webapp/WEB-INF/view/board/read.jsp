<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시글 읽기</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<script type="text/javascript">    

function goMain(){
	var boardNo = $("#boardNo").val();
	location.href = "main?boardNo=${readPostDTO.boardNo}";
	//http://localhost:8090/GoroGoroCommunity/board/      main?boardNo=4
}


//2. 1) 게시글 삭제
function deletePost(){
	var postNo = $("#postNo").val();
	
	var yn = confirm("게시글을 삭제하시겠습니까?");        
    if(yn){
        
        $.ajax({    
         	url      : "deletePost", // "deletePost"성공
            type     : "POST",    
            data : { postNo : postNo },
            dataType : "JSON",
            success  : function(obj) { 
            	
            	 if(obj != null){        
            	        
            	        var result = obj.result;
            	        
            	        if(result == "SUCCESS"){  
            	            alert("게시글 삭제를 성공하였습니다.");                
            	            goMain(); 
            	        } else {     
            	            alert("게시글 삭제를 실패하였습니다.");    
            	            return;
            	        }
            	    }
            },           
            error    : function(request, status, error) {
            	alert("해당글을 삭제할수 있는 권한이 없습니다. ");	
            }
            
         });
    } //yn 끝        
} //deletePost



//4. 신고하기
function report(){
	location.href = "report";
}

//5. 좋아요. 공감버튼
function like(){
	var postNo = $("#postNo").val();
	var yn = confirm("이 글에 공감하시나요?");        
	
    if(yn){
        
        $.ajax({    
         	url      : "like", 
            type     : "POST",    
            data : { postNo : postNo },
            dataType : "JSON",
            success  : function(obj) {
            	
            	if(obj != null){        
            		
            		var result = obj.result;
            		
            		if(result == "SUCCESS"){
            			alert("공감하셨습니다.");
            		
            			return;
            		} else {     
            			alert("공감하는것에 문제가 생김");    
            			return;
            		}
            	}
            },           
            error    : function(request, status, error) {
            	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);	
            }
         });
    } //yn 끝  
}//Like의 끝

//6. 댓글 작성
function writeReplyProcess(){
	
	var replyContent = $("#replyContent").val(); //내용
	if (replyContent == ""){			
		alert("내용을 입력해주세요.");
		$("#replyContent").focus();
		return;
	}
		
	var yn = confirm("댓글을 등록하시겠습니까?");		
	
	if(yn){
			
		 $.ajax({   
                url      : "writeReplyProcess",
                data     : $("#writeReplyDTO").serialize(), // controller 단 참조할 것!
                dataType : "JSON",
                cache    : false,
                async    : true,
                type     : "POST",    
                success  : function(obj) { writeReplyCallback(obj);},           
                error: function(request,status,error){
                	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
			}) //아작스 
		};	//yn의 끝
	} //writeReplyProcess

//7. 댓글 작성 콜백 함수
function writeReplyCallback(obj){ 
	
	if(obj != null){		
	var result = obj.result;
			
	if(result == "SUCCESS"){				
		alert("댓글 등록을 성공하였습니다.");				
		location.href = "read?postNo=${postNo}";  
		return;
	} else {				
		alert("댓글 등록을 실패하였습니다.");	
		return;
	}
}
}
	
//8. 댓글 삭제 콜백 함수
function removeReply(){
	var replyNo = $("#replyNo").val(); //리플 번호
	
	var yn = confirm("댓글을 삭제하시겠습니까?");		
		
	if(yn){
		
		$.ajax({   
			url      : "removeReply",
			data     : { replyNo : replyNo },
			dataType : "JSON",
			cache    : false,
			async    : true,
			type     : "POST",    
			success  : 
				function(obj) { 
					if(obj != null){        
					
					var result = obj.result;
					
					if(result == "SUCCESS"){  
						alert("댓글 삭제를 성공하였습니다.");   
						location.href = "read?postNo=${postNo}";  
					} else {     
						alert("댓글 삭제를 실패하였습니다.");    
						return;
					}
				}
			},           
			error	 : function(request,status,error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}
				}) //아작스 
			};	//yn의 끝
		}

</script>
<style>

.reply{ font-size: 12px; }
.replyWriter{ text-align:left; position: absolute; }
.replyRegDate{ text-align:right;  position: relative; }
.slider img{display:block; width:100%; max-width:100%; height:300px;} /* 슬라이더 영역 CSS */
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<!-- 그 게시판 윗 부분 그림-->  
<article class="slider">
	<img src="/GoroGoroCommunity/image/convenientStore.png"> 
	<!-- http://localhost:8090/             GoroGoroCommunity/image/convenientStore.png -->
	<!--  root = http://localhost:8090    /GoroGoroCommunity/image/convenientStore.png -->
</article>
<!-- 본문 -->
<div class="container" style="margin-top:100px; margin-bottom:100px;">
	<div class="row">
	<div class="col-sm-3"></div>
	<div class="col-sm-7">
	<div class="card shadow-none">
	<div class="card-body">
	<h4 class="card-title"></h4>
		<div class="form-group">
			<label for="postNo">글번호</label>
			<input type="text" id="postNo" name="postNo" class="form-control" value="${readPostDTO.postNo}" disabled="disabled"/>
			<input type="hidden" id="boardNo" name="boardNo" value="${readPostDTO.boardNo}"/> 
		</div>
		<div class="form-group">
			<label for="writer">작성자</label>
			<c:choose>
				<c:when test="${readPostDTO.boardNo == 2 }">
				 	<input type="text" id="writer" name="writer" class="form-control" value="익명" disabled="disabled"/> 
				 </c:when>
				<c:otherwise>
					<input type="text" id="writer" name="writer" class="form-control" value="${readPostDTO.writer}" disabled="disabled"/>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="form-group">
			<label for="regDate">최초 작성일</label>
			<input type="text" id="regDate" name="regDate" class="form-control" value="<fmt:formatDate value="${readPostDTO.regDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" disabled="disabled"/>
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<input type="text" id="title" name="title" class="form-control" value="${readPostDTO.title}" disabled="disabled"/>
		</div>
	
		<!-- 첨부이미지와 내용 start -->
		<div class="form-group">
		<!-- 첨부이미지 -->
		<c:if test="${readPostDTO.imageFileName != ''}">
          	<div class="form-group">
          		<label for="fileName">첨부 이미지</label>
          		<img src="/GoroGoroCommunity/upload/${readPostDTO.imageFileName}" width=100%; height=250px;/>       
          	</div>
		</c:if>
			<!-- 내용 -->
			<label for="content">내용</label>
			<textarea id="content" name="content" class="form-control" rows="15" style="resize:none" disabled="disabled">${readPostDTO.content}</textarea>
		</div>
		<!-- 첨부이미지와 내용 end -->
		<div class="form-group">
			<label for="board_content">댓글 [${readPostDTO.replyCount }] </label>
		</div>

	<!--댓글 목록불러오기 -->
	<div class="reply">
		<ul>
		<c:forEach var="reply" items="${replyList}" >
			<li>
				<div class="replyWiter">작성자: ${reply.replyWriter}
				&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
				댓글작성일시: <fmt:formatDate value="${reply.replyRegDate}" pattern="yyyy-MM-dd hh:mm:ss" />
				<c:choose>
					<c:when test="${signInMemberDTO.nick == reply.replyWriter || signInMemberDTO.memberNo == 1 || signInMemberDTO.nick == readPostDTO.writer  }">
						<a class="badge badge-pill badge-light" style="font-size:13px;" onclick="javascript:removeReply();" >
							<input type="hidden" id="replyNo" name="replyNo" value="${reply.replyNo}"/>X <!-- 댓글삭제버튼 -->
						</a>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
				
				</div>
				<textarea id="replyContent" name="replyContent" class="form-control" rows="3" style="resize:none" disabled="disabled">${reply.replyContent }</textarea>
			</li><br>
		</c:forEach>
	</ul>
</div>
<!-- 댓글 작성 부분(로그인을 한 회원만 보이게) -->
<c:choose>
	<c:when test="${signInMemberDTO.signIn == true }">
	<form id="writeReplyDTO" name="writeReplyDTO">
		<input type="hidden" name="postNo" id="postNo" value="${postNo }">
		<!-- 댓글 작성 폼 -->	
		<div class="reply">
			<input type="hidden" id="replyWriter" name="replyWriter" value="${signInMemberDTO.nick }"/>
			<textarea id="replyContent" name="replyContent" class="form-control" rows="3" style="resize:none" placeholder="댓글을 입력해주세요! 고운말을 써주세요!"></textarea>
			<div class="text-right">
				<button type="button" class="btn btn-info btn-sm" onclick="javascript:writeReplyProcess();">작성완료</button>
			</div>
		</div>	
	</form>
	</c:when>
	<c:otherwise></c:otherwise>
</c:choose>
<!-- 댓글 작성 부분(로그인을 한 회원만 보이게) -->
		</div><!-- <div class="card-body"> -->
		<!-- 공감(좋아요)버튼 -->
	  	<div class="form-group">
			<center>
				<a href="read?postNo=${postNo}" onclick="javascript:like();">
					<input type="hidden" id="postNo" name="postNo"	value="${postNo}"/> <!-- 게시글 번호 -->
					<img src="/GoroGoroCommunity/image/sameThoughtButton.gif">
				</a>
				<br>
				<strong>★${readPostDTO.sameThinking }★</strong>
				
			</center>
		</div>
		<br><br>
	
	<div class="form-group">
		<div class="text-right">
			<button type="button" class="btn btn-primary btn-sm" onclick="javascript:goMain();">목록으로</button>
			<a href="modify?postNo=${postNo }" class="btn btn-info btn-sm">수정하기</a>
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:deletePost();">삭제하기</button>
			
			
			<c:choose>
				<%--로그인을 한 회원에게만 보이는 게시글 신고버튼--%> 
				<c:when test="${signInMemberDTO.signIn == true }">
					<a href="report?postNo=${postNo }" class="btn btn-danger btn-sm">게시글 신고</a>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>&emsp;&emsp; 	
			
			
		</div>
	</div>
          
   </div><!-- <div class="card-body"> -->
	</div><!-- sm7 -->
	</div><!-- row -->
	<div class="col-sm-3"></div>
</div>
<!-- 하단 정보 -->  
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>