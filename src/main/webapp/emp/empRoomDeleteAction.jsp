<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*" %>
<%
	System.out.println("=====roomDeleteAction.jsp=====");
	// 삭제버튼을 눌러서 넘어 온 액션 페이지임.
	// 먼저 넘어온 roomNo를 booking테이블 조회하는 쿼리문에 넣어서
	// 조회되면 다시 룸리스트로 돌아가서 삭제 못 하게 한다.(에러메세지 담아서)
	// 조회가 안 되면 삭제한다.
	// 세션 이슈 때문에 이 페이지를 복사하여 customer에도 만들어주고 cus의 세션을 담아줄 것이다.
	// 메서드는 어차피 roomDAO 것을 같이 쓰기 때문에 상관없다.
	
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	System.out.println("roomNo : " + roomNo);
	
	int bookingExist = BookingListDAO.selectBookingList(roomNo);
	System.out.println("예약목록이 있으면 1, 없으면 0 : " + bookingExist);
	
	
	if(bookingExist==1){ // 예약목록이 
		
	}
%>