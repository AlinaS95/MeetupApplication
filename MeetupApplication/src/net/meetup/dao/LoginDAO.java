package net.meetup.dao;

import net.meetup.bean.LoginBean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDAO {

	public LoginBean checkLogin(String email, String password) throws SQLException, ClassNotFoundException
	{
		String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
        String dbUser = "root";
        String dbPassword = "";
 
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String sql = "SELECT * FROM user WHERE email = ? and password = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, email);
        statement.setString(2, password);

        ResultSet result = statement.executeQuery();
        
        LoginBean loginBean = null;
 
        if (result.next()) {
            loginBean = new LoginBean();
            loginBean.setFirstName(result.getString("firstName"));
            loginBean.setLastName(result.getString("lastName"));
            loginBean.setEmail(email);
        }
 
        connection.close();
 
        return loginBean;
    }
}