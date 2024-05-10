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
}