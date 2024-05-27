<%@page import="java.util.*"%>
<%@page import="beeNb.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("==========pendingRoomOne.jsp==========");

	// roomNo 요청 값
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	// 디버깅
	System.out.println("roomNo : " + roomNo);
	
	
	// 호스팅한 숙소의 상세정보
	HashMap<String, Object> empRoomOne = RoomDAO.selectHostRoomOne(roomNo);
	//디버깅
	System.out.println("empRoomOne : " + empRoomOne);
	
	
	// 호스팅한 숙소의 하루 가격 및 정보(가격, 예약 상태)리스트
	ArrayList<HashMap<String, Object>> oneDayPriceList = OneDayPriceDAO.selectOneDayPriceList(roomNo);
	// 디버깅
	System.out.println("oneDayPriceList : " + oneDayPriceList);
	
	int startRow = 1;
	int rowPerPage = 1;
	// 호스팅한 숙소의 리뷰 리스트
	ArrayList<HashMap<String, Object>> reviewList = ReviewDAO.selectHostRoomReviewList(roomNo, startRow, rowPerPage);
	// 디버깅
	System.out.println("reviewList : " + reviewList);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<link rel="icon" href="/BeeNb/img/beeFavicon.ico">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<h1><%=empRoomOne.get("roomName") %></h1>
		<!-- 숙소 상세정보 출력 -->
		<div>
			<!-- 숙소 이미지 -->
			<div>
				<img alt="..." src="/BeeNb/upload/<%=empRoomOne.get("roomImg") %>" width="500px;">
			</div>
			<!-- 나머지 상세정보 -->
			<div>
				<div>
					<b>상신 ID</b>
					<%=empRoomOne.get("customerId") %>
				</div>
				
				<div>
					<b>숙소 이름</b>
					<%=empRoomOne.get("roomName") %>
				</div>
				
				<div>
					<b>숙소 타입</b>
					<%=empRoomOne.get("roomCategory") %>
				</div>
				
				<div>
					<b>테마</b>
					<%=empRoomOne.get("roomTheme") %>
				</div>
				
				<div>
					<b>위치</b>
					<%=empRoomOne.get("roomAddress") %>
				</div>
				
				<div>
					<b>운용 기간</b>
					<%=empRoomOne.get("operationStart") %> ~ <%=empRoomOne.get("operationEnd") %>
				</div>
				
				<div>
					<b>최대 수용 인원</b>
					<%=empRoomOne.get("maxPeople") %>
				</div>
				
				<div>
					<b>설명</b>
					<%=empRoomOne.get("roomContent") %>
				</div>
				
				<div>
					<b>승인 상태</b>
					<%=empRoomOne.get("approveState") %>
				</div>
				
				<div>
					<b>숙소 등록일</b>
					<%=empRoomOne.get("createDate") %>
				</div>
				
				<div>
					<b>숙소 수정일</b>
					<%=empRoomOne.get("updateDate") %>
				</div>
			</div>
		</div>
		
		<hr>
		
		<div>
			<a href="/BeeNb/emp/approveRoomAction.jsp?roomNo=<%=roomNo %>&customerId=<%=empRoomOne.get("customerId") %>" class="btn btn-warning">승인</a>	
			<a href="/BeeNb/emp/rejectRoomAction.jsp?roomNo=<%=roomNo %>&customerId=<%=empRoomOne.get("customerId") %>" class="btn btn-warning">반려</a>
		</div>

		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>