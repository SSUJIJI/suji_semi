<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====empEditPwAction.jsp=====");
	
	// 사번과 바꿀 비밀번호 호출
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String newEmpPw = request.getParameter("newEmpPw");
	
	// 디버깅
	System.out.println("empNo : " + empNo);
	System.out.println("newEmpPw : " + newEmpPw);
	
	// 비밀번호 히스토리 조회 메서드
	// return : boolean (기존에 있던 비밀번호면 true, 기존에 없던 비밀번호면 false)
	boolean selectEmpPwHistory = EmpDAO.selectEmpPwHistory(empNo, newEmpPw);
	System.out.println("selectEmpPwHistory : " + selectEmpPwHistory);
	if(selectEmpPwHistory==true){
		System.out.println("사용했던 비밀번호");
		String usedPwMsg = URLEncoder.encode("사용했던 비밀번호입니다. 다시 입력해주세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/empEditPwForm.jsp?usedPwMsg="+usedPwMsg);
		return;
	}
	
	// EmpDAO.insertEmpPwHistory()가 받는 값이 empPw 이기 때문에 newEmpPw라는 변수의 값을 empPw 라고 선언.
	String empPw = newEmpPw;
	// 변경할 비밀번호를 히스토리에 insert
	// return : insert 성공시 1 
	int insertEmpPwHistory = EmpDAO.insertEmpPwHistory(empNo, empPw);
	System.out.println("insertEmpPwHistory : " + insertEmpPwHistory);
	if(insertEmpPwHistory == 0){
		System.out.println("pwHistory 등록 실패");
		String pwHistoryErrMsg = URLEncoder.encode("pwHistory 등록 실패. 다시 시도해주세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/empEditPwForm.jsp?pwHistoryErrMsg="+pwHistoryErrMsg);
		return;
	}
	
	
	// 현재 관리자의 비밀번호 업데이트 메서드
	// return : update 성공시 1 
	int updateEmpPw = EmpDAO.updateEmpPw(empNo, empPw);
	System.out.println("updateEmpPw : " + updateEmpPw);
	if(updateEmpPw == 1){
		System.out.println("비밀번호 업데이트 성공");
		String updatePwMsg = URLEncoder.encode("비밀번호 변경 성공.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/empOne.jsp?updatePwMsg="+updatePwMsg);
		return;
	}else{
		System.out.println("비밀번호 업데이트 실패");
		String updatePwMsg = URLEncoder.encode("비밀번호 변경 실패. 다시 시도해 주세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/empEditPwForm.jsp?updatePwMsg="+updatePwMsg);
		return;
	}
%>