<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>
<%
	System.out.println("=====customerEditPwAction.jsp=====");

	String customerId = request.getParameter("customerId");
	String newCustomerPw = request.getParameter("newCustomerPw");
	String newCustomerPwCheck = request.getParameter("newCustomerPwCheck");
	
	// 디버깅 코드
	System.out.println("customerId: " + customerId);
	System.out.println("newCustomerPw: " + newCustomerPw);
	System.out.println("newCustomerPwCheck: " + newCustomerPwCheck);
	
	boolean result = CustomerDAO.selectCustomerPwHistory(customerId);
	int row = CustomerDAO.updateCustomerPw(newCustomerPw, customerId);
	int row2 = CustomerDAO.insertCustomerNewPwHistory(newCustomerPw, customerId);
	
	if(result = true && row == 1 & row2 == 1){
		// 디버깅 코드
		System.out.println("변경 성공");
		response.sendRedirect("/BeeNb/customer/customerLoginForm.jsp");
	}else{
		// 디버깅 코드
		System.out.println("변경 실패");
		String errMsg = URLEncoder.encode("변경실패입니다.","utf-8");
		response.sendRedirect("/BeeNb/customer/customerEditPwForm.jsp?errMsg="+errMsg);
	}
%>