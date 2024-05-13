<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp" %>
<%
	System.out.println("========== empRegistForm.jsp ==========");
	// err메시지 요청 값
	String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<!-- 관리자 등록 폼 -->
		<h1>관리자 등록</h1>
		<form action="/BeeNb/emp/empRegistAction.jsp" method="post">
			<div>
				<label>이름</label>
				<input type="text" name="empName" required="required">
				<br>
			</div>
			
			<div>
				<label>휴대전화</label>
				<input type="tel" name="empPhone" required="required" placeholder="예시) 010-1234-5678">
				<!-- errMsg 표시 -->
				<%
					if(errMsg != null) {
				%>
						<%= errMsg%>
				<%
					}
				%>
				<br>
			</div>
			
			<div>
				<label>생년월일</label>
				<input type="text" name="empBirth" required="required" minlength = "8" maxlength="8" placeholder="예시) 19990101">
				<br>
			</div>
			
			<button type="submit">등록하기</button>
		</form>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>