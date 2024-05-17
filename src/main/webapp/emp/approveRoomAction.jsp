<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====approveRoomAction.jsp=====");
	
	// 승인 할 roomNo
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	
	// 반려 할 roomNo
	int approve = RoomDAO.updateRoomStateApprove(roomNo);
%>