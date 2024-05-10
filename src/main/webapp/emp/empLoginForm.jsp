<%@page import="java.util.HashMap"%>
<%@page import="org.mariadb.jdbc.export.HaMode"%>
<%@page import="beeNb.dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
System.out.println("=====empLoginForm.jsp=====");
// 사용자 인증 코드
HashMap<String, Object> loginEmp = (HashMap<String, Object>) session.getAttribute("loginEmp");
System.out.println("loginEmp : " + loginEmp);
if (loginEmp != null) {
	System.out.println("이미 로그인되어 있으므로 첫 페이지로 이동합니다.");
	response.sendRedirect("/BeeNb/emp/roomList.jsp");
	return;
}
String errMsg = request.getParameter("errMsg");
//디버깅 코드
String url = "/BeeNb/emp/empLoginAction.jsp";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
<title></title>
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		<div class="row mt-5" style="height: 65vh;">
			<div class="col"></div>
			<div class="col position-relative">
				<div class="position-absolute top-50 start-50 translate-middle">
					<h1>관리자 로그인</h1>
					<form action="<%=url %>" method="post">
						<label for="empNo">사번</label>
						<input type="text" value="" name="empNo" id="empNo" required="required">
						<label for="empPw">비밀번호</label>
						<input type="password" value="" name="empPw" id="empPw" required="required">
						<button type="submit">로그인</button>
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