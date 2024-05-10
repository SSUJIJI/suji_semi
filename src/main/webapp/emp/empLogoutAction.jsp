<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====empLogoutAction.jsp=====");
	session.invalidate();	
	response.sendRedirect("/BeeNb/emp/empLoginForm.jsp");
%>