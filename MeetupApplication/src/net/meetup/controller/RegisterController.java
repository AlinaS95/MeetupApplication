package net.meetup.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.meetup.bean.User;
import net.meetup.dao.RegisterDAO;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RegisterDAO registerDAO;
	
	public void init() {
		registerDAO = new RegisterDAO();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		register(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("registration.jsp");
	}
	private void register(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String company = request.getParameter("company");
			String position = request.getParameter("position");
			String password = request.getParameter("password");
			
			User user = new User();
			user.setFirstName(firstName);
			user.setLastName(lastName);
			user.setEmail(email);
			user.setCompany(company);
			user.setPosition(position);
			user.setPassword(password);
			
			try {
				int result = registerDAO.registerUser(user);
				String destPage = "registration.jsp";
				if (result == 1) {
					HttpSession session = request.getSession();
					session.setAttribute("login", user);
					destPage = "profile.jsp";
				}
				RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
				dispatcher.forward(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
	}
}