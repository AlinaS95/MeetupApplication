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

		String kw = request.getParameter("kw");
		LocalDate date = LocalDate.parse(request.getParameter("date"));
		LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
		LocalTime stopTime = LocalTime.parse(request.getParameter("stopTime"));
		LocalTime pauseTime = LocalTime.parse(request.getParameter("pauseTime"));
		String duration = request.getParameter("duration");
		String userSID = request.getParameter("userSID");
		
		String userID = request.getParameter("userID");
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement ps = con.prepareStatement(
					"INSERT INTO workingtime (kw, date, startTime, stopTime, pauseTime, duration, userSID) VALUES (?,?,?,?,?,?,?)");
			ps.setString(1, kw);
			ps.setDate(2, JDBCUtils.getSQLDate(date));
			ps.setTime(3, JDBCUtils.getSQLTime(startTime));
			ps.setTime(4, JDBCUtils.getSQLTime(stopTime));
			ps.setTime(5, JDBCUtils.getSQLTime(pauseTime));
			ps.setString(6, duration);
			ps.setString(7, userSID);
			ps.executeUpdate();
			
			request.getRequestDispatcher("timeTracker.jsp?userID="+userSID).forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}