package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class RoomDAO {
	// 설명 : room테이블에서 전체 room을 출력
	// 호출 : /emp/roomList.jsp, /customer/roomList.jsp
	// return : ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> selectRoomList() throws Exception {
		// SELECT 결과 값을 담을 List
		ArrayList<HashMap<String, Object>> RoomList = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT r.room_no, r.customer_id, r.room_name, r.room_address, r.max_people, img.room_img"
				+ " FROM room AS r"
				+ " INNER JOIN room_img AS img"
				+ " ON r.room_no =  img.room_no";

		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("roomNo",rs.getInt("r.room_no"));
			m.put("customerId",rs.getString("r.customer_id"));
			m.put("roomName",rs.getString("r.room_name"));
			m.put("roomAddress",rs.getString("r.room_address"));
			m.put("maxPeople",rs.getInt("r.max_people"));
			m.put("roomImg",rs.getString("img.room_img"));
			RoomList.add(m);
		}
		
		conn.close();
		return RoomList;
	}
	
	// 설명 : 호스트가 호스팅한 숙소 목록 출력
	// 호출 : /customer/hostRoomList.jsp
	// return : ArrayList<HashMap<String, Object>> hostRoomList
	public static ArrayList<HashMap<String, Object>> selectHostRoomList(String customerId) throws Exception {
		// 해당 호스트의 숙소 목록을 담는 리스트
		ArrayList<HashMap<String, Object>> hostRoomList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// 해당 호스트의 아이디(customerId)에 해당하는 room 테이블의 room SELECT하는 쿼리
		String sql = "SELECT r.room_no AS roomNo, r.room_name AS roomName, r.room_address AS roomAddress, r.operation_start AS operationStart,"
				+ " r.operation_end AS operationEnd, r.room_category AS roomCategory, img.room_img AS roomImg"
				+ " FROM room AS r INNER JOIN room_img AS img"
				+ " ON r.room_no = img.room_no"
				+ " WHERE customer_id = ?"
				+ " ORDER BY roomNo DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("roomNo", rs.getInt("roomNo"));
			m.put("roomName", rs.getString("roomName"));
			m.put("roomAddress", rs.getString("roomAddress"));
			m.put("operationStart", rs.getString("operationStart"));
			m.put("operationEnd", rs.getString("operationEnd"));
			m.put("roomCategory", rs.getString("roomCategory"));
			m.put("roomImg", rs.getString("roomImg"));
			hostRoomList.add(m);
		}
		
		conn.close();
		return hostRoomList;
	}
	
	// 설명 : 호스트의 호스팅한 숙소 1개에 대한 상세 정보 조회
	// 호출 : /customer/hostRoomOne.jsp
	// return : HashMap<String, Object> hostRoomOne
	public static HashMap<String, Object> selectHostRoomOne(int roomNo) throws Exception{
		HashMap<String, Object> hostRoomOne = new HashMap<>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT r.room_no AS roomNo, r.room_name AS roomName, r.room_theme AS roomTheme, r.room_address AS roomAddress,"
				+ " r.operation_start AS operationStart, r.operation_end AS operationEnd, r.max_people AS maxPeople, r.room_content AS roomContent,"
				+ " r.room_category AS roomCategory, r.approve_state AS approveState, r.create_date AS createDate, r.update_date AS updateDate, img.room_img AS roomImg"
				+ " FROM room AS r INNER JOIN room_img AS img"
				+ " ON r.room_no = img.room_no"
				+ " WHERE r.room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			hostRoomOne.put("roomNo", rs.getInt("roomNo"));
			hostRoomOne.put("roomName", rs.getString("roomName"));
			hostRoomOne.put("roomTheme", rs.getString("roomTheme"));
			hostRoomOne.put("roomAddress", rs.getString("roomAddress"));
			hostRoomOne.put("operationStart", rs.getString("operationStart"));
			hostRoomOne.put("operationEnd", rs.getString("operationEnd"));
			hostRoomOne.put("maxPeople", rs.getInt("maxPeople"));
			hostRoomOne.put("roomContent", rs.getString("roomContent"));
			hostRoomOne.put("roomCategory", rs.getString("roomCategory"));
			hostRoomOne.put("approveState", rs.getString("approveState"));
			hostRoomOne.put("createDate", rs.getString("createDate"));
			hostRoomOne.put("updateDate", rs.getString("updateDate"));
			hostRoomOne.put("roomImg", rs.getString("roomImg"));
		}
		
		conn.close();
		return hostRoomOne;
	}
	
	// 설명 : 숙소 삭제
	// 호출 : empRoomDeleteAction.jsp, customerDeleteAction.jsp
	// return int
	public static int deleteRoom(int roomNo) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		String sql="DELETE FROM room WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		
		// 쿼리 디버깅
		System.out.println("stmt : " + stmt);
		
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		// 자원반납
		conn.close();
		return row;
	}
}