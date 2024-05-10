<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>
<%	
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String customerEmail = request.getParameter("customerEmail");
	String customerName = request.getParameter("customerName");
	String customerBirth = request.getParameter("customerBirth");
	String customerPhone = request.getParameter("customerPhone");
	String customerGender = request.getParameter("customerGender");
	
	// 디버깅코드
	System.out.println("customerId : " + customerId);
	System.out.println("customerPw : " + customerPw);
	System.out.println("customerEmail : " + customerEmail);
	System.out.println("customerName : " + customerName);
	System.out.println("customerBirth : " + customerBirth);
	System.out.println("customerPhone : " + customerPhone);
	System.out.println("customerGender : " + customerGender);
	
	int row = CustomerDAO.insertCustomer(customerId, customerPw, customerEmail, customerName, customerBirth, customerPhone,customerGender);
	int row2 = CustomerDAO.insertCustomerPwHistory(customerId, customerPw);
	
	if(row == 1 && row2 == 1){
		// 디버깅코드
		System.out.println("입력성공");
		response.sendRedirect("/beeNb/customer/customerLoginForm.jsp");
	}else{
		// 디버깅코드
		System.out.println("입력실패");
		String errMsg = URLEncoder.encode("회원가입실패입니다.","utf-8");
		response.sendRedirect("/beeNb/customer/customerSignUpForm.jsp?errMsg="+errMsg);
	}
%>
%>