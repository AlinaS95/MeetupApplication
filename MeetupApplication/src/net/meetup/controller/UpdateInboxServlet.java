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

@WebServlet("/UpdateTnbox")

public class UpdateInboxServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/meetup";
		String user = "root";
		String psw = "";

		String inboxID = request.getParameter("inboxID");
		String fullName = request.getParameter("fullName");
		String email = request.getParameter("email");
		String workspace = request.getParameter("workspace");
		LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
		String description = request.getParameter("description");
		String position = request.getParameter("position");

		if (inboxID != null) {
			Connection con = null;
			PreparedStatement ps = null;
			int listID = Integer.parseInt(inboxID);
			try {
				Class.forName(driverName);
				con = DriverManager.getConnection(url, user, psw);
				String sql = "Update tasks set taskID=?,fullName=?,description=?,dueDate=?, email=?, position=?, workspace=? where inboxID="
						+ inboxID;
				ps = con.prepareStatement(sql);
				ps.setString(1, inboxID);
				ps.setString(2, fullName);
				ps.setString(3, description);
				ps.setDate(4, JDBCUtils.getSQLDate(dueDate));
				ps.setString(5, email);
				ps.setString(6, position);
				ps.setString(6, workspace);

				ps.executeUpdate();
				response.sendRedirect("inbox.jsp");

			} catch (Exception e) {
				out.println(e);
			}
		}

	}
}
