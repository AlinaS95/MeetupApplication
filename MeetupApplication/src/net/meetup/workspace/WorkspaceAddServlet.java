package net.meetup.workspace;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.meetup.workspace.WorkspaceDAO;
import net.meetup.workspace.Workspace;

/**
 * Servlet implementation class WorkspaceAddServlet
 */
@WebServlet("/workspace")
public class WorkspaceAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private WorkspaceDAO workspaceDAO = new WorkspaceDAO();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WorkspaceAddServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String teamName = request.getParameter("teamName");
		String fullName = request.getParameter("fullName");
		String email = request.getParameter("email");
		
		Workspace workspace = new Workspace();
		workspace.setTeamName(teamName);
		workspace.setFullName(fullName);
		workspace.setEmail(email);
		
		try {
			workspaceDAO.addWorkspace(workspace);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("home.html");
		dispatcher.forward(request, response);
	}

}
