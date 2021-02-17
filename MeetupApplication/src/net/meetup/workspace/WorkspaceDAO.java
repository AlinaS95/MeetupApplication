package net.meetup.workspace;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import net.meetup.workspace.Workspace;

public class WorkspaceDAO {
	
	public int registerUser(Workspace workspace) throws ClassNotFoundException {
		String INSERT_WORKSPACE_SQL = "INSERT INTO workspace" + " (teamName, fullName, email) VALUES " + " (?,?,?);";
	
	int result = 0;
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup","root","");
			
			// Step 2:Create a statement using connection object
			PreparedStatement preparedStatement = connection.prepareStatement(INSERT_WORKSPACE_SQL)) {
			preparedStatement.setString(1, workspace.getTeamName());
			preparedStatement.setString(2, workspace.getFullName());
			preparedStatement.setString(3, workspace.getEmail());
			
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
