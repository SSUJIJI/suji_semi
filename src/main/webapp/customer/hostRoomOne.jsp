<%@page import="java.util.*"%>
<%@page import="beeNb.dao.*"%>
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
		session.setAttribute("hostRoomcurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("hostRoomcurrentPage") != null) {
		currentPage = (int)session.getAttribute("hostRoomcurrentPage");	
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
	int hostRoomReviewTotalRow = ReviewDAO.selectHostRoomReviewListCnt(roomNo);
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
	
	// 호스팅한 숙소의 하루 가격 및 정보(가격, 예약 상태)리스트
	ArrayList<HashMap<String, Object>> oneDayPriceList = OneDayPriceDAO.selectOneDayPriceList(roomNo);
	// 디버깅
	System.out.println("oneDayPriceList : " + oneDayPriceList);
	
	// 호스팅한 숙소의 리뷰 리스트
	ArrayList<HashMap<String, Object>> reviewList = ReviewDAO.selectHostRoomReviewList(roomNo, startRow, rowPerPage);
	// 디버깅
	System.out.println("reviewList : " + reviewList);
%>
<%
	// 달력 구현
	// 페이지의 달력 년도와 월 요청값
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	// 디버깅
	System.out.println("targetYear : " + targetYear);
	System.out.println("targetMonth : " + targetMonth);
	
	// 캘린더 객체 생성
	Calendar target = Calendar.getInstance();
	
	// 년도, 월의 요청값이 있을 경우 Calendar객체의 Year, Month를 요청값으로 변경
	if(targetYear != null && targetMonth != null) {
		target.set(Calendar.YEAR, Integer.parseInt(targetYear));
		target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	
	// 페이지에 출력할 달력 년 월 변수
	int calendarYear = target.get(Calendar.YEAR);
	int calendarMonth = target.get(Calendar.MONTH);
	// 디버깅
	System.out.println("calendarYear : " + calendarYear);
	System.out.println("calendarMonth : " + calendarMonth);
	
	// 달력 1일 시작 전 공백 개수 구하기 -> 1일의 요일이 필요 -> target의 날짜를 1일로 변경
	target.set(Calendar.DATE, 1);
	int firstDayNum = target.get(Calendar.DAY_OF_WEEK);	//1일의 요일 (일 : 1 / 월 : 2 / ... / 토 : 7)
	// 디버깅
	System.out.println("firstDayNum : " + firstDayNum);
	
	int firstDayBeforeBlank = firstDayNum - 1;	// 1일 시작 전 공백 개수 Ex) 1일이 일요일 -> 0개 / 1일이 월요일 -> 1개 / .... / 1일이 토요일 -> 6개
	int lastDay = target.getActualMaximum(Calendar.DATE);	// target달의 마지막 날짜 반환
	// 디버깅
	System.out.println("firstDayBeforeBlank : " + firstDayBeforeBlank);
	System.out.println("lastDay : " + lastDay);
	
	// 달력 칸의 개수
	int calendarTotalDiv = 42;	
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
		
		<h1><%=hostRoomOne.get("roomName") %></h1>
		<!-- 숙소 상세정보 출력 -->
		<div>
			<!-- 숙소 이미지 -->
			<div>
				<img alt="..." src="/BeeNb/upload/<%=hostRoomOne.get("roomImg") %>">
			</div>
			<!-- 나머지 상세정보 -->
			<div>
				<div>
					<b>숙소 이름</b>
					<%=hostRoomOne.get("roomName") %>
				</div>
				
				<div>
					<b>숙소 타입</b>
					<%=hostRoomOne.get("roomCategory") %>
				</div>
				
				<div>
					<b>테마</b>
					<%=hostRoomOne.get("roomTheme") %>
				</div>
				
				<div>
					<b>위치</b>
					<%=hostRoomOne.get("roomAddress") %>
				</div>
				
				<div>
					<b>운용 기간</b>
					<%=hostRoomOne.get("operationStart") %> ~ <%=hostRoomOne.get("operationEnd") %>
				</div>
				
				<div>
					<b>최대 수용 인원</b>
					<%=hostRoomOne.get("maxPeople") %>
				</div>
				
				<div>
					<b>설명</b>
					<%=hostRoomOne.get("roomContent") %>
				</div>
				
				<div>
					<b>승인 상태</b>
					<%=hostRoomOne.get("approveState") %>
				</div>
				
				<div>
					<b>숙소 등록일</b>
					<%=hostRoomOne.get("createDate") %>
				</div>
				
				<div>
					<b>숙소 수정일</b>
					<%=hostRoomOne.get("updateDate") %>
				</div>
			</div>
		</div>

		<!-- 숙소 예약일 -->
		<div>
			<hr>
			<div class="row">
				<div class="col">
					<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo %>&targetYear=<%=calendarYear%>&targetMonth=<%=calendarMonth - 1%>">
						이전 달
					</a>
				</div>
				
				<div class="col">
					<h2><%=calendarYear%>년 <%=calendarMonth + 1%>월</h2>
				</div>
				
				<div class="col">
					<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo %>&targetYear=<%=calendarYear%>&targetMonth=<%=calendarMonth + 1%>">
						다음 달
					</a>
				</div>
			</div>
		</div>
		<!-- 달력 -->
		<div>
			<!-- 요일 -->
			<table class="table">
				<thead>
					<tr>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th>토</th>
						<th>일</th>
					</tr>
				</thead>
				
				<tbody>
					<%
						for(int i = 1; i <= 6; i++) {
							for(int j = 1; j <= 7; j++) {
								
							}
						}
					%>
				</tbody>
			</table>
		</div>
		
		
		
		<!-- 숙소 리뷰 -->
		<div>
			<hr>
			<h2 style="display: inline-block;">리뷰</h2>
			<%
				for(HashMap<String, Object> m : reviewList) {
			%>
					<div>
						<div>
							<%=m.get("customerId") %>
						</div>
						<div>
							<%
								for(int i = 1; i <= (int)(m.get("rating")); i++) {
							%>
									&#127775;
							<%
								}
							%>
						</div>
						<div>
							<%=((String)(m.get("createDate"))).substring(0, 11)%>
						</div>
						<div><%=m.get("reviewContent") %></div>
					</div>	
					<hr>
			<%
				}
			%>
				
			<!-- 숙소 리뷰 페이징 -->	
			<div>
				<%
					if(currentPage > 1) {
				%>	
						<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1">처음페이지</a>
						<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=currentPage-1%>">이전페이지</a>
				<%		
					} else {
				%>
						<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1">처음페이지</a>
						<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1">이전페이지</a>
				<%		
					}
		
					if(currentPage < lastPage) {
				%>
						<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=currentPage+1%>">다음페이지</a>
						<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>">마지막페이지</a>
				<%		
					} else {
				%>
						<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>">다음페이지</a>
						<a href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>">마지막페이지</a>
				<%
					}
				%>
			</div>
		</div>
		
		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>