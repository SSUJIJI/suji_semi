<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*" %>

<%
	System.out.println("=====customerResultIdOne.jsp=====");
	String result = request.getParameter("result");
	
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
		<h1>ID확인</h1>
			<table>
				<tr>
					<td>아이디 : </td>
					<td><%=result %></td>
				</tr>				
			</table>
			<a class="text-decoration-none" href="/BeeNb/customer/customerLoginForm.jsp">로그인하러가기</a>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>		
</body>
</html>