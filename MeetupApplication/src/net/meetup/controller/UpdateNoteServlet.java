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

@WebServlet("/UpdateNote")

public class UpdateNoteServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/meetup";
		String user = "root";
		String psw = "";

		String id = request.getParameter("id");
		String noteTitle = request.getParameter("noteTitle");
		LocalDate date = LocalDate.parse(request.getParameter("date"));

		if (id != null) {
			Connection con = null;
			PreparedStatement ps = null;
			int listID = Integer.parseInt(id);
			try {
				Class.forName(driverName);
				con = DriverManager.getConnection(url, user, psw);
				String sql = "Update notes set id=?,noteTitle=?,date=? where id="
						+ id;
				ps = con.prepareStatement(sql);
				ps.setString(1, id);
				ps.setString(2, noteTitle);
				ps.setDate(3, JDBCUtils.getSQLDate(date));

				ps.executeUpdate();
				response.sendRedirect("home.jsp");

			} catch (Exception e) {
				out.println(e);
			}
		}

	}
}