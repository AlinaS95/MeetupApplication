package net.meetup.dao;

import net.meetup.bean.LoginBean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO {

	public String authorizeLogin(LoginBean loginBean)
	{
		String email=loginBean.getEmail();
		String password=loginBean.getPassword();
		
		String dbEmail="";
		String dbPassword="";
		
		String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
		String jdbcName = "root";
		String jdbcPassword = "";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(jdbcURL, jdbcName, jdbcPassword);
			
			PreparedStatement statement=null;
			
			statement = con.prepareStatement("select * from user where email=? and password=?");
			statement.setString(1, email);
			statement.setString(2, password);
			ResultSet rs=statement.executeQuery();
			
			while(rs.next())
			{
				dbEmail=rs.getString("email");
				dbPassword=rs.getString("password");
				
				if(email.equals(dbEmail) && password.equals(dbPassword))
					{
					return "SUCCESS LOGIN";
					}
			}
			statement.close();
			con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return "WRONG Email and Password";
	}
}