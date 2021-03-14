package net.meetup.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.meetup.bean.Task;
import net.meetup.dao.TaskDAO;
import net.meetup.dao.TaskDAOImpl;

@WebServlet("/")
public class TaskController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TaskDAO taskDAO;

    public void init() {
        taskDAO = new TaskDAOImpl();
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
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/insert":
                    insertTask(request, response);
                    break;
                case "/delete":
                    deleteTask(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateTasks(request, response);
                    break;
                case "/list":
                    listTasks(request, response);
                    break;
                default:
                    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listTasks(HttpServletRequest request, HttpServletResponse response)
    throws SQLException, IOException, ServletException {
        List < Task > listTasks = taskDAO.selectAllTasks();
        request.setAttribute("listTasks", listTasks);
        RequestDispatcher dispatcher = request.getRequestDispatcher("list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("list.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
    throws SQLException, ServletException, IOException {
        int taskID = Integer.parseInt(request.getParameter("taskID"));
        Task existingTasks = taskDAO.selectTask(taskID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("list.jsp");
        request.setAttribute("task", existingTasks);
        dispatcher.forward(request, response);

    }

    private void insertTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

        String title = request.getParameter("title");
        String assignee = request.getParameter("assignee");
        String description = request.getParameter("description");

        /*DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-mm-dd");
        LocalDate targetDate = LocalDate.parse(request.getParameter("targetDate"),df);*/

        boolean isDone = Boolean.valueOf(request.getParameter("isDone"));
        Task newTask = new Task(title, assignee, description, LocalDate.now(), isDone);
        taskDAO.insertTask(newTask);
        response.sendRedirect("list");
    }

    private void updateTasks(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int taskID = Integer.parseInt(request.getParameter("taskID"));

        String title = request.getParameter("title");
        String assignee = request.getParameter("assignee");
        String description = request.getParameter("description");
        //DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-mm-dd");
        LocalDate targetDate = LocalDate.parse(request.getParameter("targetDate"));

        boolean isDone = Boolean.valueOf(request.getParameter("isDone"));
        Task updateTasks = new Task(taskID, title, assignee, description, targetDate, isDone);

        taskDAO.updateTasks(updateTasks);

        response.sendRedirect("list");
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int taskID = Integer.parseInt(request.getParameter("taskID"));
        taskDAO.deleteTask(taskID);
        response.sendRedirect("list");
    }
}