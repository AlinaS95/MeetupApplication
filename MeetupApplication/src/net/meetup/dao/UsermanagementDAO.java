package net.meetup.dao;

import net.meetup.bean.User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsermanagementDAO {
	private String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
	private String jdbcName = "root";
	private String jdbcPassword = "";
	
	private static final String SELECT_USER_BY_ID = "select userID, firstName, lastName, email, company, position, password from user where userID=?";
	private static final String SELECT_ALL_USERS = "select * from user";
	private static final String UPDATE_USER_SQL = "update user set firstName = ?, lastName = ?, email= ?, company =?, position =? where userID = ?;";
	private static final String DELETE_USER_SQL = "delete from user where userID = ?;";
	
	public UsermanagementDAO() {}
	
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
                String password = result.getString("password");
                user = new User(userID, firstName, lastName, email, company, position, password);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return user;
    }
	
	public List < User > selectAllUsers() {

        // using try-with-resources to avoid closing resources (boiler plate code)
        List < User > users = new ArrayList < > ();
        // Step 1: Establishing a Connection
        try (Connection connection = getConnection();

            // Step 2:Create a statement using connection object
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS);) {
            System.out.println(preparedStatement);
            // Step 3: Execute the query or update query
            ResultSet result = preparedStatement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (result.next()) {
                int userID = result.getInt("userID");
                String firstName = result.getString("firstName");
                String lastName = result.getString("lastName");
                String email = result.getString("email");
                String company = result.getString("company");
                String position = result.getString("position");
                users.add(new User(userID, firstName, lastName, email, company, position));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return users;
    }

	
	public boolean deleteUser(int userID) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(DELETE_USER_SQL);) {
            statement.setInt(1, userID);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }
	
	public boolean updateUser(User user) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_USER_SQL);) {
            statement.setString(1, user.getFirstName());
            statement.setString(2, user.getLastName());
            statement.setString(3, user.getEmail());
            statement.setString(3, user.getCompany());
            statement.setString(3, user.getPosition());
            statement.setInt(4, user.getUserID());

            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
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