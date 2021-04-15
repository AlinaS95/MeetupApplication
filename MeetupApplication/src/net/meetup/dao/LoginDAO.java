package net.meetup.dao;

import net.meetup.bean.User;
import net.meetup.utils.JDBCUtils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LoginDAO {

	public String checkLogin(User user) throws SQLException, ClassNotFoundException
	{
		/*String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
        String jdbcName = "root";
        String jdbcPassword = "";
 
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcURL, jdbcName, jdbcPassword);
        
        String sqlLogin = "SELECT * FROM user WHERE email = ? and password = ? and workspace = ?";
        
        PreparedStatement statement = connection.prepareStatement(sqlLogin);*/
        
        String email = user.getEmail();
        String password = user.getPassword();
        String workspace = user.getWorkspace();
        String firstName = user.getFirstName();
        String lastName = user.getLastName();
        String company = user.getCompany();
        String position = user.getPosition();
        
        Connection con = null;
        Statement statement = null;
        ResultSet resultSet = null;
        
        String emailDB = "";
        String passwordDB = "";
        String workspaceDB = "";
        String positionDB = "";
        
       try {
           con = JDBCUtils.getConnection();
           statement = con.createStatement();
           resultSet = statement.executeQuery("select * from user");
           
           while(resultSet.next()){
        	   emailDB = resultSet.getString("email");
        	   passwordDB = resultSet.getString("password");
        	   workspaceDB = resultSet.getString("workspace");
        	   positionDB = resultSet.getString("position");
        	   
        	   if(email.equals(emailDB) && password.equals(passwordDB) && workspace.equals(workspaceDB) && position.equals("Admin"))
        		   return "Admin_Role";
        	   else if(email.equals(emailDB) && password.equals(passwordDB) && workspace.equals(workspaceDB) && position.equals("User"))
        		   return "User_Role";
           }
       }
       catch(SQLException e)
       {
    	   e.printStackTrace();
       }
       return "Invalid user credentials";
	}
}