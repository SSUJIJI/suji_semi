<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	// 세션 값 불러오기
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
	System.out.println("loginEmp : " + loginEmp);
%>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="/BeeNb/emp/empRoomList.jsp">&#128029;</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/BeeNb/emp/empRoomList.jsp">BeeNb</a>
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
            	if(loginEmp != null){
            %>
            		사번 : <%= loginEmp.get("empNo") %> 님
            <%
            	}else{
            %>
            		로그인하세요.
            <%    		
            	}
            %>
            </a></li>
            <hr>
            <li><a class="dropdown-item" href="#">관리자리스트</a></li>
            <li><a class="dropdown-item" href="#">수익현황리스트</a></li>
            <li><a class="dropdown-item" href="#">회원리스트</a></li>
            <li><a class="dropdown-item" href="#">숙소심사</a></li>
            <li><a class="dropdown-item" href="#">테마관리</a></li>
            <li><a class="dropdown-item" href="#">VOC관리</a></li>
            <hr>
            <li><a class="dropdown-item" href="/BeeNb/emp/empLogoutAction.jsp">로그아웃</a></li>
          </ul>
        </li>
      </div>
    </div>
  </div>
</nav>