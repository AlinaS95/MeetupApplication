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

@WebServlet("/UpdateInbox")

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
		String assignee = request.getParameter("assignee");
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String workspace = request.getParameter("workspace");
		LocalDate duedate = LocalDate.parse(request.getParameter("duedate"));

		if (inboxID != null) {
			Connection con = null;
			PreparedStatement ps = null;
			int idInbox = Integer.parseInt(inboxID);
			try {
				Class.forName(driverName);
				con = DriverManager.getConnection(url, user, psw);
				String sql = "Update inbox set inboxID=?,assignee=?,title=?,description=?, workspace=?, duedate=? where inboxID="
						+ inboxID;
				ps = con.prepareStatement(sql);
				ps.setString(1, inboxID);
				ps.setString(2, assignee);
				ps.setString(3, title);
				ps.setString(4, description);
				ps.setString(5, workspace);
				ps.setDate(6, JDBCUtils.getSQLDate(duedate));

				ps.executeUpdate();
				response.sendRedirect("inbox.jsp");

			} catch (Exception e) {
				out.println(e);
			}
		}

	}
}
