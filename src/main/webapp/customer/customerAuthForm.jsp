<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====customerAuthForm.jsp=====");
	String errMsg = request.getParameter("errMsg");
	System.out.println("errMsg : "+ errMsg);
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
	<!-- 고객 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		<h1>본인인증</h1>
			<form method = "post" action = "/BeeNb/customer/customerAuthAction.jsp">
				<table>
					<tr>
						<th>아이디: </th>
						<td><input type="text" name="customerId"></td>
					</tr>
					<tr>
						<th>이름: </th>
						<td><input type="text" name="customerName"></td>
					</tr>
					<tr>
						<th>전화번호: </th>
						<td><input type="text" name="customerPhone" placeholder="번호만 입력하세요."></td>
					</tr>
				</table>
				<button type="submit">확인하기</button>
			</form>
	</div>
</body>
</html>