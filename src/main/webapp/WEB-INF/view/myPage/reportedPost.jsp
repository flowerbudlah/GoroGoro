<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>신고내용 읽기</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script>
	function writeAdminReplyProcess() {

		var replyContent = $("#replyContent").val();
		
		// 입력값이 없으면, 
		if (!replyContent.trim()) {
			alert("내용을 입력해주세요.");
			$("#replyContent").focus();
			return;
		}

		var yn = confirm("댓글을 등록하시겠습니까?");

		if (yn) {

			$.ajax({
				url : "${root}admin/writeAdminReplyProcess",
				data : $("#writeAdminReplyDTO").serialize(), // controller 단 참조할 것!
				dataType : "JSON",
				cache : false,
				async : true,
				type : "POST",
				success : function(obj) {

					if (obj != null) {
						var result = obj.result;

						if (result == "SUCCESS") {
							alert("댓글 등록을 성공하였습니다.");
							location.reload();
							return;
						} else {
							alert("댓글 등록을 실패하였습니다.");
							return;
						}
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			}) // 아작스 
		} // yn의 끝
	}

	// 댓글 삭제 콜백 함수
	function removeAdminReply() {

		// 리플 번호
		var replyNo = $("#replyNo").val(); 
		var yn = confirm("관리자의 답변을 삭제하시겠습니까?");

		if (yn) {
			$.ajax({
				url : "${root}admin/removeAdminReply",
				data : {replyNo : replyNo},
				dataType : "JSON",
				cache : false,
				async : true,
				type : "POST",
				success : function(obj) {
					if (obj != null) {
						var result = obj.result;

						if (result == "SUCCESS") {
							alert("댓글 삭제를 성공하였습니다.");
							history.back();
							location.reload();
							return;
						} else {
							alert("댓글 삭제를 실패하였습니다.");
							return;
						}
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"+ request.responseText + "\n" + "error:" + error);
				}
			}) //아작스 
		}// yn의 끝
	}

	// 2. 1) 게시글 삭제
	function deleteReportDTO() {

		var reportNo = $("#reportNo").val();

		var yn = confirm("신고내용을 철회하시겠습니까? ");

		if (yn) {
			$.ajax({
				url : "deleteReportDTO",
				type : "POST",
				data : {reportNo : reportNo},
				dataType : "JSON",
				success : function(obj) {
					if (obj != null) {
						
						var result = obj.result;
						
						if (result == "SUCCESS") {
							alert("신고 철회 완료하였습니다. ");
							goMain();
						} else {
							alert("신고철회 실패하였습니다. ");
							return;
						}
					}
				},
				error : function(request, status, error) {
					alert("해당 신고사항을 철회할 수 있는 사람은 신고자뿐입니다. 관리자님은 철회권한이 없습니다.  ");
				}
			})// ajax의 끝
		} // yn 끝        
	}
	
	// 관리자만 할 수 있는 신고내용 승낙
	function accept() {
		
		var formData = new FormData($('#FlagDTO')[0]);	
		
		var yn = confirm("관리자님께서는 이 신고내용을 승낙하시겠나요? 승낙하신다면, 신고대상이 된 게시글은 유효신고처리 되어 작성자는 경고를 받게됩니다.");
		
		if (yn) {
			
			 $.ajax({   
	                url      : "increaseFlag", 
	                enctype  : "multipart/form-data",
	                data     : formData,
	                cache    : false,
	                async    : true,
	                contentType: false, //이것을 붙이고 나서 업로드가 된것이다. 
	                processData: false, // 이것을 붙이고 업로드가 되었다. 
	                type     : "POST",    
	                success  : 
	                	function(obj) { 
	                	
	                		if(obj != null){		
		            			
		            			var result = obj.result;
		            		    			
		            			if(result == "success"){				
		            				alert("해당 글은 플레그증가");				
		            				return;		 
		            			} else if (result == "fail"){				
		            				alert("실패");	
		            				return;
		            			} else {
		            				alert("해당 신고글은 이미 경고처리되었습니다.");	
		            				return;
		            			}
		            		}
	                },           
	                error: function(request,status,error){
	                	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	                }
				}) //아작스 
			
		}
	}
</script>
<style>
.reply {
	font-size: 12px;
}
.replyWriter {
	text-align: left;
	position: absolute;
}
.replyRegDate {
	text-align: right;
	position: relative;
}
/* 슬라이더 영역 CSS */
.slider img {
	display: block;
	width: 100%;
	max-width: 100%;
	height: 300px;
}
</style>
</head>
<body>
<!-- 상단 메뉴 부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<!-- 그 게시판 윗 부분 그림-->
<article class="slider"><img src="${root }image/candy03.jpg"></article>
	<!-- 본문 -->
	<div class="container" style="margin-top: 100px; margin-bottom: 100px;">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-7">
				<div class="card shadow-none">
					<div class="card-body">
						<h4 class="card-title">${readReportDTO.postNo}번게시글 신고내역</h4>
						<a href='${root }board/read?postNo=${readReportDTO.postNo}' style="color: black">신고된 게시글 상세 보기</a>
						<div>
							<label for="reportNo">신고번호</label>
							<input type="text" id="reportNo" name="reportNo" class="form-control" value="${readReportDTO.reportNo}" disabled />
						</div>
						<div class="form-group">
							<label for="writer">신고자</label>
							<input type="text" id="reporter" name="reporter" class="form-control" value="${readReportDTO.reporter}" disabled="disabled" />
						</div>
						<div class="form-group">
							<label for="reportDate">신고일자</label>
							<input type="text" id="reportDate" name="reportDate" class="form-control" value="<fmt:formatDate value="${readReportDTO.reportDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" disabled="disabled" />
						</div>
						<div class="form-group">
							<label for="title">신고사유</label>
							<input type="text" id="reason" name="reason" class="form-control" value="${readReportDTO.reason}" disabled="disabled" />
						</div>
						<div class="form-group">
							<label for="detail">신고내용</label>
							<textarea id="detail" name="detail" class="form-control" rows="10" style="resize: none" disabled="disabled">${readReportDTO.detail}</textarea>
						</div>
						<div class="form-group">
							<c:if test="${readReportDTO.imageFileName != ''}">
								<label for="fileName">첨부 이미지 파일</label>
								<a href="http://localhost:8090/GoroGoroCommunity/upload/${readReportDTO.imageFileName}">${readReportDTO.imageFileName}</a>
							</c:if>
						</div>
						<!-- 첨부이미지와 내용 end -->
						<div class="form-group"></div>
						<!--댓글 목록불러오기 -->
						<div class="reply" style="margin-top: 15px; margin-bottom: 10px;">
							<ul>
								<c:forEach var="reply" items="${adminReplyList}">
									<li>
										<div class="replyWiter">
										작성자: ${reply.replyWriter}&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
										댓글작성일시:<fmt:formatDate value="${reply.replyRegDate}" pattern="yyyy-MM-dd hh:mm:ss" />
										<c:choose>
											<c:when test="${signInMemberDTO.nick == reply.replyWriter || signInMemberDTO.memberNo == 1 || signInMemberDTO.nick == readPostDTO.writer }">
											<!-- 댓글 삭제버튼 -->
											<a class="badge badge-pill badge-light" style="font-size: 13px;" onclick="javascript:removeAdminReply();">
												<input type="hidden" id="replyNo" name="replyNo" value="${reply.replyNo}" />X
											</a>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
										</div>
										<textarea id="replyContent" name="replyContent" class="form-control" rows="3" style="resize: none" disabled="disabled">${reply.replyContent }</textarea>
									</li>
								</c:forEach>
							</ul>
						</div>
						<!-- 댓글 작성 부분(관리자만 보이게) -->
						<c:choose>
							<c:when test="${signInMemberDTO.memberNo == 1 }">
								<form id="writeAdminReplyDTO" name="writeAdminReplyDTO" style="margin-top: 40px; margin-bottom: 40px;">
									<!-- 댓글 작성 폼 -->
									<div class="reply">
										<input type="hidden" name="reportNo" id="reportNo" value="${readReportDTO.reportNo}">
										<input type="hidden" id="replyWriter" name="replyWriter" value="${signInMemberDTO.nick }"/>
										<textarea id="replyContent" name="replyContent" class="form-control" rows="3" style="resize: none" placeholder="관리자님께서는 위 신고사항에 대해 답변을 남겨주세요."></textarea>
										<div class="text-right">
											<button type="button" class="btn btn-info btn-sm" onclick="javascript:writeAdminReplyProcess();">작성완료</button>
										</div>
									</div>
								</form>
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>

					</div>
					<!-- <div class="card-body"> -->
					<div class="form-group">
						<div class="text-right">
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:history.back();">이전으로</button>
							<c:choose>
							<%--신고철회, 신고내용수정하기 신고를 한 사람만 볼수있게 한다. --%>
								<c:when test="${readReportDTO.reporter == signInMemberDTO.nick }">
									<a href="modify?reportNo=${reportNo }" class="btn btn-info btn-sm">신고내용 수정하기</a>
									<button class="btn btn-secondary btn-sm" onclick="javascript:deleteReportDTO();">신고철회</button>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
							<c:choose>
							<%--신고승낙버튼은 관리자만 볼수있게 한다.--%>	
								<c:when test="${signInMemberDTO.memberNo == 1}">
								<button type="button" class="btn btn-warning btn-sm" onclick="javascript:accept();">신고승낙</button>&emsp;
								<form id="FlagDTO" name="FlagDTO">
									<input type="hidden" name="postNo" id="postNo" value="${readReportDTO.postNo}">
									<input type="hidden" id="reportNo" name="reportNo" value="${readReportDTO.reportNo}" />
									<input type="hidden" id="reporter" name="reporter" value="${readReportDTO.reporter}" />
								</form>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
<!-- 하단 정보 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>