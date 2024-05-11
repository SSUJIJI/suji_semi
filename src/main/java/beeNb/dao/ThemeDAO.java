package beeNb.dao;

import java.sql.*;
import java.util.*;

public class ThemeDAO {
	// 테마리스트를 출력하는 메서드
	// 호출 : /emp/themeList.jsp, /emp/inc/empNavbar.jsp, /customer/inc/customerNavbar.jsp
	// return : ArrayList<String>
	public static ArrayList<String> selectThemeList() throws Exception{
		ArrayList<String> themeList = new ArrayList<String>();
		
		Connection conn = DBHelper.getConnection();
		
		// 테마리스트를 출력하는 메서드
		String sql = "SELECT room_theme FROM room_theme";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			String theme = rs.getString("room_theme");
			themeList.add(theme);
		}
		
		conn.close();
		return themeList;
	}
}
