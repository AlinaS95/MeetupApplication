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

@WebServlet("/UploadInbox")

public class AddInboxServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String assignee = request.getParameter("assignee");
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String workspace = request.getParameter("workspace");
		LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
		

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO inbox (assignee, title, description, workspace, dueDate) VALUES (?,?,?,?,?)");
			pst.setString(1, assignee);
			pst.setString(2, title);
			pst.setString(3, description);
			pst.setString(4, workspace);
			pst.setDate(5, JDBCUtils.getSQLDate(dueDate));
			pst.executeUpdate();
			String message = "New Inbox";
			request.setAttribute("message", message);
			request.getRequestDispatcher("inbox.jsp").forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}