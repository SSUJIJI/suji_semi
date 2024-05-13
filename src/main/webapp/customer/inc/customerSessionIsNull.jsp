<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%
	// 고객 로그인이 되어 있지 않을 때 로그인폼으로 이동
	// 사용할 때 복붙용 코드 : <%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	if(loginCustomer == null) {
		response.sendRedirect("/BeeNb/customer/customerLoginForm.jsp");
		return;
	}
%>