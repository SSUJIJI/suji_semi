<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
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
				<td><input type="text" name="customerPhone" placeholder="123-456-789"></td>
			</tr>
		</table>
		<button type="submit">확인하기</button>
	</form>
</body>
</html>