<%@page import="java.util.HashMap"%>
<%@page import="beeNb.dao.EmpDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====empLoginAction.jsp=====");
	String empNo = request.getParameter("empNo");
	String empPw = request.getParameter("empPw");
	// 디버깅 코드
	System.out.println("empNo : " + empNo);
	System.out.println("empPw : " + empPw);
	
	
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empNo, empPw);
	String msg = "입력된 로그인 정보과 올바르지 않습니다.";
	System.out.println("loginEmp : " + loginEmp);
	if(loginEmp.isEmpty()){
		String errMsg = URLEncoder.encode(msg, "utf-8");
		response.sendRedirect("/BeeNb/emp/empLoginForm.jsp?msg="+errMsg);
		return;
	}else{
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/BeeNb/emp/roomList.jsp");
		return;
	}
%>