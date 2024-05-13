<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionNotNull.jsp" %>
<%
	System.out.println("=====customerCheckPwForm.jsp=====");
	// 로그인 인증 
	String customerId = (String)(loginCustomer.get("customerId"));
	//디버깅
	System.out.println("고객ID :" + customerId);
	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<div class="container">
		<!-- 고객 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		
	</div>	
</body>
</html>