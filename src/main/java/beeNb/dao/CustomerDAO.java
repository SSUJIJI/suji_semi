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
	 
      // 설명 : 비밀번호 재설정시 본인인증    
      // 호출 : /customer/customerAuthAction.jsp
      // return : boolean(일치하면 true, 불일치하면 false)
      public static boolean selectCustomerAuth (String customerId, String customerName, String customerPhone)throws Exception {
         boolean result = false; 
         Connection conn = DBHelper.getConnection();
         String sql = "SELECT customer_id, customer_name, customer_phone FROM customer WHERE customer_id = ? AND customer_name = ? And customer_phone = ?";
         PreparedStatement stmt = conn.prepareStatement(sql);
         stmt.setString(1, customerId);
         stmt.setString(2, customerName);
	     stmt.setString(3, customerPhone);
         // 디버깅
         System.out.println("stmt :" + stmt);
       
         ResultSet rs = stmt.executeQuery();
         if(rs.next()) {
        	 result = true;
	     }
	 	
	 	 conn.close();
	 	 return result;
       
     }
      
     // 설명 : 회원 ID 찾기
     // 호출 : /customer/customerFindIdAction.jsp
     // return : String(일치하면 회원ID, 불일치하면 공백)
      public static String customerCheckId(String customerName, String customerEmail) throws Exception {
		String result = "";
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT customer_id customerId FROM customer WHERE customer_name =? AND customer_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerName);
		stmt.setString(2,customerEmail);

		// 디버깅
		System.out.println("customerCheckId stmt :" + stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			result = rs.getString("customerId");
		}
		
		conn.close();
		return result;
		
	  }
      
      // 설명 : 고객 비밀번호 변경시 이전 비밀번호와 일치되는지 확인
      // 호출 : /customer/customerEditPwAction.jsp
      // return : boolean(불일치하면 true, 일치하면 false)
      public static boolean selectCustomerPwHistory(String customerId) throws Exception {
    	  boolean result = false;
    	  Connection conn = DBHelper.getConnection();
    	  String sql = "SELECT customer_pw FROM customer_pw_history WHERE customer_id = ?";
    	  PreparedStatement stmt = conn.prepareStatement(sql);
  		  stmt.setString(1,customerId);
  		  // 디버깅
  		  System.out.println("stmt :" + stmt);
  		  ResultSet rs = stmt.executeQuery();
  		  
  		  if(rs.next()) {
  			  result = false;
  		  }
  		  
  		  conn.close();
    	  return result;
      }
      
      // 설명 : 고객 테이블에서 비밀번호 변경
      // 호출 : /customer/customerEditPwAction.jsp
      // return : int
      public static int updateCustomerPw(String newCustomerPw, String customerId) throws Exception {
    	  int row = 0;
    	  Connection conn = DBHelper.getConnection();
    	  String sql = "UPDATE customer SET customer_pw = ? WHERE customer_id = ?";
    	  PreparedStatement stmt = conn.prepareStatement(sql);
    	  stmt.setString(1, newCustomerPw);
    	  stmt.setString(2, customerId);
    	  // 디버깅
    	  System.out.println("stmt: " + stmt);
    	  row = stmt.executeUpdate();
    	  
    	  conn.close();
    	  return row;
      }
      
      // 설명 : 고객 비밀번호 변경시 비밀번호 이력테이블에 변경비밀번호 추가
      // 호출 : /customer/customerEditPwAction.jsp
      // return : int
      public static int insertCustomerNewPwHistory(String newCustomerPw, String customerId) throws Exception{
    	  int row = 0;
    	  Connection conn = DBHelper.getConnection();
    	  String sql = "INSERT INTO customer_pw_history(customer_pw, customer_id, create_date) VALUES (?, ?, NOW())";
    	  PreparedStatement stmt = conn.prepareStatement(sql);
    	  stmt.setString(1, newCustomerPw);
    	  stmt.setString(2, customerId);
    	  // 디버깅
    	  System.out.println("stmt: " + stmt);
    	  row = stmt.executeUpdate();
    	  conn.close();
    	  return row;
      }
      
	   // 설명 : 고객(customer)정보 상세보기 & 정보수정
	   // 호출 : customerOne.jsp / customerUpdateForm.jsp
	   // return : HashMap
      public static HashMap<String, String> selectCustomerOne (String customerId) throws Exception {
  		HashMap<String, String> m  = null;	
  		Connection conn = DBHelper.getConnection();
  		String sql = "SELECT customer_id customerId, customer_email customerEmail, customer_name customerName, customer_birth customerBirth, "
  				+ " customer_phone customerPhone, customer_gender customerGender, create_date createDate, update_date updateDate FROM customer WHERE customer_id = ?";
  		PreparedStatement stmt = conn.prepareStatement(sql);
  		stmt.setString(1,customerId);
  		// 디버깅
  		System.out.println("stmt :" + stmt);
  		ResultSet rs = stmt.executeQuery();
  		
  		while(rs.next()){
  			m = new HashMap<String,String>();
  			m.put("customerId", rs.getString("customerId"));
  			m.put("customerEmail", rs.getString("customerEmail"));
  			m.put("customerName", rs.getString("customerName"));
  			m.put("customerBirth", rs.getString("customerBirth"));
  			m.put("customerPhone", rs.getString("customerPhone"));
  			m.put("customerGender", rs.getString("customerGender"));
  			m.put("createDate", rs.getString("createDate"));
  			m.put("updateDate", rs.getString("updateDate"));
  		}
			conn.close();
			return m;
	   }   
}
