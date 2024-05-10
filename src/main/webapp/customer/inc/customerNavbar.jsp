<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	// 세션 값 불러오기
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	System.out.println("loginCustomer : " + loginCustomer);
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
        <li class="nav-item">
          <a class="nav-link" href="#">펜션</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">호텔</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">리조트</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">카라반</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">글램핑</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">한옥</a>
        </li>
      </ul>
      <div class="d-flex" role="search">
        <li class="navbar-nav me-auto mb-2 mb-lg-0 nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            메뉴
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">
            <%
            	if(loginCustomer != null){
            %>
            		사번 : <%= loginCustomer.get("customerId") %> 님
            <%
            	}else{
            %>
            		로그인하세요.
            <%    		
            	}
            %>
            </a></li>
            <hr>
            <li><a class="dropdown-item" href="#">[게스트메뉴]</a></li>
            <li><a class="dropdown-item" href="#">예약내역</a></li>
            <li><a class="dropdown-item" href="#">신고내역</a></li>
            <li><a class="dropdown-item" href="#">숙소리스트</a></li>
            <hr>
            <li><a class="dropdown-item" href="#">[호스트메뉴]</a></li>
            <li><a class="dropdown-item" href="#">나의숙소</a></li>
            <li><a class="dropdown-item" href="#">예약관리</a></li>
            <hr>
            <li><a class="dropdown-item" href="/BeeNb/customer/customerLogoutAction.jsp">로그아웃</a></li>
          </ul>
        </li>
      </div>
    </div>
  </div>
</nav>