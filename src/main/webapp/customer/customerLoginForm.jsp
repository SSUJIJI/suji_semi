<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 사용자 인증 분기 
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	// 디버깅	
	System.out.println("=====customerLoginForm.jsp=====");
	
	
	if(loginCustomer != null) {
		response.sendRedirect("/BeeNb/customer/roomList.jsp");
		return;
	}
	String errMsg = request.getParameter("errMsg");
	
	// 디버깅  
	System.out.println("에러 메세지 : "+ errMsg);
	
	
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
		<h1>로그인</h1>
		<%
			// 로그인 실패시 메세지
			if(errMsg != null) {
		%>
			<%= errMsg %>
		<% 		
			}
		%>
		<form action="/BeeNb/customer/customerLoginAction.jsp" method="post">
			<table>
				<tr>
					<td>ID:</td>
					<td><input type="text" name="customerId"></td>
				</tr>
				<tr>
					<td>PW:</td>
					<td><input type="password" name="customerPw"></td>					
				</tr>
			</table>
			<button type="submit">로그인</button>				
		</form>	
		<a href="/BeeNb/customer/customerSignUpForm.jsp">회원가입</a>	
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>				
	</div>

</body>
</html>