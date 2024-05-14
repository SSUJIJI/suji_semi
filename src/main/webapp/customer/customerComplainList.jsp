<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.util.*" %>

<%
	System.out.println("=====customerComplainList.jsp=====");
	String customerId = (String)(loginCustomer.get("customerId"));
	
	ArrayList<HashMap<String,Object>> complainList = BookingDAO.selectComplainList(customerId);
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
		<h1>신고 내역</h1>
		<table border = "1">
			<tr>
				<td>예약번호</td>
				<td>신고번호</td>
				<td>신고유형</td>
				<td>신고내용</td>
				<td>진행상태</td>
				<td>답변</td>
				<td>신고일자</td>
				<td>처리일자</td>
			</tr>
			<%
				for(HashMap<String,Object> m : complainList){
			%>
				<tr>
					<td><%=(Integer)(m.get("bookingNo")) %></td>
					<td>
						<a href = "/BeeNb/customer/complainOne.jsp?complainNo=<%=m.get("complainNo")%>"><%=(Integer)(m.get("complainNo")) %></a>
					</td>
					<td><%=(String)(m.get("complainType")) %></td>
					<td><%=(String)(m.get("complainContent")) %></td>
					<td><%=(String)(m.get("complainState")) %></td>
					<td><%=(String)(m.get("complainAnswer")) %></td>
					<td><%=(String)(m.get("createDate")) %></td>
					<td><%=(String)(m.get("updateDate")) %></td>
				</tr>
			<%		
				}
			
			%>
		</table>
	<!-- 푸터  -->
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>