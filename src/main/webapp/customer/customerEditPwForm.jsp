<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====customerEditPwForm.jsp=====");
	String customerId = request.getParameter("customerId");
	String errMsg = request.getParameter("errMsg");
	
	// 디버깅 코드
	System.out.println("customerId :" + customerId);
	System.out.println("errMsg :" + errMsg);
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
		<h1> 비밀번호 변경 </h1>
			<form method = "post" action = "/BeeNb/customer/customerEditPwAction.jsp">
				<table>
					<tr>
						<td>아이디: </td>
						<td><input type="text" name="customerId" hidden="hidden" value = "<%=customerId%>"><%=customerId %></td>
					</tr>
					<tr>
						<td>새 비밀번호: </td>
						<td><input type="password" name="newCustomerPw"></td>
					</tr>
					<tr>
						<td>확인 비밀번호: </td>
						<td><input type="password" name="newCustomerPwCheck"></td>
					</tr>
				</table>
				<button type="submit">변경하기</button>
			</form>
	</div>
</body>
</html>