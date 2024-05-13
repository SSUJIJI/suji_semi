<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<% 
	System.out.println("=====empEditPwForm.jsp=====");

	// 이미 사용했던 비밀번호 errMsg
	String usedPwMsg = request.getParameter("usedPwMsg");
	// 비밀번호 히스토리 등록 실패 errMsg
	String pwHistoryErrMsg = request.getParameter("pwHistoryErrMsg");
	// 비밀번호 변경 성공 Msg
	String updatePwMsg = request.getParameter("updatePwMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 비밀번호 수정</title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<!-- 메인작업 -->
		<form method="post" action="/BeeNb/emp/empEditPwAction.jsp">
			<input type="hidden" value="<%= loginEmp.get("empNo") %>" name="empNo">
			<table>
				<tr>
					<td>
						수정할 비밀번호 입력 : &nbsp;
					</td>
					<td>
						<input type="password" class="form-control" name="newEmpPw">
					</td>
					<td>
						&nbsp;&nbsp;<button type="submit" class="btn btn-warning">수정</button>
					</td>
					<td>
							<%
			                    if(usedPwMsg != null){
			                %>
			                        &nbsp;<%=usedPwMsg %>
			                <%
			                    }
			                %>
							<%
			                    if(updatePwMsg != null){
			                %>
			                        &nbsp;<%=updatePwMsg %>
			                <%
			                    }
			                %>
							<%
			                    if(pwHistoryErrMsg != null){
			                %>
			                        &nbsp;<%=pwHistoryErrMsg %>
			                <%
			                    }
			                %>
					</td>
				</tr>
			</table>
		</form>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</div>
</body>
</html>