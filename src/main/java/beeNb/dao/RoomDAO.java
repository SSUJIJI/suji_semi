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
		
		String sql = "SELECT r.room_no AS roomNo, r.customer_id AS customerId, r.room_name AS roomName, r.room_theme AS roomTheme, r.room_address AS roomAddress,"
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
			hostRoomOne.put("customerId", rs.getString("customerId"));
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
	
	// 설명 : 숙소 등록
	// 호출 : addRoomAction.jsp
	// return int
	public static int insertRoom(HashMap<String, Object> map) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO "
				+ "room ("
				+ "room_no"
				+ ", customer_id"
				+ ", room_name"
				+ ", room_theme"
				+ ", room_address"
				+ ", operation_start"
				+ ", operation_end"
				+ ", max_people"
				+ ", room_content"
				+ ", room_category"
				+ ", approve_state) VALUES "
				+ "(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, '미승인')";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ""+map.get("customerId"));
		stmt.setString(2, ""+map.get("roomName"));
		stmt.setString(3, ""+map.get("roomTheme"));
		stmt.setString(4, ""+map.get("roomAddress"));
		stmt.setString(5, ""+map.get("operationStart"));
		stmt.setString(6, ""+map.get("operationEnd"));
		stmt.setInt(7, Integer.parseInt(""+map.get("maxPeople")));
		stmt.setString(8, ""+map.get("roomContent"));
		stmt.setString(9, ""+map.get("roomCategory"));
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	// 설명 : 숙소 찾기 by ID
	// 호출 : addRoomAction.jsp
	// return int
	public static int selectRoomById(String customerId) throws Exception {
		int roomNo = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT room_no FROM room WHERE customer_id = ? ORDER BY room_no DESC LIMIT 0, 1";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			roomNo = rs.getInt("room_no");
		}
		return roomNo;
	}
	// 설명 : 숙소 등록
	// 호출 : addRoomAction.jsp
	// return int
	public static int insertRoomOption(HashMap<String, Object> map) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO "
				+ "room_option ("
				+ "room_no"
				+ ", wifi"
				+ ", kitchen_tools"
				+ ", parking"
				+ ", bed"
				+ ", ott"
				+ ", ev) VALUES "
				+ "(?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, Integer.parseInt(""+map.get("roomNo")));
		stmt.setString(2, ""+map.get("wifi"));
		stmt.setString(3, ""+map.get("kitshenTools"));
		stmt.setString(4, ""+map.get("parking"));
		stmt.setString(5, ""+map.get("bed"));
		stmt.setString(6, ""+map.get("ott"));
		stmt.setString(7, ""+map.get("ev"));
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	// 설명 : room중에서 state가 미승인, 재승인 목록 불러오기
	// 호출 : pendingRoomList.jsp
	// return ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> selectPendingRoomList() throws Exception {
		ArrayList<HashMap<String, Object>> selectPendingRoomList = new ArrayList<HashMap<String, Object>>();
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT room_no AS roomNo, customer_id AS customerId,"
				+ " room_name AS roomName, approve_state AS approveState"
				+ " FROM room"
				+ " WHERE approve_state = '미승인' OR"
				+ " approve_state = '재승인'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("roomNo",rs.getInt("roomNo"));
			m.put("customerId",rs.getString("customerId"));
			m.put("roomName",rs.getString("roomName"));
			m.put("approveState",rs.getString("approveState"));
			selectPendingRoomList.add(m);
		}
		
		conn.close();
		return selectPendingRoomList;
	}
	
	// 설명 : 해당 roomNo의 approve_state를 '승인'으로 업데이트
	// 호출 : approveRoomAction.jsp
	// return : int
	public static int updateRoomStateApprove(int roomNo) throws Exception{
		int ApproveResult = 0;
		Connection conn = DBHelper.getConnection();
		
		// 쿼리
		String sql = "UPDATE room SET approve_state = '승인' WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		
		// 완성 쿼리 디버깅
		System.out.println("stmt: " + stmt);
		
		// 쿼리 실행
		ApproveResult = stmt.executeUpdate();
				
		// 자원반납
		conn.close();		
		return ApproveResult;
	}

	
	// 설명 : 해당 roomNo의 approve_state를 '반려'으로 업데이트
	// 호출 : rejectRoomAction.jsp
	// return : int
	public static int updateRoomStateReject(int roomNo) throws Exception{
		int rejectResult = 0;
		Connection conn = DBHelper.getConnection();
		
		// 쿼리
		String sql = "UPDATE room SET approve_state = '반려' WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		
		// 완성 쿼리 디버깅
		System.out.println("stmt: " + stmt);
		
		// 쿼리 실행
		rejectResult = stmt.executeUpdate();
		
		// 자원반납
		conn.close();
		
		return rejectResult;
	}
	
	// 설명 : 고객(호스트) 탈퇴 전 등록한 숙소가 있는지 확인
	// 호출 : /customer/customerDropCheckPwForm.jsp
	// 리턴값 : boolean (false 숙소가 존재, true면 숙소가 미존재)
	public static boolean selectRoomListDrop(String customerId) throws Exception {
		boolean result = true;
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT * "
				+ "FROM customer c INNER JOIN room r "
				+ "ON c.customer_id = r.customer_id "
				+ "WHERE c.customer_id = ? ";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		
		// 디버깅코드
		System.out.println("stmt :" + stmt);

		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			result = false;
		}

		conn.close();
		return result;
	}
	
	public static HashMap<String, String> selectRoomOne(int roomNo) throws Exception{
		HashMap<String, String> resultMap = new HashMap<>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT "
				+ "	r.room_no AS roomNo "
				+ "    , r.room_name AS roomName "
				+ "    , r.room_theme AS roomTheme "
				+ "    , r.room_address AS roomAddress "
				+ "    , r.operation_start AS operationStart "
				+ "    , r.operation_end AS operationEnd "
				+ "    , r.max_people AS maxPeople "
				+ "    , r.room_content AS roomContent "
				+ "    , r.room_category AS roomCategory "
				+ "    , r.approve_state AS approveState "
				+ "    , r.create_date AS createDate "
				+ "    , r.update_date AS updateDate "
				+ "    , o.bed bed"
				+ "    , o.ev ev"
				+ "    , o.kitchen_tools kitchenTools"
				+ "    , o.ott ott"
				+ "    , o.parking parking"
				+ "    , o.wifi wifi"
				+ "     "
				+ "FROM  "
				+ "	room AS r INNER JOIN room_option AS o "
				+ "	ON r.room_no = o.room_no "
				+ "WHERE r.room_no = ?";  
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMap.put("roomNo", rs.getString("roomNo"));
			resultMap.put("roomName", rs.getString("roomName"));
			resultMap.put("roomTheme", rs.getString("roomTheme"));
			resultMap.put("roomAddress", rs.getString("roomAddress"));
			resultMap.put("operationStart", rs.getString("operationStart"));
			resultMap.put("operationEnd", rs.getString("operationEnd"));
			resultMap.put("maxPeople", rs.getString("maxPeople"));
			resultMap.put("roomContent", rs.getString("roomContent"));
			resultMap.put("roomCategory", rs.getString("roomCategory"));
			resultMap.put("approveState", rs.getString("approveState"));
			resultMap.put("bed", rs.getString("bed"));
			resultMap.put("ev", rs.getString("ev"));
			resultMap.put("kitchenTools", rs.getString("kitchenTools"));
			resultMap.put("ott", rs.getString("ott"));
			resultMap.put("parking", rs.getString("parking"));
			resultMap.put("wifi", rs.getString("wifi"));	
		}
		return resultMap;
	}
}