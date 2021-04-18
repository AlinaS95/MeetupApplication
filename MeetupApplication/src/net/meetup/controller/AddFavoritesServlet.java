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

@WebServlet("/AddFavorites")

public class AddFavoritesServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String favoritesID = request.getParameter("favoritesID");
		String description = request.getParameter("description");
		LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
		String taskStatus = request.getParameter("taskStatus");
		String assignee = request.getParameter("assignee");

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO tasks (taskName, description, dueDate, taskStatus, assignee) VALUES (?,?,?,?,?)");
			pst.setString(1, taskName);
			pst.setString(2, description);
			pst.setDate(3, JDBCUtils.getSQLDate(dueDate));
			pst.setString(4, taskStatus);
			pst.setString(5, assignee);
			pst.executeUpdate();
			String message = "New Task";
			request.setAttribute("message", message);
			request.getRequestDispatcher("list.jsp").forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}