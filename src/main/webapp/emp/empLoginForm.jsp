<%@page import="java.util.HashMap"%>
<%@page import="org.mariadb.jdbc.export.HaMode"%>
<%@page import="beeNb.dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionNotNull.jsp" %>
<%
	System.out.println("=====empLoginForm.jsp=====");
	// 사용자 인증 코드
	String errMsg = request.getParameter("errMsg");
	String logoutMsg = request.getParameter("logoutMsg");
	//디버깅 코드
	String url = "/BeeNb/emp/empLoginAction.jsp";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<title>관리자 로그인</title>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		<div class="row mt-5" style="height: 65vh;">
			<div class="col"></div>
			<div class="col-6 position-relative">
				<div class="position-absolute top-50 start-50 translate-middle w-100">
					<div class="row">
						<h1>관리자 로그인</h1>
					</div>
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
						<form action="<%=url %>" method="post">
							<div class="row mt-3">
								<div class="col-3">
									<label for="empNo" class="form-label">사번</label>
								</div>
								<div class="col-6">
									<input type="number" class="w-100 form-control" value="" name="empNo" id="empNo" required="required">
								</div>
								<div class="col">
								</div>
							</div>
							<div class="row mt-3">
								<div class="col-3">
									<label for="empPw" class="form-label">비밀번호</label>
								</div>
								<div class="col-6">
									<input type="password" class="w-100 form-control" value="" name="empPw" id="empPw" required="required">
								</div>
								<div class="col">
									<button type="submit" class="btn btn-outline-warning">로그인</button>									
								</div>
							</div>
							<div class="row mt-3">
								<div class="col">
									<div class="d-flex justify-content-center">
										<a class="text-decoration-none me-3" href="/BeeNb/emp/empResetPwForm.jsp">비밀번호 초기화</a>
										<a class="text-decoration-none" href="/BeeNb/customer/customerLoginForm.jsp">고객 로그인</a>
									</div>
								</div>
							</div>
						</form>
				</div>
			</div>
			<div class="col"></div>
		</div>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>