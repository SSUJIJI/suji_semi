<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%@ page import="beeNb.dao.*" %>
<%
	System.out.println("=====customerDropCheckPwForm.jsp=====");
	String customerId = (String)(loginCustomer.get("customerId"));
	// 에러메세지
	String errMsg = request.getParameter("errMsg");
	// 디버깅
	System.out.println("에러메세지 :" + errMsg);
	
	// 게스트가 이용전 예약이 있는지 확인
	boolean guest = BookingDAO.selectBeforeBookingById(customerId);
	//디버깅코드 
	System.out.println("guest: " + guest);
	// 호스트가 등록된 숙소가 있는지 확인
	boolean host = RoomDAO.selectRoomListDrop(customerId);
	//디버깅코드 
	System.out.println("host: " + host);
	
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
		<h1>회원탈퇴</h1>
		<%
			if(guest == true && host == true) {
		%>   <form action="/BeeNb/customer/customer/customerDropCheckPwAction.jsp">
				<table>
					<tr>
						<td>아이디 : </td>
						<td><input type="text" name="customerId" required="required"></td>
					</tr>
					<tr>
						<td>비밀번호 : </td>
						<td><input type="password" name="customerPw"></td>
					</tr>	
				</table>
				<button type="submit">회원탈퇴</button>
			</form>
		<%
			}else{
		%>
					예약 또는 숙소를 확인해주세요.
		<%		
			}
		%>
		
		
	<!-- 푸터  -->
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>