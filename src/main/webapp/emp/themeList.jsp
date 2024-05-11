<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	System.out.println("=====themeList.jsp=====");

	// 테마리스트 메서드 호출
	ArrayList<String> selectThemeList = ThemeDAO.selectThemeList();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>테마 리스트</title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<!-- 메인작업 -->
		<h1>테마 리스트</h1>
		<table class="table">
			<tr>
				<th>테마</th>
			</tr>
			<%
				for(String m : selectThemeList){
			%>
					<tr>
						<td>
							<%= m %>
							<a href="/BeeNb/emp/deleteThemeAction.jsp?roomTheme=<%= m %>" class="text-decoration-none text-danger">&#128473;</a>
							</td>
					</tr>
			<%
				}
			%>			
		</table>
		
		<!-- 카테고리 추가 버튼 -->
		<form method="post" action="/BeeNb/emp/addThemeAction.jsp">
			<table>
				<tr>
					<td>
						<div class="row g-3 align-items-center">
							<div class="col-auto">
								<input type="text" class="form-control">
							</div>
						</div>
					</td>
					<td>
						&nbsp;<button type="submit" class="btn btn-warning">추가</button>
					</td>
				</tr>
			</table>
		</form>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>