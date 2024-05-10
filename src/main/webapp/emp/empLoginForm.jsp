<%@page import="java.util.HashMap"%>
<%@page import="org.mariadb.jdbc.export.HaMode"%>
<%@page import="beeNb.dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 사용자 인증 코드
	HashMap<String, Object> loginInfo = (HashMap<String, Object>)request.getSession();
	if(loginInfo != null){
		System.out.println("로그인 정보를 가진 세션이 발견되어 메인페이지로 이동합니다.");
		/* response.sendRedirect(""); */
		return;
	}

	String errMsg = request.getParameter("errMsg");
	//디버깅 코드
	System.out.println();
	DBHelper.getConnection();
	String url = "/BeeNb/emp/empLoginAction.jsp";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>로그인</h1>
	<form action="<%=url%>" method="post">
		<input type="text" value="" name="empNo" required="required">
		<input type="password" value="" name="empPw" required="required">
		<button type="submit">로그인</button>
	</form>
</body>
</html>