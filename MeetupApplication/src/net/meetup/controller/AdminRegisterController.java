package net.meetup.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.meetup.bean.Admin;
import net.meetup.dao.AdminRegisterDAO;

@WebServlet("/adminRegister")
public class AdminRegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminRegisterDAO adminRegisterDAO;
	
	public void init() {
		adminRegisterDAO = new AdminRegisterDAO();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		adminRegister(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("adminRegistration.jsp");
	}
	private void adminRegister(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			Admin admin = new Admin();
			admin.setFirstName(firstName);
			admin.setLastName(lastName);
			admin.setEmail(email);
			admin.setPassword(password);
			
			try {
				int result = adminRegisterDAO.registerAdmin(admin);
				String destPage = "adminRegistration.jsp";
				if (result == 1) {
					HttpSession session = request.getSession();
					session.setAttribute("admin", admin);
					destPage = "admin.jsp";
				}
				RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
				dispatcher.forward(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
	}
}