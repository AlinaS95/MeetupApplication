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

@WebServlet("/UpdateTime")

public class UpdateTimeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String driverName = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/meetup";
		String user = "root";
		String psw = "";

		String id = request.getParameter("id");
		String kw = request.getParameter("kw");
		LocalDate date = LocalDate.parse(request.getParameter("date"));
		LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
		LocalTime stopTime = LocalTime.parse(request.getParameter("stopTime"));
		String pauseTime = request.getParameter("pauseTime");
		String duration = request.getParameter("duration");
		String userSID = request.getParameter("userSID");
	
		
		if (id != null) {
			Connection con = null;
			PreparedStatement ps = null;
			int timeID = Integer.parseInt(id);
			try {
				Class.forName(driverName);
				con = DriverManager.getConnection(url, user, psw);
				String sql = "Update workingtime set id=?,kw=?,date=?,startTime=?,stopTime=?, pauseTime=?, duration=?, userSID=? where id="
						+ id;
				ps = con.prepareStatement(sql);
				ps.setString(1, id);
				ps.setString(2, kw);
				ps.setDate(3, JDBCUtils.getSQLDate(date));
				ps.setTime(4, JDBCUtils.getSQLTime(startTime));
				ps.setTime(5, JDBCUtils.getSQLTime(stopTime));
				ps.setString(6, (pauseTime));
				ps.setString(7, duration);
				ps.setString(8, userSID);

				ps.executeUpdate();
				response.sendRedirect("timeTracker.jsp?userID="+userSID);

			} catch (Exception e) {
				out.println(e);
			}
		}

	}
}