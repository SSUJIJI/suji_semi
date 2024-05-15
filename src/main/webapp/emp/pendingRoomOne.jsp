<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====pendingRoomOne.jsp=====");

	// 메시지 호출
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>숙소심사 상세보기</title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<!-- 메인작업 -->
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</div>
</body>
</html>