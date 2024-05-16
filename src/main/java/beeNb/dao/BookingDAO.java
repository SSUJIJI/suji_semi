package beeNb.dao;

import java.sql.*;
import java.util.*;

public class BookingDAO {
	// 설명 : 고객의 사용 전 예약 리스트 
	// 호출 : /customer/customerBookingList.jsp
	// return : ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String,Object>> selectBeforeList(String customerId) throws Exception {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT a.booking_no bookingNo, a.customer_id customerId, r.room_name roomName, "
				+ "r.room_address roomAddress, a.booking_state bookingState, a.create_date createDate, a.startRoomDate, a.endRoomDate "
				+ "FROM (SELECT b.room_no, b.booking_no, b.booking_state, b.customer_id, b.create_date, "
				+ "MIN(bl.room_date) startRoomDate, MAX(bl.room_date) endRoomDate "
				+ "FROM booking b INNER JOIN booking_list bl "
				+ "ON b.booking_no = bl.booking_no "
				+ "WHERE b.booking_state IN ('전') AND b.customer_id = ? "
				+ "GROUP BY b.booking_no, b.booking_state, b.customer_id, b.room_no) a INNER JOIN room r "
				+ "ON a.room_no = r.room_no "
				+ "ORDER BY bookingNo asc ";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		
		//디버깅 코드
		System.out.println("stmt : " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("bookingNo",rs.getInt("bookingNo"));
			m.put("customerId",rs.getString("customerId"));
			m.put("roomName",rs.getString("roomName"));
			m.put("roomAddress",rs.getString("roomAddress"));
			m.put("bookingState",rs.getString("bookingState"));
			m.put("createDate",rs.getString("createDate"));
			m.put("startRoomDate",rs.getString("startRoomDate"));
			m.put("endRoomDate",rs.getString("endRoomDate"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	// 설명 : 고객의 사용 후 예약 리스트 
	// 호출 : /customer/customerBookingList.jsp
	// return : ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String,Object>> selectAfterList(String customerId, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT a.booking_no bookingNo, a.customer_id customerId, r.room_name roomName, "
				+ "r.room_address roomAddress, a.booking_state bookingState, a.create_date createDate, a.startRoomDate, a.endRoomDate "
				+ "FROM (SELECT b.room_no, b.booking_no, b.booking_state, b.customer_id, b.create_date, "
				+ "MIN(bl.room_date) startRoomDate, MAX(bl.room_date) endRoomDate "
				+ "FROM booking b INNER JOIN booking_list bl "
				+ "ON b.booking_no = bl.booking_no "
				+ "WHERE b.booking_state IN ('후','리뷰완료') AND b.customer_id = ? "
				+ "GROUP BY b.booking_no, b.booking_state, b.customer_id, b.room_no) a INNER JOIN room r "
				+ "ON a.room_no = r.room_no "
				+ "ORDER BY bookingNo asc "
				+ "LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		
		//디버깅 코드
		System.out.println("stmt : " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("bookingNo",rs.getInt("bookingNo"));
			m.put("customerId",rs.getString("customerId"));
			m.put("roomName",rs.getString("roomName"));
			m.put("roomAddress",rs.getString("roomAddress"));
			m.put("bookingState",rs.getString("bookingState"));
			m.put("createDate",rs.getString("createDate"));
			m.put("startRoomDate",rs.getString("startRoomDate"));
			m.put("endRoomDate",rs.getString("endRoomDate"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	// 설명 : 고객의 사용 후 예약 리스트 행의 총 개수
	// 호출 : /customer/customerBookingList.jsp
	// return : int
	public static int selectAfterBookingListCnt(String customerId) throws Exception {
		int total = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT COUNT(*) cnt "
				+ "FROM(SELECT b.room_no, b.booking_no, b.booking_state, b.customer_id, b.create_date, "
				+ "MIN(bl.room_date) startRoomDate, MAX(bl.room_date) endRoomDate "
				+ "FROM booking b INNER JOIN booking_list bl "
				+ "ON b.booking_no = bl.booking_no "
				+ "WHERE b.booking_state IN ('후','리뷰완료') AND b.customer_id = ? "
				+ "GROUP BY b.booking_no, b.booking_state, b.customer_id, b.room_no) a INNER JOIN room r "
				+ "ON a.room_no = r.room_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		//디버깅 코드
		System.out.println("stmt: " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			total = rs.getInt("cnt");
		}
		
		conn.close();
		return total;
	}
	// 설명 : 고객이 이용 전 예약 취소 기능
	// 호출 : /customer/customerBookingList.jsp
	// return : int
	public static int deleteBooking(int bookingNo, String customerId) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "DELETE booking, booking_list "
				+ "FROM booking "
				+ "INNER JOIN booking_list ON booking.booking_no = booking_list.booking_no "
				+ "WHERE booking.customer_id = ? "
				+ "AND booking.booking_state = '전' "
				+ "AND booking.booking_no = ? "
				+ "AND DATEDIFF(booking_list.room_date, CURDATE()) > 3";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerId);
		stmt.setInt(2, bookingNo);
		
		System.out.println("stmt : " + stmt);
		
		row = stmt.executeUpdate();
	
		conn.close();
		return row;
	}
}
