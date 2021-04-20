package net.meetup.controller;

import net.meetup.bean.Admin;
import net.meetup.dao.AdminLoginDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public AdminLoginController() {
		super();
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		AdminLoginDAO adminLoginDAO = new AdminLoginDAO(); // this class contain main logic to perform function calling and database
											// operation

		try {
			Admin admin = adminLoginDAO.checkAdminLogin(email, password); // this class contain setting up all received values from login.jsp
			String destPage = "adminLogin.jsp";

			if (admin != null) {
				HttpSession session = request.getSession();
				session.setAttribute("admin", admin);
				destPage = "admin.jsp";
			} else {
				String message = "Invalid email/password";
				request.setAttribute("message", message);
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
			dispatcher.forward(request, response);
		} catch (SQLException | ClassNotFoundException ex) {
			throw new ServletException(ex);
		}
	}
}