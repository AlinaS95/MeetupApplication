package net.meetup.dao;
import net.meetup.bean.RegisterBean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class RegisterDAO {

	public String authorizeRegister(RegisterBean registerBean) {
		
		String firstName = registerBean.getFirstName();
		String lastName = registerBean.getLastName();
		String email = registerBean.getEmail();
		String company = registerBean.getCompany();
		String position = registerBean.getPosition();
		String password = registerBean.getPassword();
		
		String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
		String jdbcName = "root";
		String jdbcPassword = "";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(jdbcURL, jdbcName, jdbcPassword);
			
			PreparedStatement statement=null;
			
			statement = con.prepareStatement("INSERT INTO user (firstName, lastName, email, company, position, password) VALUES (?,?,?,?,?,?)");
			statement.setString(1, firstName);
			statement.setString(2, lastName);
			statement.setString(3, email);
			statement.setString(4, company);
			statement.setString(5, position);
			statement.setString(6, password);
			statement.executeUpdate();
			
			statement.close();
			
			con.close();
			
			return "SUCCESS REGISTER";
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return "FAIL REGISTER";
	}
}