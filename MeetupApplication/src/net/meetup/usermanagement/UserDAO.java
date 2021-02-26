package net.meetup.usermanagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import net.meetup.usermanagement.User;

public class UserDAO {

	public int registerUser(User user) throws ClassNotFoundException {
		String INSERT_USER_SQL = "INSERT INTO user" + "  (firstName, lastName, email, company, position, password) VALUES " + " (?,?,?,?,?,?);";
	
		int result = 0;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup","root","");
		
				// Step 2:Create a statement using connection object
				PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
				preparedStatement.setString(1, user.getFirstName());
				preparedStatement.setString(2, user.getLastName());
				preparedStatement.setString(3, user.getEmail());
				preparedStatement.setString(4, user.getCompany());
				preparedStatement.setString(5, user.getPosition());
				preparedStatement.setString(6, user.getPassword());

				System.out.println(preparedStatement);
				// Step 3: Execute the query or update query
				result = preparedStatement.executeUpdate();
				
		}	catch (SQLException e) {
			// process sql exception
			e.printStackTrace();
		}
		return result;
		}

}