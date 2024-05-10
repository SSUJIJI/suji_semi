<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
</head>
<body>
	<div class="container">
		<form method = "post" action = "/BeeNb/customer/customerSignUpAction.jsp">
			<h1>회원가입</h1>
			<table>
	
				<tr>
					<th>아이디 : </th>
					<td><input type = "text" name="customerId"></td>
				</tr>
				<tr>
					<th>비밀번호 : </th>
					<td><input type = "password" name="customerPw"></td>
				</tr>
				<tr>
					<th>이메일 : </th>
					<td><input type = "email" name="customerEmail"></td>
				</tr>
				<tr>
					<th>이름 : </th>
					<td><input type = "text" name="customerName"></td>
				</tr>
				<tr>
					<th>생년월일 : </th>
					<td><input type = "date" name="customerBirth"></td>
				</tr>
				<tr>
					<th>전화번호 : </th>
					<td><input type = "tel" name="customerPhone"></td>
				</tr>
				<tr>
					<th>성별 : </th>
					<td><input type = "radio" name="customerGender" value = "F">여자</td>
					<td><input type = "radio" name="customerGender" value = "M">남자</td>
				</tr>
				<tr>
					<td><button type="submit">가입하기</button></td>
				</tr>
	
			</table>
		</form>
		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>