package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class EmpDAO {
	// 설명 : emp테이블의 전체 행 개수 구하는 메서드(emp 리스트 출력 시 페이징하기 위해)
	// 호출 : /emp/empList.jsp
	// return : int (emp 테이블 행 개수)
	public static int selectEmpListCnt() throws Exception {
		// emp테이블의 전체 행 개수를 담을 변수
		int cnt = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// emp 테이블로부터 전체 행 COUNT하는 쿼리
		String sql = "SELECT COUNT(*) cnt FROM emp";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		// SELECT 결과가 있다면
		if(rs.next()) {
			// SELECT 결과 값 담기
			cnt = rs.getInt("cnt");
		}
		
		conn.close();
		return cnt;
	}
	
	// 설명 : emp테이블에서 전체 emp를 출력(페이징 포함, 이름 검색 포함)
	public static ArrayList<HashMap<String, Object>> selectEmpList(String searchWord, int startRow, int rowPerPage) throws Exception{
		// SELECT 결과 값을 담을 List
		ArrayList<HashMap<String, Object>> empList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("empNo", rs.getInt("empNo"));
			m.put("empName", rs.getString("empName"));
			m.put("empPhone", rs.getString("empPhone"));
			m.put("empBirth", rs.getString("empBirth"));
			m.put("createDate", rs.getString("createDate"));
		}
		
		conn.close();
		return empList;
	}
}
