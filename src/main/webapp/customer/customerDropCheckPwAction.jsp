<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>

<%
	System.out.println("=====customerDropCheckPwAction.jsp=====");
	
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	//디버깅
	System.out.println("customerId :" + customerId);
	System.out.println("customerPw :" + customerPw);
	
%>
