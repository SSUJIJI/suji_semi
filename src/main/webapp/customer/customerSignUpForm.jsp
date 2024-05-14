<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 회원가입 실패시 오류 메시지
	String errMsg = request.getParameter("errMsg");

	// 전화번호 입력 오류 메시지
	String errMsgP = request.getParameter("errMsgP");
	if(errMsgP == null){
		errMsgP = "";
	}
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
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
	<!-- 고객 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		<h1>회원가입</h1>
		<!-- 아이디 중복 확인 -->
		<form method="post" action="/BeeNb/customer/customerCheckIdAction.jsp">
			<table>
				<tr>
					<th>아이디 : </th>
					<td><input type = "text" name = "customerId" required="required" value="<%=customerId %>"></td>
					<td><button type = "submit">중복확인</button></td>
				</tr>
				<tr>
					<td colspan="3"><%=msg %></td>
				</tr>
			</table>
		</form>
		<form method = "post" action = "/BeeNb/customer/customerSignUpAction.jsp">
			<table>
				<tr>
					<%
						if(check.equals("T")){ // check가 T면 아이디를 readonly로 받기 
					%>
							<td><input type = "text" name="customerId" value = <%=customerId %> readonly="readonly" hidden = "hidden"></td>
					<%		
						}else{ // check가 F면 아이디가 입력되지 않게
					%>
							<td><input type = "text" name="customerId" hidden = "hidden"></td>
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
					<td><input type="tel" name="customerPhone" placeholder="123-456-7890">
					<%
						if(errMsgP != null) {
					%>
							<%= errMsgP%>
					<%
						}
					%>
					</td>
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