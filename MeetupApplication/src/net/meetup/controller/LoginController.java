package net.meetup.controller;

import net.meetup.bean.LoginBean;
import net.meetup.dao.LoginDAO;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("btn_login")!=null) //check button click event not null from login.jsp page button
		{
			String email=request.getParameter("email"); //get textbox name "txt_email"
			String password=request.getParameter("password"); //get textbox name "txt_password"
			
			LoginBean loginBean=new LoginBean(); //this class contain setting up all received values from login.jsp page to setter and getter method for application require effectively
			
			loginBean.setEmail(email); //set email through loginBean object
			loginBean.setPassword(password); //set password through loginBean object
			
			LoginDAO loginDAO=new LoginDAO(); //this class contain main logic to perform function calling and database operation
			
			String authorize=loginDAO.authorizeLogin(loginBean); //send loginBean object values into authorizeLogin() function in LoginDAO class
			
			if(authorize.equals("SUCCESS LOGIN")) //check calling authorizeLogin() function receive string "SUCCESS LOGIN" message after continue process
			{
				HttpSession session=request.getSession(); //session is created
				session.setAttribute("login", loginBean.getEmail());
				RequestDispatcher rd=request.getRequestDispatcher("profile.jsp");
				rd.forward(request, response);
			}
			else
			{
				request.setAttribute("WrongLoginMsg", authorize);
				RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
				rd.include(request, response);
			}
		}
	}

}
