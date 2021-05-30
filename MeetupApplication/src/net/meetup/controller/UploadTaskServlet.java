package net.meetup.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import net.meetup.utils.JDBCUtils;

@WebServlet("/UploadTask")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50)

public class UploadTaskServlet extends HttpServlet {

	// private static final String SAVE_DIR=*pictures*; //this is our folder name

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String taskName = request.getParameter("taskName");
		String description = request.getParameter("description");
		LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
		String taskStatus = request.getParameter("taskStatus");
		String assignee = request.getParameter("assignee");
		String internalInquiries = request.getParameter("internalInquiries");
		String completion = request.getParameter("completion");
		String wID = request.getParameter("wID");
		
		Part part = request.getPart("file");
		String fileName = extractFileName(part);// file name
		String savePath = "C:\\Users\\alina\\git\\MeetupApplication\\MeetupApplication\\WebContent\\pictures\\tasks\\"
				+ File.separator + fileName;
		File fileSaveDir = new File(savePath);

		part.write(savePath + File.separator);

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO tasks (taskName, description, dueDate, taskStatus, assignee, internalInquiries, filename, path, completion, wID) VALUES (?,?,?,?,?,?,?,?,?,?)");
			pst.setString(1, taskName);
			pst.setString(2, description);
			pst.setDate(3, JDBCUtils.getSQLDate(dueDate));
			pst.setString(4, taskStatus);
			pst.setString(5, assignee);
			pst.setString(6, internalInquiries);
			pst.setString(7, fileName);
			pst.setString(8, savePath);
			pst.setString(9, completion);
			pst.setString(10, wID);
			
			pst.executeUpdate();
			request.getRequestDispatcher("list.jsp?wID="+wID).forward(request, response);
		} catch (Exception e) {
			out.println(e);
		}

	}
	// file name of the upload file is included in content-disposition header like
	// this:
	// form-data; name="dataFile"; filename="PHOTO.JPG"

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