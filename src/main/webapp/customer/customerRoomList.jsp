<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("=====customerRoomList.jsp=====");

	// 테마리스트 메서드 호출
	ArrayList<String> selectThemeList = ThemeDAO.selectThemeList();
	
	// 메세지 호출
	String msg = request.getParameter("msg");
	
	// 검색 값 호출 후 디버깅
	String searchAddress = request.getParameter("searchAddress");
	String searchStartDate = request.getParameter("searchStartDate");
	String searchEndDate = request.getParameter("searchEndDate");
	String searchMaxPeopleParam = request.getParameter("searchMaxPeople");
	int searchMaxPeople = 0; // 기본값을 0으로 설정
	// int 값 있을 때만 받기
	if (searchMaxPeopleParam != null && !searchMaxPeopleParam.isEmpty()) {
	        searchMaxPeople = Integer.parseInt(searchMaxPeopleParam);
	}	
	
	System.out.println("검색디버깅");
	System.out.println("searchAddress : " + searchAddress);
	System.out.println("searchStartDate : " + searchStartDate);
	System.out.println("searchEndDate : " + searchEndDate);
	System.out.println("searchMaxPeople : " + searchMaxPeople);
	
	// 필터 값 호출 후 디버깅
	String lowPrice = request.getParameter("lowPrice");
	String highPrice = request.getParameter("highPrice");
	String room_category = request.getParameter("room_category");
	String wifi = request.getParameter("wifi");
	String kitchen_tools = request.getParameter("kitchen_tools");
	String parking = request.getParameter("parking");
	String ott = request.getParameter("ott");
	String ev = request.getParameter("ev");
	String bedParam = request.getParameter("bed");
	int bed = 0;
	// int 값 있을 때만 받기
	if (bedParam != null) {
		bed = Integer.parseInt(bedParam);
	}
	
	System.out.println("옵션디버깅");
	System.out.println("lowPrice : " + lowPrice);
	System.out.println("highPrice : " + highPrice);
	System.out.println("room_category : " + room_category);
	System.out.println("wifi : " + wifi);
	System.out.println("kitchen_tools : " + kitchen_tools);
	System.out.println("parking : " + parking);
	System.out.println("ott : " + ott);
	System.out.println("ev : " + ev);
	System.out.println("bed : " + bed);
	
	// 테마값 불러오기
	String theme = request.getParameter("theme");
	System.out.println("theme : " + theme);
	
	// 1. 숙소리스트 출력
	ArrayList<HashMap<String, Object>>  selectRoomList = RoomDAO.selectRoomList(theme);
	
	// 2. 검색 결과만 출력
	ArrayList<HashMap<String, Object>>  searchRoomList = RoomDAO.searchRoomList(searchAddress, searchStartDate, searchEndDate, searchMaxPeople, theme);
	
	// 3. 필터 결과만 출력
	ArrayList<HashMap<String, Object>> roomFilterList = RoomDAO.roomFilterList(lowPrice, highPrice, room_category, wifi, kitchen_tools, parking, bed, ott, ev, theme);
	
	// 4. 검색 + 필터 결과 출력
	ArrayList<HashMap<String, Object>> searchRoomFilterList = RoomDAO.searchRoomFilterList(searchAddress, searchStartDate, searchEndDate, searchMaxPeople, lowPrice, highPrice, room_category, wifi, kitchen_tools, parking, bed, ott, ev, theme);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>숙소 목록</title>
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
		
		<!-- 검색창 -->
		<div class="row">
			<div class="col-2"></div>
			<div class="col-10">
				<div class="w-75 p-3 border border-warning rounded-pill">
					<form method="post" action="/BeeNb/customer/customerRoomList.jsp">
						<%
							if(lowPrice!=null){
						%>
 						<input type="hidden" name="lowPrice" value="<%=lowPrice %>">
						<input type="hidden" name="highPrice" value="<%=highPrice %>">
						<input type="hidden" name="room_category" value="<%=room_category %>">
						<input type="hidden" name="wifi" value="<%=wifi %>">
						<input type="hidden" name="kitchen_tools" value="<%=kitchen_tools %>">
						<input type="hidden" name="parking" value="<%=parking %>">
						<input type="hidden" name="ott" value="<%=ott %>">
						<input type="hidden" name="ev" value="<%=ev %>">
						<input type="hidden" name="bed" value="<%=bed %>">
						<%
							}
						%>
						여행지<input type="text" name="searchAddress" style="width:100px;">
						체크인<input type="date" name="searchStartDate">
						체크아웃<input type="date" name="searchEndDate">
						여행자<input type="number" name="searchMaxPeople" style="width:50px;">
						<button type="submit">
							<img src="/BeeNb/img/search.png" class="h-100 d-inline-block" style="width: 30px;">
						</button>
					</form>
				</div>
			</div>
			<div class="col"></div>
		</div>
		
		<br>
		<hr>
		<!-- 테마리스트 -->
		<ul class="nav justify-content-center">
			<%
				for (String m : selectThemeList) {
			%>
					<li class="nav-item">
						<a class="nav-link text-black" href="/BeeNb/customer/customerRoomList.jsp?&theme=<%= m %>"><%= m %></a>
					</li>
			<%
				}
			%>
			<div class="dropdown">
			  <button class="btn btn-warning zdropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    필터
			  </button>
			  <ul class="dropdown-menu">
			    <div>
					<form method="post" action="/BeeNb/customer/customerRoomList.jsp">
						<h3>필터</h3>
						<input type="hidden" name="searchAddress" value="<%=searchAddress %>">
						<input type="hidden" name="searchStartDate" value="<%=searchStartDate %>">
						<input type="hidden" name="searchEndDate" value="<%=searchEndDate %>">
						<input type="hidden" name="searchMaxPeople" value="<%=searchMaxPeople %>">
						<h5>가격</h5>
						최소가격:<input type="number" name="lowPrice">
						최대가격:<input type="number" name="highPrice">
						<h5>카테고리</h5>
							<select name="room_category">
								<option value="펜션">펜션</option>
								<option value="호텔">호텔</option>
								<option value="리조트">리조트</option>
								<option value="카라반">카라반</option>
								<option value="글램핑">글램핑</option>
								<option value="한옥">한옥</option>
							</select>
						<h5>옵션</h5>
						와이파이
						<br>
						유<input type='radio' name='wifi' value='1' />
						무<input type='radio' name='wifi' value='0' checked/>
						<br>
						주방
						<br>
						유<input type='radio' name='kitchen_tools' value='1' />
						무<input type='radio' name='kitchen_tools' value='0' checked/>
						<br>
						주차
						<br>
						유<input type='radio' name='parking' value='1' />
						무<input type='radio' name='parking' value='0' checked/>
						<br>
						OTT
						<br>
						유<input type='radio' name='ott' value='1' />
						무<input type='radio' name='ott' value='0' checked/>
						<br>
						엘리베이터
						<br>
						유	<input type='radio' name='ev' value='1' />
						무<input type='radio' name='ev' value='0' checked/>
						<br>
						침대갯수:<input type="number" name="bed">개
					<button type="submit">필터적용</button>
					</form>
			    </div>
			  </ul>
			</div>
		</ul>
		<br>


		<!-- 메세지 출력 -->
		<%
			if (msg != null) {
		%>
				&nbsp;<%=msg%>
		<%
			}
		%>
		
		<!-- 분기문 -->
		<%
			if(searchAddress!=null && searchStartDate!=null && searchEndDate!=null && searchMaxPeople!=0){ // 검색했을때
				if(lowPrice!=null){ // 검색+필터
		%>
		<!-- 검색O, 필터O -->
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<%
				if (searchRoomFilterList != null && !searchRoomFilterList.isEmpty()) {
				    for (HashMap<String, Object> m : searchRoomFilterList) {
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
				} else {
			%>
		  		    <p>조건에 맞는 숙소가 없습니다.</p>
			<%
				}
			%>
		</div>		
		<%
				}else if(lowPrice==null){ // 검색만
		%>
		<!-- 검색O, 필터X -->
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<%
				if (searchRoomList != null && !searchRoomList.isEmpty()) {
				    for (HashMap<String, Object> m : searchRoomList) {
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
				} else {
			%>
		  		    <p>조건에 맞는 숙소가 없습니다.</p>
			<%
				}
			%>
		</div>		
		<%
				}
			}else{ // 검색안했을때
			if(lowPrice!=null){ // 필터만
		%>
		<!-- 검색X, 필터O -->
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<%
				if (roomFilterList != null && !roomFilterList.isEmpty()) {
				    for (HashMap<String, Object> m : roomFilterList) {
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
				} else {
			%>
		  		    <p>조건에 맞는 숙소가 없습니다.</p>
			<%
				}
			%>
		</div>		
		<%
			}else{
		%>	
		<!-- 검색X, 필터X -->
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
		<%
			}
		}
		%>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>