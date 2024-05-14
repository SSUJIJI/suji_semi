<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<% 
	System.out.println("=====addRoomForm.jsp=====");
	String url = "/BeeNb/customer/addRoomAction.jsp";
%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<title>관리자 로그인</title>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		<div class="row mt-5" style="height: 65vh;">
		<div class="col"></div>
		<div class="col-8">
			<div class="row mt-3">
				<h1>숙소 등록하기</h1>
			</div>
			<form action="<%=url %>" method="post">
				<div class="row mt-3">
					<div class="col">
						<label for="roomName">숙소명</label>
					</div>
					<div class="col-10">
						<input type="text" name="roomName" id="roomName" required="required">
					</div>
				</div>
				<div class="row mt-3">
					<div class="col">
						<label for="roomCategory">숙소 유형 분류</label>
					</div>
 					<div class="col-10">
						<select name="roomCategory" id="roomCategory">
							<option value="0">0</option>
						</select>
					</div>
				</div>
				<div class="row mt-3">
					<div class="col">
						<label>숙소 테마</label>
					</div>			
					<div class="col-10">
						<div class="row">
							<div class="col-2">
								<label for="roomTheme1">친근한</label>
							</div>
							<div class="col">
								<input type="radio" name="roomTheme" id="roomTheme1">
							</div>
							<div class="col">
								<label for="roomTheme2">자연친화적인</label>
							</div>
							<div class="col">
								<input type="radio" name="roomTheme" id="roomTheme2">
							</div>
						</div>
					</div>
					
				</div>	
				<div class="row mt-3">
					<div class="col">
						<label>숙소 주소</label>
					</div>			
					<div class="col">
						<input type="text" name="address" id="address">
					</div>
				</div>
				<div class="row mt-3">
					<div class="col">
						<label for="roomContent">숙소 설명</label>
					</div>			
					<div class="col">
						<textarea name="roomContent" id="roomContent" rows="10" cols="50"></textarea>
					</div>
				</div>
				<div class="row mt-3">
					<div class="col">
						<label for="operationStart">숙소 운용 기간</label>
					</div>
					<div class="col">
						<input type="date" id="operationStart" name="operationStart">
						<span>~</span>
						<input type="date" id="operationEnd" name="operationEnd">
					</div>
				</div>
				<div class="row mt-3">
					<div class="col">
						<label for="maxPeople">최대 수용 인원</label>						
					</div>
					<div class="col">
						<input type="number" name="maxPeople" id="maxPeople">
					</div>
				</div>			
			</form>
		</div>
		<div class="col"></div>
		</div>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
</body>
</html>