package net.meetup.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.meetup.bean.RegisterBean;
import net.meetup.dao.RegisterDAO;

public class RegisterController extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if(request.getParameter("btn_register")!=null)
		{
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String company = request.getParameter("company");
			String position = request.getParameter("position");
			String password = request.getParameter("password");
			
			RegisterBean registerBean = new RegisterBean();
			
			registerBean.setFirstName(firstName);
			registerBean.setLastName(lastName);
			registerBean.setEmail(email);
			registerBean.setCompany(company);
			registerBean.setPosition(position);
			registerBean.setPassword(password);
			
			RegisterDAO registerDAO = new RegisterDAO();
			
			String registerValidate = registerDAO.authorizeRegister(registerBean);
			
			if(registerValidate.equals("SUCCESS REGISTER"))
			{
				request.setAttribute("RegisterSuccessMsg",registerValidate);
				RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
				rd.forward(request, response);
			}
			else
			{
				request.setAttribute("RegisterErrorMsg", registerValidate);
				RequestDispatcher rd=request.getRequestDispatcher("registration.jsp");
				rd.include(request, response);
			}
		}
	}
}