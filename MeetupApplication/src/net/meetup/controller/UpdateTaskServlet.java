package net.meetup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.meetup.utils.JDBCUtils;

@WebServlet("/UpdateTask")

public class UpdateTaskServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/meetup";
		String user = "root";
		String psw = "";

		String taskID = request.getParameter("taskID");
		String taskName = request.getParameter("taskName");
		String description = request.getParameter("description");
		LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
		String taskStatus = request.getParameter("taskStatus");
		String assignee = request.getParameter("assignee");

		if (taskID != null) {
			Connection con = null;
			PreparedStatement ps = null;
			int listID = Integer.parseInt(taskID);
			try {
				Class.forName(driverName);
				con = DriverManager.getConnection(url, user, psw);
				String sql = "Update tasks set taskID=?,taskName=?,description=?,dueDate=?, taskStatus=?, assignee=? where taskID="
						+ taskID;
				ps = con.prepareStatement(sql);
				ps.setString(1, taskID);
				ps.setString(2, taskName);
				ps.setString(3, description);
				ps.setDate(4, JDBCUtils.getSQLDate(dueDate));
				ps.setString(5, taskStatus);
				ps.setString(6, assignee);

				ps.executeUpdate();
				response.sendRedirect("list.jsp");

			} catch (Exception e) {
				out.println(e);
			}
		}

	}
}