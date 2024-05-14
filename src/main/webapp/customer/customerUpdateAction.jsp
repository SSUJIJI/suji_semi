<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%@ page import="beeNb.dao.*" %>
<%@ page import = "java.net.*" %>
<%
	System.out.println("=====customerUpdateAction.jsp=====");
	
	String customerId = request.getParameter("customerId");
	String customerEmail = request.getParameter("customerEmail");
	String customerName = request.getParameter("customerName");
	String customerPhone = request.getParameter("customerPhone");
	String oldCustomerPw = request.getParameter("oldCustomerPw");
	String newCustomerPw = request.getParameter("newCustomerPw");
	String newCustomerPwCheck = request.getParameter("newCustomerPwCheck");
	
	// 디버깅 코드 
	System.out.println("customerId :"+customerId);
	System.out.println("customerEmail :"+customerEmail);
	System.out.println("customerName :"+customerName);
	System.out.println("customerPhone :"+customerPhone);
	System.out.println("oldCustomerPw :"+oldCustomerPw);
	System.out.println("newCustomerPw :"+newCustomerPw);
	System.out.println("newCustomerPwCheck :"+newCustomerPwCheck);
	
	// 새로변경할 비밀번호가 pwhistory에 적재되어있는지 확인 있으면 변경 불가 
	boolean result = CustomerDAO.selectCustomerPwHistory(customerId, newCustomerPw);
	//디버깅코드
	System.out.println("pwHistory: " + result);	
	if(result == true) {
		System.out.println("이전 사용 비밀번호");
		String usedPwMsg = URLEncoder.encode("사용했던 비밀번호입니다. 다시 입력해주세요. ", "UTF-8");
		response.sendRedirect("/BeeNb/customer/customerUpdateForm.jsp?usedPwMsg="+usedPwMsg);
		return;
	}
	// 고객 정보 수정
	int row =CustomerDAO.updateCustomer(customerEmail, customerPhone, newCustomerPw, customerId);
	// 새로변경한 비밀번호 pw history에 추가하기
	int row2 = CustomerDAO.insertCustomerNewPwHistory(newCustomerPw, customerId);
	if(row == 1 && row2 == 1 ) {
		//디버깅코드
		System.out.println("변경성공");
		String succMsg = URLEncoder.encode("정보가 수정되었습니다. ", "UTF-8");
		response.sendRedirect("/BeeNb/customer/customerOne.jsp?succMsg="+succMsg);			
	}else{
		//디버깅코드
		System.out.println("변경실패");
		String errMsg = URLEncoder.encode("입력한 정보를 다시 확인해주세요.", "UTF-8");
		response.sendRedirect("/BeeNb/customer/customerUpdateForm.jsp?errMsg="+errMsg);
	}
	
	
	
%>