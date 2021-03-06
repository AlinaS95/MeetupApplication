package net.meetup.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import net.meetup.bean.User;

public class ManagementDAO {

	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup");
		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}

	public static int update(User user) {
		int status = 0;
		try {
			Connection connection = getConnection();
			PreparedStatement statement = connection.prepareStatement("update user set firstName=?,lastName=?,email=?,company=?,position=?,password=? where userID=?");
			statement.setString(1, user.getFirstName());
			statement.setString(2, user.getLastName());
			statement.setString(3, user.getEmail());
			statement.setString(4, user.getCompany());
			statement.setString(5, user.getPosition());
			statement.setString(6, user.getPassword());
			statement.setInt(7, user.getUserID());
			status = statement.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
		return status;
	}

	public static int delete(User user) {
		int status = 0;
		try {
			Connection connection = getConnection();
			PreparedStatement statement = connection.prepareStatement("delete from user where userID=?");
			statement.setInt(1, user.getUserID());
			status = statement.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}

		return status;
	}
	public static List<User> getRecordById(){  
	    List<User> list=new ArrayList<User>();  
	      
	    try{  
	        Connection connection=getConnection();  
	        PreparedStatement statement=connection.prepareStatement("select * from user where userID=?");  
	        ResultSet result=statement.executeQuery();  
	        while(result.next()){  
	        	User user = new User();
				user.setUserID(result.getInt("userID"));
				user.setFirstName(result.getString("firstName"));
				user.setLastName(result.getString("lastName"));
				user.setEmail(result.getString("email"));
				user.setCompany(result.getString("company"));
				user.setPosition(result.getString("position")); 
	            list.add(user);  
	        }  
	    }catch(Exception e){System.out.println(e);}  
	    return list;  
	}  
	public static User getRecordById(int userID) {
		User user = null;
		try {
			Connection connection = getConnection();
			PreparedStatement statement = connection.prepareStatement("select * from user where userID=?");
			statement.setInt(1, userID);
			ResultSet result = statement.executeQuery();
			while (result.next()) {
				user = new User();
				user.setUserID(result.getInt("userID"));
				user.setFirstName(result.getString("firstName"));
				user.setLastName(result.getString("lastName"));
				user.setEmail(result.getString("email"));
				user.setCompany(result.getString("company"));
				user.setPosition(result.getString("position"));
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return user;
	}
}