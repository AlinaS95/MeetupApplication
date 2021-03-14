package net.meetup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import net.meetup.bean.Task;
import net.meetup.utils.JDBCUtils;

public class TaskDAOImpl implements TaskDAO {

    private static final String INSERT_TASK_SQL = "INSERT INTO tasks" +
        "  (title, assignee, description, targetDate, isDone) VALUES " + " (?, ?, ?, ?, ?);";

    private static final String SELECT_TASK_BY_ID = "select taskID,title,assignee,description,targetDate,isDone from tasks where taskID =?";
    private static final String SELECT_ALL_TASKS = "select * from tasks";
    private static final String DELETE_TASK_BY_ID = "delete from tasks where taskID = ?;";
    private static final String UPDATE_TASKS = "update tasks set title = ?, assignee= ?, description =?, targetDate =?, isDone = ? where taskID = ?;";

    public TaskDAOImpl() {}

    @Override
    public void insertTask(Task task) throws SQLException {
        System.out.println(INSERT_TASK_SQL);
        // try-with-resource statement will auto close the connection.
        try (Connection connection = JDBCUtils.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TASK_SQL)) {
            preparedStatement.setString(1, task.getTitle());
            preparedStatement.setString(2, task.getAssignee());
            preparedStatement.setString(3, task.getDescription());
            preparedStatement.setDate(4, JDBCUtils.getSQLDate(task.getTargetDate()));
            preparedStatement.setBoolean(5, task.getStatus());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException exception) {
            JDBCUtils.printSQLException(exception);
        }
    }

    @Override
    public Task selectTask(long idTask) {
        Task task = null;
        // Step 1: Establishing a Connection
        try (Connection connection = JDBCUtils.getConnection();
            // Step 2:Create a statement using connection object
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TASK_BY_ID);) {
            preparedStatement.setLong(1, idTask);
            System.out.println(preparedStatement);
            // Step 3: Execute the query or update query
            ResultSet rs = preparedStatement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (rs.next()) {
                long taskID = rs.getLong("taskID");
                String title = rs.getString("title");
                String assignee = rs.getString("assignee");
                String description = rs.getString("description");
                LocalDate targetDate = rs.getDate("targetDate").toLocalDate();
                boolean isDone = rs.getBoolean("isDone");
                task = new Task(taskID, title, assignee, description, targetDate, isDone);
            }
        } catch (SQLException exception) {
            JDBCUtils.printSQLException(exception);
        }
        return task;
    }

    @Override
    public List < Task > selectAllTasks() {

        // using try-with-resources to avoid closing resources (boiler plate code)
        List < Task > tasks = new ArrayList < > ();

        // Step 1: Establishing a Connection
        try (Connection connection = JDBCUtils.getConnection();

            // Step 2:Create a statement using connection object
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_TASKS);) {
            System.out.println(preparedStatement);
            // Step 3: Execute the query or update query
            ResultSet rs = preparedStatement.executeQuery();

            // Step 4: Process the ResultSet object.
            while (rs.next()) {
                long taskID = rs.getLong("taskID");
                String title = rs.getString("title");
                String assignee = rs.getString("assignee");
                String description = rs.getString("description");
                LocalDate targetDate = rs.getDate("targetDate").toLocalDate();
                boolean isDone = rs.getBoolean("isDone");
                tasks.add(new Task(taskID, title, assignee, description, targetDate, isDone));
            }
        } catch (SQLException exception) {
            JDBCUtils.printSQLException(exception);
        }
        return tasks;
    }

    @Override
    public boolean deleteTask(int taskID) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = JDBCUtils.getConnection(); PreparedStatement statement = connection.prepareStatement(DELETE_TASK_BY_ID);) {
            statement.setInt(1, taskID);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    @Override
    public boolean updateTasks(Task task) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = JDBCUtils.getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_TASKS);) {
            statement.setString(1, task.getTitle());
            statement.setString(2, task.getAssignee());
            statement.setString(3, task.getDescription());
            statement.setDate(4, JDBCUtils.getSQLDate(task.getTargetDate()));
            statement.setBoolean(5, task.getStatus());
            statement.setLong(6, task.getTaskID());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
}
