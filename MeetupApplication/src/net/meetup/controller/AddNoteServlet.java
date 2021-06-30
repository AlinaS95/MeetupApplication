package net.meetup.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/AddNote")

public class AddNoteServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String noteTitle = request.getParameter("noteTitle");
		LocalDate date = LocalDate.parse(request.getParameter("date"));
		String wID = request.getParameter("wID");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO notes (noteTitle, date) VALUES (?,?)");
			pst.setString(1, noteTitle);
			pst.setDate(2, JDBCUtils.getSQLDate(date));
			pst.executeUpdate();
			request.getRequestDispatcher("home.jsp?wID="+wID).forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}

}