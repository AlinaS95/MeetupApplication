package net.meetup.dao;

import net.meetup.bean.User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterDAO {
	private String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
	private String jdbcName = "root";
	private String jdbcPassword = "";
	
	private static final String REGISTER_USER_SQL = "INSERT INTO user (firstName, lastName, email, company, position, workspace, password, userImage) VALUES (?,?,?,?,?,?,?,?)";
	private static final String SELECT_USER_BY_ID = "select userID, firstName, lastName, email, company, position, workspace, password from user where userID=?";
	
	public RegisterDAO() {}
	
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
		
	public int registerUser(User user) throws SQLException {
		System.out.println("REGISTER_USER_SQL");
		
		int result = 0;
		
		// try-with-resource statement will auto close the connection
		try (Connection connection = getConnection();
			PreparedStatement statement = connection.prepareStatement(REGISTER_USER_SQL)) {
			statement.setString(1, user.getFirstName());
			statement.setString(2, user.getLastName());
			statement.setString(3, user.getEmail());
			statement.setString(4, user.getCompany());
			statement.setString(5, user.getPosition());
			statement.setString(6, user.getWorkspace());
			statement.setString(7, user.getPassword());
			
			System.out.println(statement);
			
			result = statement.executeUpdate();
			
		} catch (SQLException e) {
			printSQLException(e);
		}
		return result;
	}
	
	public User selectUser(int userID) {
        User user = null;
        // Step 1: Establishing a Connection
        try (Connection connection = getConnection();
            // Step 2:Create a statement using connection object
            PreparedStatement statement = connection.prepareStatement(SELECT_USER_BY_ID);) {
            statement.setInt(1, userID);
            System.out.println(statement);
            // Step 3: Execute the query or update query
            ResultSet result = statement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (result.next()) {
                String firstName = result.getString("firstName");
                String lastName = result.getString("lastName");
                String email = result.getString("email");
                String company = result.getString("company");
                String position = result.getString("position");
                String workspace = result.getString("workspace");
                String password = result.getString("password");
                user = new User(userID, firstName, lastName, email, company, position, workspace, password);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return user;
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