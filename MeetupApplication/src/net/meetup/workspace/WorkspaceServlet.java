package net.meetup.workspace;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.meetup.workspace.WorkspaceDAO;
import net.meetup.workspace.Workspace;

@WebServlet("/")
public class WorkspaceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WorkspaceDAO workspaceDAO;
	
	public void init() {
		workspaceDAO = new WorkspaceDAO();
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
			case "/newW":
				showNewForm(request, response);
				break;
			case "/insertW":
				insertWorkspace(request, response);
				break;
			case "/deleteW":
				deleteWorkspace(request, response);
				break;
			case "/editW":
				showEditForm(request, response);
				break;
			case "/updateW":
				updateWorkspace(request, response);
				break;
			default:
				listWorkspace(request, response);
				break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
	}

	private void listWorkspace(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		List<Workspace> listWorkspace = workspaceDAO.selectAllWorkspaces();
		request.setAttribute("listWorkspace", listWorkspace);
		RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
		dispatcher.forward(request, response);
	}

	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int workspaceID = Integer.parseInt(request.getParameter("workspaceID"));
		Workspace existingWorkspace = workspaceDAO.selectWorkspace(workspaceID);
		RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
		request.setAttribute("workspace", existingWorkspace);
		dispatcher.forward(request, response);

	}

	private void insertWorkspace(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		String teamName = request.getParameter("teamName");
		String fullName = request.getParameter("fullName");
		String email = request.getParameter("email");
		Workspace newWorkspace = new Workspace(teamName, fullName, email);
		workspaceDAO.insertWorkspace(newWorkspace);
		response.sendRedirect("workspaceManagement");
	}

	private void updateWorkspace(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		int workspaceID = Integer.parseInt(request.getParameter("workspaceID"));
		String teamName = request.getParameter("teamName");
		String fullName = request.getParameter("fullName");
		String email = request.getParameter("email");

		Workspace book = new Workspace(workspaceID, teamName, fullName, email);
		workspaceDAO.updateWorkspace(book);
		response.sendRedirect("workspaceManagement");
	}

	private void deleteWorkspace(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		int workspaceID = Integer.parseInt(request.getParameter("workspaceID"));
		workspaceDAO.deleteWorkspace(workspaceID);
		response.sendRedirect("workspaceManagement");

	}

}