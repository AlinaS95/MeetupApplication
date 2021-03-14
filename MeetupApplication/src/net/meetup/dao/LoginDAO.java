package net.meetup.dao;

import net.meetup.bean.User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDAO {

	public User checkLogin(String email, String password, String workspace) throws SQLException, ClassNotFoundException
	{
		String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
        String jdbcName = "root";
        String jdbcPassword = "";
 
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcURL, jdbcName, jdbcPassword);
        String sqlLogin = "SELECT * FROM user WHERE email = ? and password = ? and workspace = ?";
        PreparedStatement statement = connection.prepareStatement(sqlLogin);
        statement.setString(1, email);
        statement.setString(2, password);
        statement.setString(3, workspace);

        ResultSet result = statement.executeQuery();
        
        User user = null;
 
        if (result.next()) {
            user = new User();
            user.setUserID(result.getInt("userID"));
            user.setFirstName(result.getString("firstName"));
            user.setLastName(result.getString("lastName"));
            user.setEmail(email);
            user.setCompany(result.getString("company"));
            user.setWorkspace(result.getString("workspace"));
        }
 
        connection.close();
 
        return user;
    }
}