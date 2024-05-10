<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String errMsg = request.getParameter("errMsg");
	
	String customerId = request.getParameter("customerId");
	if(customerId == null){
		customerId = "";
	}
	String check = request.getParameter("check");
	if(check == null){
		check = "";
	}
	String msg = "";
	if(check.equals("T")){
		msg = "가입이 가능한 아이디입니다.";
	} else if(check.equals("F")){
		msg = "이미 존재하는 아이디입니다.";
	}
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
		<h1>회원가입</h1>
		<!-- 아이디 중복 확인 -->
		<form method="post" action="/BeeNb/customer/customerCheckIdAction.jsp">
			<table>
				<tr>
					<td>입력한 아이디 : <%=customerId %></td>
					<td><%=msg %></td>
				</tr>
				<tr>
					<td><input type = "text" name = "customerId" required="required"></td>
					<td><button type = "submit">중복확인</button></td>
				</tr>
			</table>
		</form>
		<form method = "post" action = "/BeeNb/customer/customerSignUpAction.jsp">

			<table>
				<tr>
					<th>아이디 : </th>
					<%
						if(check.equals("T")){ // check가 T면 아이디를 readonly로 받기 
					%>
						<td><input type = "text" name="customerId" value = <%=customerId %> readonly="readonly" ></td>
					<%		
						}else{ // check가 F면 아이디가 입력되지 않게
					%>
						<td><input type = "text" name="customerId" disabled="disabled"></td>
					<%		
						}
					%>
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
					<td><input type="tel" name="customerPhone" placeholder="123-456-7890"></td>
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