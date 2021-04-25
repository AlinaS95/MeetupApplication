package net.meetup.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Time;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import net.meetup.utils.JDBCUtils;

@WebServlet("/addTime")

public class AddTimeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		LocalDate date = LocalDate.parse(request.getParameter("date"));
		LocalDate startTime = LocalDate.parse(request.getParameter("startTime"));
		LocalDate stopTime = LocalDate.parse(request.getParameter("stopTime"));
		LocalDate pauseTime = LocalDate.parse(request.getParameter("pauseTime"));
		String duration = request.getParameter("duration");

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO workingtime (date, startTime, stopTime, pauseTime, duration) VALUES (?,?,?,?,?)");
			pst.setDate(1, JDBCUtils.getSQLDate(date));
			pst.setDate(2, JDBCUtils.getSQLDate(startTime));
			pst.setDate(3, JDBCUtils.getSQLDate(stopTime));
			pst.setDate(4, JDBCUtils.getSQLDate(pauseTime));
			pst.setString(5, duration);
			pst.executeUpdate();
			
			request.getRequestDispatcher("timeTracker.jsp").forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}