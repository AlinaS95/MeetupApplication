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

@WebServlet("/UpdateTeams")

public class UpdateTeamsServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/meetup";
		String user = "root";
		String psw = "";

		String teamsID = request.getParameter("teamsID");
		String fullName = request.getParameter("fullName");
		String workspace = request.getParameter("workspace");

		if (teamsID != null) {
			Connection con = null;
			PreparedStatement ps = null;
			int teamID = Integer.parseInt(teamsID);
			try {
				Class.forName(driverName);
				con = DriverManager.getConnection(url, user, psw);
				String sql = "Update tasks set teamsID=?,fullName=?,workspace=?, where teamsID="
						+ teamsID;
				ps = con.prepareStatement(sql);
				ps.setString(1, teamsID);
				ps.setString(2, fullName);
				ps.setString(3, workspace);

				ps.executeUpdate();
				response.sendRedirect("home.jsp");

			} catch (Exception e) {
				out.println(e);
			}
		}

	}
}