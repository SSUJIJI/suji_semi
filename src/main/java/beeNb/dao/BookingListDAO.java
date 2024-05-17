package beeNb.dao;

import java.sql.*;
import java.util.*;

public class BookingListDAO {
	
	// 설명 : 숙소삭제를 위해 예약목록을 있는지 조회.
	// booking_state가 '전'인 것만 조회
	// 호출 : empRoomDeleteAction.jsp, customerRoomDeleteAction.jsp
	// return :
	public static int selectBookingList(int roomNo) throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql ="SELECT * FROM booking WHERE booking_state = '전' AND room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		System.out.println("stmt : " + stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = 1;
		}
		
		return row;
	}
	
	// 설명 : 해당 bookingNo의 예약 일자 리스트를 가져오는 메서드
	// 호출 : /customer/hostBookingDeleteAction.jsp
	// return : ArrayList<String> (roomDate list)
	public static ArrayList<HashMap<String, Object>> selectRoomDateListOfBookingNo(int bookingNo) throws Exception{
		ArrayList<HashMap<String, Object>> roomDateListOfBookingNo = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// 해당 bookingNo의 예약일자(roomDate) SELECT
		String sql = "SELECT room_date AS roomDate, room_no AS roomNo"
				+ " FROM booking_list"
				+ " WHERE booking_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, bookingNo);
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("roomNo", rs.getInt("roomNo"));
			m.put("roomDate", rs.getString("roomDate"));
			roomDateListOfBookingNo.add(m);
		}
		
		conn.close();
		return roomDateListOfBookingNo;
	}
}
