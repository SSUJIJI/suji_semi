<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("=====customerRoomList.jsp=====");

	// 숙소 목록 출력
	ArrayList<HashMap<String, Object>> selectRoomList = RoomDAO.selectRoomList();
	
	// 테마리스트 메서드 호출
	ArrayList<String> selectThemeList = ThemeDAO.selectThemeList();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<style>
		.room-image {
			width: 100%; /* 너비를 카드에 맞춤 */
			height: 200px; /* 높이 설정 */
			object-fit: cover; /* 이미지 비율을 유지하면서 빈 공간 없이 채움 */
		}
	</style>	
</head>
<body>
	<div class="container">
		<!-- 고객 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>

		<!-- 메인작업 -->
		<!-- 숙소 목록 출력 -->
		<div class="row row-cols-1 row-cols-md-3 g-4">
		<%
		for (HashMap<String, Object> m : selectRoomList) {
		%>
				<div class="col">
					<div class="card">
						<img src="/BeeNb/upload/<%=(String) (m.get("roomImg"))%>" class="card-img-top room-image" alt="...">
						<div class="card-body">
							<h5 class="card-title"><%=(String) (m.get("roomName"))%></h5>
							<p class="card-text">
								<%=(String) (m.get("customerId"))%>님의 숙소
								<br>
								<b><%=(String) (m.get("roomAddress"))%></b>
								<br>
								최대 <%=(Integer) (m.get("maxPeople"))%>명
							</p>
							<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=(Integer) (m.get("roomNo"))%>" class="btn btn-warning">상세보기</a>
							<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=(Integer) (m.get("roomNo"))%>" class="btn btn-warning">예약하기</a>
						</div>
					</div>
				</div>
		<%		
			}
		%>
		</div>
				
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>