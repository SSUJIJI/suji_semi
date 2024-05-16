package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class OneDayPriceDAO {
	// 설명 : 해당 숙소의 가격 조회(매 일마다 책정된 모든 금액)]
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
	
	// 설명 : 해당 숙소의 해당 날짜에 가격 등록
	// 호출 : addOneDayPriceAction.jsp
	// return : int (등록 성공시 등록 개수만큼, 실패시 0)
	public static int insertOneDayPrice(int roomNo, String[] roomDate, int roomPrice) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// oneday_price 테이블에 INSERT 쿼리
		String sql = "INSERT INTO oneday_price(room_no, room_date, room_price) VALUES(?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		// roomDate의 개수만큼 INSERT 쿼리 반복실행
		for(int i = 0; i < roomDate.length; i++) {
			stmt.setInt(1, roomNo);
			stmt.setString(2, roomDate[i]);
			stmt.setInt(3, roomPrice);
			// 실행된 쿼리 수 계산
			row += stmt.executeUpdate();
		}
		
		conn.close();
		return row;
	}
	
	// 설명 : 해당 숙소의 해당 날짜에 등록된 가격 삭제
	// 호출 : hostRoomOne.jsp
	// return : int (삭제시 1, 실패시 0)
	public static int deleteOneDayPrice(int roomNo, String roomDate) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// oneday_price 테이블에 DELETE쿼리
		String sql = "DELETE FROM oneday_price WHERE room_no = ? AND room_date = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		stmt.setString(2, roomDate);
		
		row = stmt.executeUpdate();		
		
		conn.close();
		return row;
	}
}
