<%@page import="beeNb.dao.RoomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%
	System.out.println("========== hostRoomOne.jsp ==========");

	// roomNo 요청 값
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	// 디버깅
	System.out.println("roomNo : " + roomNo);
	
	// currentPage 요청 값(리뷰 페이징을 위해)
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(리뷰 페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// hostRoomOne의 리뷰부분 currentPage 세션 값 설정
		session.setAttribute("hostRoomReviewCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("hostRoomReviewCurrentPage") != null) {
		currentPage = (int)session.getAttribute("hostRoomReviewCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 review 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		session.setAttribute("hostRoomReviewRowPerPage", rowPerPage);
	}
	// rowPerPage값 세션변수에 저장한 rowPerPage값으로 변경
	if(session.getAttribute("hostRoomReviewRowPerPage") != null) {
		rowPerPage = (int)session.getAttribute("hostRoomReviewRowPerPage");
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// review 테이블의 전체 행 개수
	int hostRoomReviewTotalRow = 0; //ReviewDAO.selectHostRoomReviewListCnt();
	// 디버깅
	System.out.println("hostRoomReviewTotalRow : " + hostRoomReviewTotalRow);
	
	
	// 리뷰 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - review 테이블 전체 행을 페이지당 보여줄 review 행의 개수로 나눈 값
	int lastPage = hostRoomReviewTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 review 행을 보여주기 위해 lastPage 에 + 1하기
	if(hostRoomReviewTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	// 호스팅한 숙소의 상세정보
	HashMap<String, Object> hostRoomOne = RoomDAO.selectHostRoomOne(roomNo);
	//디버깅
	System.out.println("hostRoomOne : " + hostRoomOne);
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
		
		<!-- 숙소 상세정보 출력 -->

		
		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>