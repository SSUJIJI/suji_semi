<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	System.out.println("=====customerLoginForm.jsp=====");

	// 사용자 인증 분기 
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
			
	if(loginCustomer != null) {
		response.sendRedirect("/BeeNb/customer/roomList.jsp");
		return;
	}
	String errMsg = request.getParameter("errMsg");
	String logoutMsg = request.getParameter("logoutMsg");
	// 디버깅  
	System.out.println("에러 메세지 : "+ errMsg);
	
	
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
		<h1>로그인</h1>
		<%
			// 로그인 실패시 메세지
			if(errMsg != null) {
		%>
			 <div class="alert alert-danger" role="alert">
				<%= errMsg %>
			</div>
		<% 	
			// 로그아웃 메세지 
			} else if (logoutMsg != null) {
		%>		
			<div class="alert alert-success" role="alert">
				<%= logoutMsg %>
			</div>
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
			<a class="text-decoration-none" href="/BeeNb/emp/empLoginForm.jsp">관리자 로그인</a>
		</form>	
		<a class="text-decoration-none" href="/BeeNb/customer/customerSignUpForm.jsp">회원가입</a>
		<a class="text-decoration-none" href="/BeeNb/customer/customerFindIdForm.jsp">ID찾기</a>
		<a class="text-decoration-none" href="/BeeNb/customer/customerAuthForm.jsp">비밀번호 재설정</a>
		
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>				
	</div>

</body>
</html>