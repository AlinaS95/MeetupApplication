package net.meetup.dao;

import net.meetup.bean.Admin;
import net.meetup.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AdminLoginDAO {

	public Admin checkAdminLogin(String email, String password) throws SQLException, ClassNotFoundException
	{
		String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
        String jdbcName = "root";
        String jdbcPassword = "";

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcURL, jdbcName, jdbcPassword);
        String sqlLogin = "SELECT * FROM admin WHERE email = ? and password = PASSWORD(?)";
        PreparedStatement statement = connection.prepareStatement(sqlLogin);
        statement.setString(1, email);
        statement.setString(2, password);

        ResultSet result = statement.executeQuery();

        Admin admin = null;
 
        if (result.next()) {
            admin = new Admin();
            admin.setID(result.getInt("id"));
            admin.setFirstName(result.getString("firstName"));
            admin.setLastName(result.getString("lastName"));
            admin.setEmail(email);
        }

        connection.close();
 
        return admin;
    }
}