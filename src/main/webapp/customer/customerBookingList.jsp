<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.util.*" %>

<%
	System.out.println("=====customerBookingList.jsp=====");
	String customerId = (String)(loginCustomer.get("customerId"));
	
	// 현재 페이지 구하기
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// customerBookingList 페이지의 currentPage 세션 값 설정
		session.setAttribute("customerBookingCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("customerBookingCurrentPage") != null) {
		currentPage = (int)session.getAttribute("customerBookingCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	// 페이지당 보여줄 customerBookingList 행의 개수
	// 기본 10개로 설정
	int rowPerPage = 10;

	//customerBookingList 전체 행의 개수
	int totalRow = BookingDAO.selectAfterBookingListCnt(customerId);
	// 디버깅
	System.out.println("totalRow : " + totalRow);
	
	// 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - emp 테이블 전체 행을 페이지당 보여줄 emp 행의 개수로 나눈 값
	int lastPage = totalRow / rowPerPage;
	// 나머지가 생길 경우 남은 emp 행을 보여주기 위해 lastPage 에 +1하기
	if(totalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	// 이용 전 리스트
	ArrayList<HashMap<String,Object>> beforeList = BookingDAO.selectBeforeList(customerId);
	// 이용 후 리스트 
	ArrayList<HashMap<String,Object>> afterList = BookingDAO.selectAfterList(customerId, startRow, rowPerPage);

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
		<h1>이용 전 예약리스트</h1>
		<!-- 이용 전 예약 리스트 출력 -->
		<table class="table table-striped">
			<tr>
				<th>예약번호</th>
				<th>아이디</th>
				<th>숙소이름</th>
				<th>주소</th>
				<th>예약상태</th>
				<th>결제일자</th>
				<th>입실날짜</th>
				<th>퇴실날짜</th>
			</tr>
			<%
				for(HashMap<String,Object> m : beforeList){
			%>
				<tr>
					<td><%=(int)(m.get("bookingNo"))%></td>
					<td><%=(String)(m.get("customerId"))%></td>
					<td><%=(String)(m.get("roomName"))%></td>
					<td><%=(String)(m.get("roomAddress"))%></td>
					<td><%=(String)(m.get("bookingState"))%></td>
					<td><%=(String)(m.get("createDate"))%></td>
					<td><%=(String)(m.get("startRoomDate"))%></td>
					<td><%=(String)(m.get("endRoomDate"))%></td>
				</tr>
			<%
				}
				
			%>
		</table>
		<h1>이용 후 예약리스트</h1>
		<!-- 이용 후 예약 리스트 출력 -->
		<form>
			<table class="table table-striped">
				<tr>
					<th>예약번호</th>
					<th>아이디</th>
					<th>숙소이름</th>
					<th>주소</th>
					<th>예약상태</th>
					<th>결제일자</th>
					<th>입실날짜</th>
					<th>퇴실날짜</th>
				</tr>
				<%
					for(HashMap<String,Object> m : afterList){
				%>
					<tr>
						<td><%=(int)(m.get("bookingNo"))%></td>
						<td><%=(String)(m.get("customerId"))%></td>
						<td><%=(String)(m.get("roomName"))%></td>
						<td><%=(String)(m.get("roomAddress"))%></td>
						<td><%=(String)(m.get("bookingState"))%></td>
						<td><%=(String)(m.get("createDate"))%></td>
						<td><%=(String)(m.get("startRoomDate"))%></td>
						<td><%=(String)(m.get("endRoomDate"))%></td>
					</tr>
				<%
					}
					
				%>
			</table>
			<!-- 페이징 버튼 -->
			<div>
				<nav>
					<ul class = "pagination">
						<%
							if(currentPage > 1){
						%>		
								<li class="page-item">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=1">처음페이지</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
								</li>
						<%
							}else {
						%>		
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=1">처음페이지</a>
								</li>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
								</li>
						<%
							}
							if(currentPage < lastPage){
						%>
								<li class="page-item">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?lastPage=<%=lastPage%>">마지막페이지</a>
								</li>
						<%		
							}else{
						%>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
								</li>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?lastPage=<%=lastPage%>">마지막페이지</a>
								</li>
						<%		
							}
						%>
					</ul>
				</nav>
			</div>
		</form>
		
	<!-- 푸터  -->
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>