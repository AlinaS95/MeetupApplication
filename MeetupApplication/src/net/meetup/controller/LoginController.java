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

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginController() {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String workspace = request.getParameter("workspace");

		User user = new User();

		user.setEmail(email);
		user.setPassword(password);
		user.setWorkspace(workspace);

		LoginDAO loginDAO = new LoginDAO(); // this class contain main logic to perform function calling and database
											// operation
		try {
			String userValidate = loginDAO.checkLogin(user);
			
			if(userValidate.equals("Admin_Role"))
			{
				System.out.println("Admin");
				
				HttpSession session = request.getSession(); //create a session
				session.setAttribute("Admin", email); //setting session attribute
				request.setAttribute("email", email);
				
				request.getRequestDispatcher("admin.jsp").forward(request, response);
			}
			else if (userValidate.equals("User_Role"))
			{
				System.out.println("User's Page");
				HttpSession session = request.getSession(); //create a session
				session.setAttribute("User", email); //setting session attribute
				request.setAttribute("email", email);
				
				request.getRequestDispatcher("profile.jsp").forward(request, response);
			}
			else
			{
				System.out.println("Error = "+userValidate);
				request.setAttribute("errMessage", userValidate);
				System.out.println("Error message = " +userValidate);
				
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (Exception e2) {
			e2.printStackTrace();
		}
	}
}
