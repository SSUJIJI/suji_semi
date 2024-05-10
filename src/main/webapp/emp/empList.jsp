<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beeNb.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("========== empList.jsp ==========");
	
	// 이름으로 emp를 검색하기위해 searchWord 요청값(SELECT에서 LIKE 절에 사용하기 위해)
	String searchWord = "";
    if(request.getParameter("searchWord") != null) {
    	searchWord = request.getParameter("searchWord");
    }
	// 디버깅
	System.out.println("searchWord : " + searchWord);
	
	
	// 현재 페이지 구하기
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 emp 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// emp 테이블의 전체 행 개수
	int empListTotalRow = EmpDAO.selectEmpListCnt();
	// 디버깅
	System.out.println("empListTotalRow : " + empListTotalRow);
	
	
	// 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - emp 테이블 전체 행을 페이지당 보여줄 emp 행의 개수로 나눈 값
	int lastPage = empListTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 emp 행을 보여주기 위해 lastPage 에 +1하기
	if(empListTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	
	// emp 이름 검색, 페이징을 포함한 emp 목록 리스트
	ArrayList<HashMap<String, Object>> empList = EmpDAO.selectEmpList(searchWord, startRow, rowPerPage);
	// 디버깅
	System.out.println("empList : " + empList);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		<table>
			<tr>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
			</tr>
		</table>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>