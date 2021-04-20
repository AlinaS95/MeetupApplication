package net.meetup.dao;

import net.meetup.bean.Admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminRegisterDAO {
	private String jdbcURL = "jdbc:mysql://localhost:3306/meetup";
	private String jdbcName = "root";
	private String jdbcPassword = "";
	
	private static final String REGISTER_ADMIN_SQL = "INSERT INTO admin (firstName, lastName, email, password) VALUES (?,?,?,PASSWORD(?))";
	private static final String SELECT_ADMIN_BY_ID = "select id, firstName, lastName, email, password from user where id=?";
	
	public AdminRegisterDAO() {}
	
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
		
	public int registerAdmin(Admin admin) throws SQLException {
		System.out.println("REGISTER_ADMIN_SQL");
		
		int result = 0;
		
		// try-with-resource statement will auto close the connection
		try (Connection connection = getConnection();
			PreparedStatement statement = connection.prepareStatement(REGISTER_ADMIN_SQL)) {
			statement.setString(1, admin.getFirstName());
			statement.setString(2, admin.getLastName());
			statement.setString(3, admin.getEmail());
			statement.setString(4, admin.getPassword());
			
			System.out.println(statement);
			
			result = statement.executeUpdate();
			
		} catch (SQLException e) {
			printSQLException(e);
		}
		return result;
	}
	
	public Admin selectAdmin(int id) {
        Admin admin = null;
        // Step 1: Establishing a Connection
        try (Connection connection = getConnection();
            // Step 2:Create a statement using connection object
            PreparedStatement statement = connection.prepareStatement(SELECT_ADMIN_BY_ID);) {
            statement.setInt(1, id);
            System.out.println(statement);
            // Step 3: Execute the query or update query
            ResultSet result = statement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (result.next()) {
                String firstName = result.getString("firstName");
                String lastName = result.getString("lastName");
                String email = result.getString("email");
                String password = result.getString("password");
                admin = new Admin(id, firstName, lastName, email, password);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return admin;
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