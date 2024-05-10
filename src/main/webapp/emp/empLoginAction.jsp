<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="beeNb.dao.DBHelper"%>
<%
	Connection conn = DBHelper.getConnection();
	String empNo = request.getParameter("empNo");
	String empPw = request.getParameter("empPw");
	// 디버깅 코드
	System.out.println("empNo : " + empNo);
	System.out.println("empPw : " + empPw);
	
	
	String sql = "select emp_no empNo, emp_pw empPw from emp where emp_no = ? and emp_pw = ?";
	
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, empNo);
	stmt.setString(2, empPw);
	ResultSet rs = stmt.executeQuery();
	HashMap<String, String> loginEmp = new HashMap<String, String>();
	if(rs.next()) {
		loginEmp.put("empNo", rs.getString("empNo"));				
		loginEmp.put("empPw", rs.getString("empPw"));				
	}
	rs.close();
	stmt.close();
	conn.close();
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