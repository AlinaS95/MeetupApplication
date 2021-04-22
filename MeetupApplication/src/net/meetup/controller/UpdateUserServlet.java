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

@WebServlet("/UpdateUser")

public class UpdateUserServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/meetup";
		String user = "root";
		String psw = "";

		String userID = request.getParameter("userID");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String company = request.getParameter("company");
		String workspace = request.getParameter("workspace");

		if (userID != null) {
			Connection con = null;
			PreparedStatement ps = null;
			int managerID = Integer.parseInt(userID);
			try {
				Class.forName(driverName);
				con = DriverManager.getConnection(url, user, psw);
				String sql = "Update user set userID=?,firstName=?,lastName=?,email=?, company=?, workspace=? where userID="
						+ userID;
				ps = con.prepareStatement(sql);
				ps.setString(1, userID);
				ps.setString(2, firstName);
				ps.setString(3, lastName);
				ps.setString(4, email);
				ps.setString(5, company);
				ps.setString(6, workspace);

				ps.executeUpdate();
				response.sendRedirect("adminUser.jsp");

			} catch (Exception e) {
				out.println(e);
			}
		}

	}
}