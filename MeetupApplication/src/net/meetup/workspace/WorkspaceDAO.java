package net.meetup.workspace;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import net.meetup.workspace.Workspace;

public class WorkspaceDAO {
	private String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
	private String jdbcUsername = "root";
	private String jdbcPassword = "";

	private static final String INSERT_WORKSPACE_SQL = "INSERT INTO workspace" + "  (teamName, fullName, email) VALUES "
			+ " (?, ?, ?);";

	private static final String SELECT_WORKSPACE_BY_ID = "select workspaceID, teamName, fullName, email from workspace where workspaceID =?";
	private static final String SELECT_ALL_WORKSPACES = "select * from workspace";
	private static final String DELETE_WORKSPACE_SQL = "delete from workspace where workspaceID = ?;";
	private static final String UPDATE_WORKSPACE_SQL = "update workspace set teamName = ?, fullName= ?, email= ? where workspaceID = ?;";

	public WorkspaceDAO() {
	}

	protected Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}

	public void insertWorkspace(Workspace workspace) throws SQLException {
		System.out.println(INSERT_WORKSPACE_SQL);
		// try-with-resource statement will auto close the connection.
		try (Connection connection = getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(INSERT_WORKSPACE_SQL)) {
			preparedStatement.setString(1, workspace.getTeamName());
			preparedStatement.setString(2, workspace.getFullName());
			preparedStatement.setString(3, workspace.getEmail());
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			printSQLException(e);
		}
	}

	public Workspace selectWorkspace(int workspaceID) {
		Workspace workspace = null;
		// Step 1: Establishing a Connection
		try (Connection connection = getConnection();
				// Step 2:Create a statement using connection object
				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_WORKSPACE_BY_ID);) {
			preparedStatement.setInt(1, workspaceID);
			System.out.println(preparedStatement);
			// Step 3: Execute the query or update query
			ResultSet rs = preparedStatement.executeQuery();

			// Step 4: Process the ResultSet object.
			while (rs.next()) {
				String teamName = rs.getString("teamName");
				String fullName = rs.getString("fullName");
				String email = rs.getString("email");
				workspace = new Workspace(workspaceID, teamName, fullName, email);
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return workspace;
	}

	public List<Workspace> selectAllWorkspaces() {

		// using try-with-resources to avoid closing resources (boiler plate code)
		List<Workspace> workspace = new ArrayList<>();
		// Step 1: Establishing a Connection
		try (Connection connection = getConnection();

				// Step 2:Create a statement using connection object
			PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_WORKSPACES);) {
			System.out.println(preparedStatement);
			// Step 3: Execute the query or update query
			ResultSet rs = preparedStatement.executeQuery();

			// Step 4: Process the ResultSet object.
			while (rs.next()) {
				int workspaceID = rs.getInt("workspaceID");
				String teamName = rs.getString("teamName");
				String fullName = rs.getString("fullName");
				String email = rs.getString("email");
				workspace.add(new Workspace(workspaceID, teamName, fullName, email));
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return workspace;
	}

	public boolean deleteWorkspace(int workspaceID) throws SQLException {
		boolean rowDeleted;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(DELETE_WORKSPACE_SQL);) {
			statement.setInt(1, workspaceID);
			rowDeleted = statement.executeUpdate() > 0;
		}
		return rowDeleted;
	}

	public boolean updateWorkspace(Workspace workspace) throws SQLException {
		boolean rowUpdated;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(UPDATE_WORKSPACE_SQL);) {
			statement.setString(1, workspace.getTeamName());
			statement.setString(2, workspace.getFullName());
			statement.setString(3, workspace.getEmail());
			statement.setInt(4, workspace.getWorkspaceID());

			rowUpdated = statement.executeUpdate() > 0;
		}
		return rowUpdated;
	}

	private void printSQLException(SQLException ex) {
		for (Throwable e : ex) {
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