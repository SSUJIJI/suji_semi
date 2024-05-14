<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%
	System.out.println("=====customerCheckPwForm.jsp=====");
	// 로그인 인증 
	String customerId = (String)(loginCustomer.get("customerId"));
	//디버깅
	System.out.println("고객ID :" + customerId);
	
	String errMsg = request.getParameter("errMsg");
		

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
		<h1>정보수정시 비밀번호 확인</h1>
		<%
			if(errMsg != null){
		%>
			<div class="alert alert-danger" role="alert">
				<%=errMsg%>
			</div>	
		<%	
			}
		%>
		<form method="post" action="/BeeNb/customer/customerCheckPwAction.jsp">
			<table>
				<tr>
					<th>비밀번호 입력하세요</th>
				</tr>
				<tr>
					<td><input type="password" name="customerPw"></td>				
				</tr>
			</table>
			<button type="submit">확인하기</button>
		</form>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</div>	
</body>
</html>