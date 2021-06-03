package net.meetup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.LocalTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.meetup.utils.JDBCUtils;

@WebServlet("/addTaskTime")

public class AddTaskTimeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String taskName = request.getParameter("taskName");
		String week = request.getParameter("week");
		LocalDate taskDate = LocalDate.parse(request.getParameter("taskDate"));
		LocalTime startTask = LocalTime.parse(request.getParameter("startTask"));
		LocalTime stopTask = LocalTime.parse(request.getParameter("stopTask"));
		String taskSum = request.getParameter("taskSum");
		String tID  = request.getParameter("tID");
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement ps = con.prepareStatement(
					"INSERT INTO tasktime (taskName, week, taskDate, startTask, stopTask, taskSum, tID) VALUES (?,?,?,?,?,?,?)");
			ps.setString(1, taskName);
			ps.setString(2, week);
			ps.setDate(3, JDBCUtils.getSQLDate(taskDate));
			ps.setTime(4, JDBCUtils.getSQLTime(startTask));
			ps.setTime(5, JDBCUtils.getSQLTime(stopTask));
			ps.setString(6, taskSum);
			ps.setString(7, tID);
			ps.executeUpdate();
			
			request.getRequestDispatcher("startTimeTracker.jsp?userSID="+tID).forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}