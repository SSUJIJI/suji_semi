package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class RoomImgDAO {
	// 설명 : 숙소 옵션 등록
	// 호출 : addRoomAction.jsp
	// return int
	public static int insertRoomImg(ArrayList<HashMap<String, Object>> imgList) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO "
				+ "room_img ("
				+ "room_img"
				+ ", room_no) VALUES "
				+ "(?, ?)";
		for(HashMap<String, Object> imgMap : imgList) {
			System.out.println("imgMap : " + imgMap);
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ""+imgMap.get("filename"));
			stmt.setInt(2, Integer.parseInt(""+imgMap.get("roomNo")));
			row = stmt.executeUpdate();
		}
		conn.close();
		return row;
	}

}
