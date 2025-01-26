<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 전용 페이지(For the Administrator Only)</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script>  

	// 카테고리 생성
	function makeCategory() {

		var boardCategoryName = $("#boardCategoryName").val()
		
		if (boardCategoryName.length == 0) {
			alert('카테고리 이름을 입력해주세요!');
			return;
			
		} else {
			
			var formData = new FormData($('#newCategoryDTO')[0]);

			$.ajax({
				
				url : "${root}admin/makeCategory",
				data : formData,
				cache : false,
				async : true,
				contentType : false, 
				processData : false,
				type : "POST",
				success :function(obj) {
					
							if (obj != null) {

								var result = obj.result;

								if (result == null) {
									
									alert("해당 카테고리 이름이 이미 존재하기에 사용불가합니다. 다른 이름으로 만들어주세요! ");
									return; 
									
								} else {
									
									alert("새로운 카테고리가 생성되었습니다.");
									location.reload(true);
									
								}
							}

						},
				error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "message:"+ request.responseText + "\n" + "error:"+ error);
						}

				}) //아작스		
		}

	} //  makeCategory()의 끝

	// 카테고리 삭제
	function deleteCategory(){
		
		var boardCategoryNo = $("#boardCategoryNo").val();
		
		var yn = confirm("해당 카테고리를 제거하시겠습니까?");        
	    
		if(yn){
	        
	        $.ajax({    
	         	url      : "${root}admin/deleteCategory",
	            type     : "POST",    
	            data : { boardCategoryNo : boardCategoryNo },
	            dataType : "JSON",
	            success  : function(obj) {
	            	
	            	 if(obj != null){
	            	        var result = obj.result;
	            	        
	            	        if(result == "SUCCESS"){  
	            	            alert("해당 카테고리는 제거되었습니다. ");                
	            	            location.reload(true);
	            	        } else {     
	            	            alert("해당 카테고리가 제거되지 않았습니다. 다시 한번 시도해주세요. ");    
	            	            return;
	            	        }
						}
				},         
	            error    : function(request, status, error) {
	            	alert("You don't have the right to delete The Category");
	            }
				
	         });
	    } //yn 끝        
	} //delete

	// 새로운 게시판 생성
	function makeBoard() {

		var boardName = $("#BoardName").val(); 
		
		if (boardName.length == 0) {
			alert('새롭게 만드실 게시판의 이름을 입력해주세요. ');
			return;
			
		} else {
			
			var formData = new FormData($('#newBoardDTO')[0]);
			alert(formData); 

			$.ajax({
				
				url : "${root}admin/makeBulletinBoard",
				data : formData,
				cache : false,
				async : true,
				contentType : false, 
				processData : false,
				type : "POST",
				success :function(obj) {
					
							if (obj != null) {

								var result = obj.result;

								if (result == null) {
									
									alert("해당 카테고리 안에 이 이름이 이미 존재하기에 사용불가합니다. 다른 이름으로 만들어주세요! ");
									return false; 
									
								} else {
									
									alert("새로운 게시판이 생성되었습니다.");
									location.reload(true);
									
								}
							}

						},
				error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "message:"+ request.responseText + "\n" + "error:"+ error);
						}

				}) //아작스		
			}
	} // makeBulletinBoard
	
	// 게시판 이름 변경
	function changeBoardName() {

		var boardName = $("#boardName").val(); 
		alert(boardName);
		
		var boardNo = $("#boardNo").val(); 
		alert(boardNo);
		
		var boardCategoryNo = $("#boardCategoryNo").val(); 
		alert(boardCategoryNo);
		
		var formData = new FormData(   $('#boardDTOtoChange')[0] );
		
		alert(formData);

		if ( boardName.length == 0) {
			alert('변경하실 게시판 이름을 입력해주세요! ');
			return;

		} else {
			
			$.ajax({
				
				url : "${root}admin/changeBoardName",
				data : formData,
				cache : false,
				async : true,
				contentType : false, 
				processData : false,
				type : "POST",
				success :function(obj) {
					
							if (obj != null) {

								var result = obj.result;

								if (result == null) {
									
									alert("해당 카테고리 안에 그 게시판의 이름은 이미 존재하기에 사용불가합니다. 다른 이름으로 변경해주세요!");
									return false; 
									
								} else {

									alert("게시판의 이름이 변경되었습니다.");
									location.reload(true);
								}
							}

						},
				error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "message:"+ request.responseText + "\n" + "error:"+ error);
						}

				}) //아작스		
			}
	} // makeBulletinBoard

</script>
<style>
body {
	background-image: url(http://localhost:8090/GoroGoroCommunity/image/bottom-bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
	background-attachment: fixed;
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
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
	<!--가운데 그림-->
	<article class="slider">
		<img src="${root }image/jewely.png">
	</article>
	<!--메인화면에 내용 들어가는 부분  -->
	<div style="padding-top: 50px; padding-bottom: 50px;">
		<div class="container">
			<h3><strong>For the Administrator Only</strong></h3>
			<hr>
			<h5><strong>1. 대분류 카테고리</strong></h5>


			<form name="newCategoryDTO" method="post" id="newCategoryDTO" style="padding-top: 10px; padding-bottom: 20px">
				1) 카테고리 생성 <br>
				(1) 생성할 카테고리 이름: 
				<input type="text" id="boardCategoryName" value="" name="boardCategoryName" style="width: 300px;">
				<button type="button" class="btn btn-warning btn-sm" style="text-align: right;" onClick="makeCategory();">카테고리 생성하기</button>
			</form>

			<form name="deleteCategoryDTO" method="post" id="deleteCategoryDTO" style="padding-top: 20px; padding-bottom: 20px;">
				2) 카테고리 삭제<br> 
				(1) 삭제할 카테고리 선택: 
				<select name="boardCategoryNo" id="boardCategoryNo" style="width: 300px;">
					<c:forEach var="CategoryListDTO" items="${CategoryList }">
						<option value="${CategoryListDTO.boardCategoryNo }">${CategoryListDTO.boardCategoryName }</option>
					</c:forEach>
				</select>
				<button type="button" class="btn btn-warning btn-sm" style="text-align: right;" onClick="deleteCategory();">해당 카테고리 삭제하기</button><br> 
				<font color="red">(카테코리를 삭제할 시 해당 카테고리에 속한 게시판과 게시물도 모두 삭제되니 이점 유념하시길 바랍니다.)</font>
			</form>
			<hr>
			<!-- start 게시판 생성부분(같은 그룹안에 같은이름을 갖고있는 게시판은 만들수없다.) -->
			<form name="newBoardDTO" method="post" id="newBoardDTO" style="padding-top: 10px; padding-bottom: 20px;">
				<h5><strong>2. 게시판</strong></h5>
				1) 게시판 생성<br>
				(1) 대분류 카테고리 선택:
				<select name="boardCategoryNo" style="width: 300px;">
					<c:forEach var="CategoryListDTO" items="${CategoryList }">
						<option value="${CategoryListDTO.boardCategoryNo }">${CategoryListDTO.boardCategoryName }</option>
					</c:forEach>
				</select><br>
				(2) 새로운 게시판 이름 설정:
				<input type="text" id="BoardName" name="BoardName" value="" style="width: 300px;">
				<button type="button" class="btn btn-warning btn-sm" style="text-align: right;" onClick="makeBoard();">새로운 게시판 생성하기</button>
				<!-- button Type이 button으로 설정되면, 이 버튼을 작동시켜도 화면이 동기화되지 않는다. 
				반면, Button Type이 submit으로 설정되거나 아예 아무것도 설정되지 않는 경우 이 버튼을 작동시키면 화면이 동기화되여 새로고침이 된다. -->
			</form>
			<!-- end 게시판 생성부분(같은 그룹안에 같은이름을 갖고있는 게시판은 만들수없다.) -->

			<form id="boardDTOtoChange" method="post" style="padding-top: 20px; padding-bottom: 20px;">
				2) 게시판 이름 변경<br>
				(1) 변경대상 게시판:
				<select name="boardNo" id="boardNo" style="width: 300px;">
					<c:forEach var="BoardListDTO" items="${BoardList }">
						<option value="${BoardListDTO.boardNo }">
							${BoardListDTO.boardNo }- ${BoardListDTO.boardName } ${BoardListDTO.boardCategoryNo }
						</option>
				
					</c:forEach>
				</select><br> 
				(2) 변경할 게시판 이름:
				
				<input type="text" id="boardName" value="" name="boardName" style="width: 300px;">
				<button type="button" class="btn btn-warning btn-sm" style="text-align: right;" onClick="changeBoardName();">게시판 이름 변경하기</button>
			</form>
			
			<form action="${root }admin/boardManagement/deleteBoard" style="padding-top: 20px; padding-bottom: 20px;">
				3) 게시판 제거<br>
				(1) 삭제할 게시판 선택: 
				<select name="boardNo" style="width: 300px;">
					<c:forEach var="BoardListDTO" items="${BoardList }">
						<option value="${BoardListDTO.boardNo }">${BoardListDTO.boardNo }-${BoardListDTO.boardName }</option>
					</c:forEach>
				</select>
				<button type="submit" class="btn btn-warning btn-sm" style="text-align: right;">해당 게시판 삭제하기</button>
				<br>
				<font color="red">(해당 게시판을 삭제할 시 해당 게시판에 속한 게시물도 모두 삭제되니 이점 유념하시길 바랍니다.)</font>
			</form>

			<form action="${root }admin/boardManagement/changeCategory" style="padding-top: 20px; padding-bottom: 20px;">
				4) 게시판의 카테고리 변경<br>
				(1) 변경할 게시판 선택: 
				<select name="boardNo" style="width: 300px;">
					<c:forEach var="BoardListDTO" items="${BoardList }">
						<option value="${BoardListDTO.boardNo }">${BoardListDTO.boardNo }-${BoardListDTO.boardName }</option>
					</c:forEach>
				</select><br>
				(2) 변경하고자 할 카테고리 선택
				<select name="boardCategoryNo"style="width: 300px;">
					<c:forEach var="CategoryListDTO" items="${CategoryList }">
						<option value="${CategoryListDTO.boardCategoryNo }">${CategoryListDTO.boardCategoryName }</option>
					</c:forEach>
				</select>
				<button type="submit" class="btn btn-warning btn-sm" style="text-align: right;">해당 게시판의 카테고리 변경하기</button>
				<br>
			</form>
		</div>
	</div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>