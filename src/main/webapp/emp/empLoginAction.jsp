<%@page import="beeNb.dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	DBHelper.getConnection();
	String empNo = request.getParameter("empNo");
	String empPw = request.getParameter("empPw");
	// 디버깅 코드
	System.out.println("empNo : " + empNo);
	System.out.println("empPw : " + empPw);
	
	
%>