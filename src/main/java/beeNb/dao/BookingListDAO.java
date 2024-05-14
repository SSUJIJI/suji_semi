package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}
