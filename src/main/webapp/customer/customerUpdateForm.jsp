<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%
	System.out.println("=====customerUpdateForm.jsp=====");
	//로그인 인증 
	String customerId = (String)(loginCustomer.get("customerId"));
	String customerName = (String)(loginCustomer.get("customerName"));
	String customerPw = request.getParameter("customerPw");
	String customerPhone = (String)(loginCustomer.get("customerPhone"));
	String customerEmail =(String)(loginCustomer.get("customerEmail"));
	String errMsg = request.getParameter("errMsg");
	
	
	// 디버깅코드
	System.out.println("customerId :"+ customerId);
	System.out.println("customerName :"+ customerName);
	System.out.println("customerPw :"+ customerPw);
	System.out.println("customerPhone :"+ customerPhone);
	System.out.println("customerEmail :"+ customerEmail);
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
		<h1>개인정보 수정</h1>
		<form method = "post" action = "/BeeNb/customer/customerUpdateAction.jsp">
			<table>
				<tr>
					<td>아이디 :</td>
					<td><input type="hidden" name="customerId" value="<%=customerId%>"><%=customerId%></td>
				</tr>
				<tr>
					<td>이메일 :</td>
					<td><input type="email" name="customerEmail" value="<%=customerEmail%>"></td>
				</tr>
				<tr>
					<td>이름 :</td>
					<td><input type="hidden" name="customerName" value="<%=customerName%>"><%=customerName%></td>
				</tr>
				<tr>
					<td>전화번호 :</td>
					<td><input type="text" name="customerPhone" value="<%=customerPhone%>"></td>
				</tr>
				<tr>
					<td>이전 비밀번호 :</td>
					<td><input type="password" name="oldCustomerPw"></td>
				</tr>
				<tr>
					<td>새 비밀번호 :</td>
					<td><input type="password" name="newCustomerPw"></td>
				</tr>
				<tr>
					<td>새 비밀번호 확인 :</td>
					<td><input type="password" name="newCustomerPwCheck"></td>
				</tr>
			</table>
			<button type="submit">수정하기</button>
		</form>	
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</div>
	
</body>
</html>