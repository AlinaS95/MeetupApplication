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

@WebServlet("/addTime")

public class AddTimeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		LocalDate date = LocalDate.parse(request.getParameter("date"));
		LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
		LocalTime stopTime = LocalTime.parse(request.getParameter("stopTime"));
		LocalTime pauseTime = LocalTime.parse(request.getParameter("pauseTime"));
		String duration = request.getParameter("duration");
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement ps = con.prepareStatement(
					"INSERT INTO workingtime (date, startTime, stopTime, pauseTime, duration) VALUES (?,?,?,?,?)");
			ps.setDate(1, JDBCUtils.getSQLDate(date));
			ps.setTime(2, JDBCUtils.getSQLTime(startTime));
			ps.setTime(3, JDBCUtils.getSQLTime(stopTime));
			ps.setTime(4, JDBCUtils.getSQLTime(pauseTime));
			ps.setString(5, duration);
			ps.executeUpdate();
			
			request.getRequestDispatcher("timeTracker.jsp").forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}