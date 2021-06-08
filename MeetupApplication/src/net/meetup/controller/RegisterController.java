package net.meetup.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import net.meetup.bean.User;
import net.meetup.dao.RegisterDAO;

@WebServlet("/register")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
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
		response.sendRedirect("registration.jsp?wID=\"+ user.getWID()");
	}
	private void register(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String company = request.getParameter("company");
			String workspace = request.getParameter("workspace");
			String password = request.getParameter("password");
			Integer wID = Integer.parseInt(request.getParameter("wID"));
			
			Part part = request.getPart("file");
			String fileName = extractFileName(part);// file name
			String savePath = "C:\\Users\\alina\\git\\MeetupApplication\\MeetupApplication\\WebContent\\pictures\\"
					+ File.separator + fileName;
			File fileSaveDir = new File(savePath);

			part.write(savePath + File.separator);
			
			User user = new User();
			user.setFirstName(firstName);
			user.setLastName(lastName);
			user.setEmail(email);
			user.setCompany(company);
			user.setWorkspace(workspace);
			user.setPassword(password);
			user.setFileName(fileName);
			user.setSavePath(savePath);
			user.setWID(wID);
			
			try {
				int result = registerDAO.registerUser(user);
				String destPage = "registration.jsp";
				if (result == 1) {
					HttpSession session = request.getSession();
					session.setAttribute("login", user);
					destPage = "profile.jsp?wID="+ user.getWID();
				}
				RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
				dispatcher.forward(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
	}
	
	private String extractFileName(Part part) {// This method will print the file name.
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return "";
	}
}