package beeNb.dao;

import java.sql.*;
import java.util.*;

public class CustomerDAO {
	// 설명 : 고객의 회원가입 메서드
	// 호출 : /customer/customerSignUpAction.jsp
	// return : int row
	public static int insertCustomer(String customerId, String customerPw,
									String customerEmail, String customerName,
									String customerBirth, String customerPhone, String customerGender) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO customer(customer_id, customer_pw, customer_email, customer_name,"
				+ " customer_birth, customer_phone, customer_gender, customer_grade, create_date, update_date) "
				+ " VALUES(?, ?, ?, ?, ?, ?, ?, '0', NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setString(2, customerPw);
		stmt.setString(3, customerEmail);
		stmt.setString(4, customerName);
		stmt.setString(5, customerBirth);
		stmt.setString(6, customerPhone);
		stmt.setString(7, customerGender);
		// 디버깅
		System.out.println("stmt : " + stmt);
		row = stmt.executeUpdate();

		
		conn.close();
		return row;
		
	}
	// 설명 : 고객이 회원가입시 pw_history에 들어가는 메소드
	// 호출 : /customer/customerSignUpAction.jsp
	// return : int row
	public static int insertCustomerPwHistory(String customerId, String customerPw) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO customer_pw_history(customer_pw, customer_id, create_date)"
				+ " VALUES(?, ?, NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerPw);
		stmt.setString(2, customerId);
		// 디버깅
		System.out.println("stmt : " + stmt);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// 설명 : 고객 로그인 Action
    // 호출 : /customer/customerLoginAction.jsp
    // return : HashMap(Id,Pw)
    public static HashMap<String, String> loginCustomer (String customerId, String customerPw)
          throws Exception {
       HashMap<String, String > map = null;
       Connection conn = DBHelper.getConnection();
       String sql = "SELECT customer_id, customer_pw FROM customer WHERE customer_id =? AND customer_pw =?";
       PreparedStatement stmt = conn.prepareStatement(sql);
       stmt.setString(1, customerId);
       stmt.setString(2, customerPw);
       // 디버깅
       System.out.println("stmt :" + stmt);
       
       ResultSet rs = stmt.executeQuery();
       if(rs.next()) {
          map = new HashMap<String, String>();
          map.put("customerId", rs.getString("customer_id"));
          map.put("customerPw", rs.getString("customer_pw"));
       }
       conn.close();
       return map;
       
    }
    
	 // 설명 : 고객 회원가입시 아이디 중복 확인 
	 // 호출 : /customer/customerCheckId.jsp
	 // return : boolean (사용가능하면 true, 불가능하면 false)
	 public static boolean customerCheckId(String customerId) throws Exception {
	 	boolean result = false;
	 	Connection conn = DBHelper.getConnection();
	 	String sql = "SELECT customer_id FROM customer WHERE customer_id = ?";
	 	PreparedStatement stmt = conn.prepareStatement(sql);
	 	stmt.setString(1,customerId);
	 	// 디버깅
	 	System.out.println("stmt :" + stmt);
	 	ResultSet rs = stmt.executeQuery();
	 	
	 	if(!rs.next()) {
	 		result = true;
	 	}
	 	
	 	conn.close();
	 	return result;

	 }
}
