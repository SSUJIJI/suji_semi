<%@page import="beeNb.dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp" %>
<%
	System.out.println("========== customerOne.jsp ==========");

	// 고객 아이디 요청 값
	String customerId = request.getParameter("customerId");
	// 디버깅
	System.out.println("customerId : " + customerId);
	
	// 고객 정보 가져오기
	HashMap<String, String> customerOne = CustomerDAO.selectCustomerOne(customerId);
	// 디버깅
	System.out.println("customerOne : " + customerOne);
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
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<h1><%=customerOne.get("customerId")%>회원 상세정보</h1>
		<a class="text-decoration-none" href="/BeeNb/emp/customerList.jsp">뒤로가기</a>
		<!-- 고객 상세 정보 -->
		<table class="table">
			<tr>
				<th>고객 ID</th>
				<td><%=customerOne.get("customerId")%></td>
			</tr>
			
			<tr>
				<th>고객 E-MAIL</th>
				<td><%=customerOne.get("customerEmail")%></td>
			</tr>
			
			<tr>
				<th>고객 이름</th>
				<td><%=customerOne.get("customerName")%></td>
			</tr>
			
			<tr>
				<th>고객 생년월일</th>
				<td><%=customerOne.get("customerBirth")%></td>
			</tr>
			
			<tr>
				<th>고객 전화번호</th>
				<td><%=customerOne.get("customerPhone")%></td>
			</tr>
			
			<tr>
				<th>고객 성별</th>
				<td>
				<%
					if(customerOne.get("customerGender").equals("M")) {
				%>
						남자
				<%
					} else {
				%>
						여자
				<%
					}
				%>
				</td>
			</tr>
			
			<tr>
				<th>고객 등급</th>
				<td>
					<%
						if(customerOne.get("customerGrade").equals("0")) {
					%>
							게스트
					<%
						} else {
					%>
							게스트 & 호스트
					<%
						}
					%>
				</td>
			</tr>
			
			<tr>
				<th>고객 생성일</th>
				<td><%=customerOne.get("createDate")%></td>
			</tr>
			
			<tr>
				<th>고객정보 수정일</th>
				<td><%=customerOne.get("updateDate")%></td>
			</tr>
			
			
		</table>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>