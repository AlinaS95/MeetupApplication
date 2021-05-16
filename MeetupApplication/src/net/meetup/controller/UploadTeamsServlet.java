package net.meetup.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import net.meetup.utils.JDBCUtils;

@WebServlet("/UploadTeams")

public class UploadTeamsServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String fullName = request.getParameter("fullName");
		String workspace = request.getParameter("workspace");

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO teams (fullName, workspace) VALUES (?,?)");
			pst.setString(1, fullName);
			pst.setString(2, workspace);
			pst.executeUpdate();
			String message = "New Teams";
			request.setAttribute("message", message);
			request.getRequestDispatcher("home.jsp").forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}