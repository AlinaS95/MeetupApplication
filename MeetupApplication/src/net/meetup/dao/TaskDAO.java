package net.meetup.dao;

import java.sql.SQLException;
import java.util.List;

import net.meetup.bean.Task;

public interface TaskDAO {

	void insertTask(Task task) throws SQLException;

	Task selectTask(long idTask);

	List<Task> selectAllTasks();

	boolean deleteTask(int taskID) throws SQLException;

	boolean updateTasks(Task task) throws SQLException;

}
