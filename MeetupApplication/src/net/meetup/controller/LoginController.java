package net.meetup.controller;

import net.meetup.bean.User;
import net.meetup.dao.LoginDAO;

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

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public LoginController() {
		super();
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String workspace = request.getParameter("workspace");

		LoginDAO loginDAO = new LoginDAO(); // this class contain main logic to perform function calling and database
											// operation

		try {
			User user = loginDAO.checkLogin(email, password, workspace); // this class contain setting up all received values from login.jsp
			String destPage = "login.jsp";

			if (user != null) {
				HttpSession session = request.getSession();
				session.setAttribute("login", user);
				destPage = "profile.jsp";
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