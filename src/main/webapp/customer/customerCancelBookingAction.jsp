<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>

<%
	System.out.println("=====customerCancelBookingAction.jsp=====");
	int bookingNo = Integer.parseInt(request.getParameter("bookingNo"));
	String customerId = (String)(loginCustomer.get("customerId"));
	
	//디버깅 코드
	System.out.println("bookingNo:" + bookingNo);
	System.out.println("customerId:" + customerId);
	
	// 예약 취소 기능
	int row = BookingDAO.deleteBooking(bookingNo, customerId);
	
	if(row == 1){
		//디버깅 코드
		System.out.println("취소성공");
		String succMsg = URLEncoder.encode("예약취소 완료되었습니다.", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerBookingList.jsp?succMsg="+succMsg+"&customerId="+customerId);
	} else{
		//디버깅 코드
		System.out.println("취소실패");
		String errMsg = URLEncoder.encode("이용일 3일전 취소 불가합니다.", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerBookingList.jsp?errMsg="+errMsg+"&customerId="+customerId);
	}
%>