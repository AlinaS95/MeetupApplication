package net.meetup.workspace;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addMember")
public class WorkspaceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WorkspaceDAO workspaceDAO;
	
	public void init() {
		workspaceDAO = new WorkspaceDAO();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		addMember(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("registration.jsp");
	}
	private void addMember(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			String fullName = request.getParameter("fullName");
			String email = request.getParameter("email");
			String workspace = request.getParameter("workspace");
			String position = request.getParameter("position");
			
			Workspace addWorkspace = new Workspace();
			addWorkspace.setFullName(fullName);
			addWorkspace.setEmail(email);
			addWorkspace.setWorkspace(workspace);
			addWorkspace.setPosition(position);
			
			try {
				int result = workspaceDAO.addMember(addWorkspace);
				String destPage = "registration.jsp";
				if (result == 1) {
					HttpSession session = request.getSession();
					session.setAttribute("workspace", addWorkspace);
					destPage = "profile.jsp";
				}
				RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
				dispatcher.forward(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
	}
}