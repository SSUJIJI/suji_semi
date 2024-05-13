<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====empOne.jsp=====");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 상세보기</title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<!-- 메인작업 -->	
		<table class="table">
			<tr>
				<th>사번</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>생년월일</th>
				<th>비밀번호수정</th>
			</tr>
			<tr>
				<td><%= loginEmp.get("empNo") %></td>
				<td><%= loginEmp.get("empName") %></td>
				<td><%= loginEmp.get("empPhone") %></td>
				<td><%= loginEmp.get("empBirth") %></td>
				<td><a href="/BeeNb/emp/empEditPwForm.jsp" class="btn btn-warning">수정</a></td>
			</tr>
		</table>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>