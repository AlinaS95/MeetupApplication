package net.meetup.workspace;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WorkspaceDAO {
	private String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
	private String jdbcName = "root";
	private String jdbcPassword = "";
	
	private static final String ADDMember_Workspace_SQL = "INSERT INTO workspace (fullName, email, workspace, position) VALUES (?,?,?,?)";
	private static final String SELECT_MemberWorkspace_BY_ID = "select workspaceID, fullName, email, workspace, position from user where workspaceID=?";
	
	public WorkspaceDAO() {}
	
	protected Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcURL, jdbcName, jdbcPassword);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return connection;
	}
		
	public int addMember(Workspace addWorkspace) throws SQLException {
		System.out.println("ADDMember_Workspace_SQL");
		
		int result = 0;
		// try-with-resource statement will auto close the connection
		try (Connection connection = getConnection();
			PreparedStatement statement = connection.prepareStatement(ADDMember_Workspace_SQL)) {
			statement.setString(1, addWorkspace.getFullName());
			statement.setString(2, addWorkspace.getEmail());
			statement.setString(3, addWorkspace.getWorkspace());
			statement.setString(4, addWorkspace.getPosition());
			
			System.out.println(statement);
			
			result = statement.executeUpdate();
			
		} catch (SQLException e) {
			printSQLException(e);
		}
		return result;
	}
	
	public Workspace selectMember(int workspaceID) {
        Workspace addWorkspace = null;
        // Step 1: Establishing a Connection
        try (Connection connection = getConnection();
            // Step 2:Create a statement using connection object
            PreparedStatement statement = connection.prepareStatement(SELECT_MemberWorkspace_BY_ID);) {
            statement.setInt(1, workspaceID);
            System.out.println(statement);
            // Step 3: Execute the query or update query
            ResultSet result = statement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (result.next()) {
                String fullName = result.getString("fullName");
                String email = result.getString("email");
                String workspace = result.getString("workspace");
                String position = result.getString("position");
                addWorkspace = new Workspace(workspaceID, fullName, email, workspace, position);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return addWorkspace;
    }
	
	private void printSQLException(SQLException ex) {
        for (Throwable e: ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
	}
}