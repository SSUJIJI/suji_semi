package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class OneDayPriceDAO {
	// 설명 : 해당 숙소의 요금 조회(매 일마다 책정된 모든 금액)]
	// 호출 : hostRoomOne.jsp
	// return : ArrayList<HashMap<String, Object>> oneDayPriceList
	public static ArrayList<HashMap<String, Object>> selectOneDayPriceList(int roomNo) throws Exception{
		ArrayList<HashMap<String, Object>> oneDayPriceList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// 해당 roomNo를 조건으로 onedayPrice의 데이터 SELECT 
		String sql = "SELECT room_date AS roomDate, room_price AS roomPrice, room_state AS roomState, create_date AS createDate, update_date AS updateDate"
				+ " FROM oneday_price"
				+ " WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("roomDate", rs.getString("roomDate"));
			m.put("roomPrice", rs.getString("roomPrice"));
			m.put("roomState", rs.getString("roomState"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			oneDayPriceList.add(m);
		}
		
		conn.close();
		return oneDayPriceList;
	}
}
