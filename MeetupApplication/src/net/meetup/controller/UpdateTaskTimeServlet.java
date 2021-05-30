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

@WebServlet("/UpdateTaskTime")

public class UpdateTaskTimeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String driverName = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/meetup";
		String user = "root";
		String psw = "";

		String taskTimeID = request.getParameter("taskTimeID");
		String taskName = request.getParameter("taskName");
		LocalDate taskDate = LocalDate.parse(request.getParameter("taskDate"));
		LocalTime startTask = LocalTime.parse(request.getParameter("startTask"));
		LocalTime stopTask = LocalTime.parse(request.getParameter("stopTask"));
		String taskSum = request.getParameter("taskSum");
		String tID  = request.getParameter("tID");
		
		String userID = request.getParameter("userID");
		
		if (taskTimeID != null) {
			Connection con = null;
			PreparedStatement ps = null;
			int taskTID = Integer.parseInt(taskTimeID);
			try {
				Class.forName(driverName);
				con = DriverManager.getConnection(url, user, psw);
				String sql = "Update tasktime set taskTimeID=?,taskName=?,taskDate=?,startTask=?,stopTask=?, taskSum=?, tID=? where taskTimeID="
						+ taskTimeID;
				ps = con.prepareStatement(sql);
				ps.setString(1, taskTimeID);
				ps.setString(2, taskName);
				ps.setDate(3, JDBCUtils.getSQLDate(taskDate));
				ps.setTime(4, JDBCUtils.getSQLTime(startTask));
				ps.setTime(5, JDBCUtils.getSQLTime(stopTask));
				ps.setString(6, taskSum);
				ps.setString(7, tID);

				ps.executeUpdate();
				response.sendRedirect("startTimeTracker.jsp?userID="+userID);

			} catch (Exception e) {
				out.println(e);
			}
		}

	}
}