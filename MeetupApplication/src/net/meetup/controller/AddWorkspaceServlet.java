package net.meetup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addWorkspace")

public class AddWorkspaceServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String fullName = request.getParameter("fullName");
		String email = request.getParameter("email");
		String workspace = request.getParameter("workspace");
		String userSID = request.getParameter("userSID");

		String userID = request.getParameter("userID");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement ps = con
					.prepareStatement("INSERT INTO workspace (fullName, email, workspace, userSID) VALUES (?,?,?,?)");
			ps.setString(1, fullName);
			ps.setString(2, email);
			ps.setString(3, workspace);
			ps.setString(4, userSID);
			ps.executeUpdate();

			request.getRequestDispatcher("profile.jsp?userID=" + userSID).forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}