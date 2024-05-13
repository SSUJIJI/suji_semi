<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====customerFindIdForm.jsp=====");
	
	
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
		<h1>ID찾기</h1>
		<form action="/BeeNb/customer/customerFindIdAction.jsp" method="post">
			<table>
				<tr>
					<td>이름: </td>
					<td><input type="text" name="customerName"></td>
				</tr>
				<tr>
					<td>이메일: </td>
					<td><input type="email" name="customerEmail"></td>
				</tr>
			</table>
			<button type="submit">ID찾기</button>
		</form>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
	
</body>
</html>