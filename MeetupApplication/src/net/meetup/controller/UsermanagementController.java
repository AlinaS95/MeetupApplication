package net.meetup.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.meetup.bean.User;
import net.meetup.dao.UsermanagementDAO;

public class UsermanagementController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsermanagementDAO usermanagementDAO;

	public void init() {
		usermanagementDAO = new UsermanagementDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        doGet(request, response);
		    }

	 protected void doGet(HttpServletRequest request, HttpServletResponse response)
			    throws ServletException, IOException {
			        String action = request.getServletPath();

			        try {
			            switch (action) {
			                case "/delete":
			                    deleteUser(request, response);
			                    break;
			                case "/edit":
			                    showEditForm(request, response);
			                    break;
			                case "/update":
			                    updateUser(request, response);
			                    break;
			                default:
			                    listUser(request, response);
			                    break;
			            }
			        } catch (SQLException ex) {
			            throw new ServletException(ex);
			        }
			    }
	 
	 private void listUser(HttpServletRequest request, HttpServletResponse response)
			    throws SQLException, IOException, ServletException {
			        List < User > listUser = usermanagementDAO.selectAllUsers();
			        request.setAttribute("listUser", listUser);
			        RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
			        dispatcher.forward(request, response);
			    }
	 
	 private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			    throws SQLException, ServletException, IOException {
			        int userID = Integer.parseInt(request.getParameter("userID"));
			        User existingUser = usermanagementDAO.selectUser(userID);
			        RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
			        request.setAttribute("user", existingUser);
			        dispatcher.forward(request, response);
			    }
	 
	 private void updateUser(HttpServletRequest request, HttpServletResponse response)
			    throws SQLException, IOException {
			        int userID = Integer.parseInt(request.getParameter("userID"));
			        String firstName = request.getParameter("firstName");
			        String lastName = request.getParameter("lastName");
			        String email = request.getParameter("email");
			        String company = request.getParameter("company");
			        String position = request.getParameter("position");

			        User book = new User(userID, firstName, lastName, email, company, position);
			        usermanagementDAO.updateUser(book);
			        response.sendRedirect("userlist");
			    }
	 
	 private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			    throws SQLException, IOException {
			        int userID = Integer.parseInt(request.getParameter("userID"));
			        usermanagementDAO.deleteUser(userID);
			        response.sendRedirect("userlist");
	}
}