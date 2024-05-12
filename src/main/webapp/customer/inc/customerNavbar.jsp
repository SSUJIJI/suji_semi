<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="beeNb.dao.*" %>
<%
	// 세션 값 불러오기
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	System.out.println("loginCustomer : " + loginCustomer);
	
	// 테마리스트 메서드 호출
	ArrayList<String> selectThemeList = ThemeDAO.selectThemeList();
%>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="/BeeNb/customer/customerRoomList.jsp">&#128029;</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/BeeNb/customer/customerRoomList.jsp">BeeNb</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">전체보기</a>
        </li>
    	<%
			for(String m : selectThemeList){
		%>
        <li class="nav-item">
          <a class="nav-link" href="#"><%= m %></a>
        </li>
		<%
			}
		%>
      </ul>
      <div class="d-flex" role="search">
        <li class="navbar-nav me-auto mb-2 mb-lg-0 nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            메뉴
          </a>
          <ul class="dropdown-menu">
            <li>
            <%
            	if(loginCustomer != null){
            %>
            		<a class="dropdown-item" href="/BeeNb/customer/customerOne.jsp">
            			<%= loginCustomer.get("customerId") %> 님
            		</a>
            <%
            	}else{
            %>
            		<a href="/BeeNb/customer/customerLoginForm.jsp" class="dropdown-item">로그인하세요.</a>
            <%    		
            	}
            %>
            </li>
            <hr>
            <li><a class="dropdown-item" href="#">[게스트메뉴]</a></li>
            <li><a class="dropdown-item" href="/BeeNb/customer/customerBookingList.jsp">예약내역</a></li>
            <li><a class="dropdown-item" href="/BeeNb/customer/customerComplainList.jsp">신고내역</a></li>
            <li><a class="dropdown-item" href="/BeeNb/customer/customerRoomList.jsp">숙소리스트</a></li>
            <hr>
            <li><a class="dropdown-item" href="#">[호스트메뉴]</a></li>
            <li><a class="dropdown-item" href="/BeeNb/customer/hostRoomList.jsp">나의숙소</a></li>
            <li><a class="dropdown-item" href="/BeeNb/customer/hostBookingList.jsp">예약관리</a></li>
            <hr>
            <li><a class="dropdown-item" href="/BeeNb/customer/customerLogoutAction.jsp">로그아웃</a></li>
          </ul>
        </li>
      </div>
    </div>
  </div>
</nav>