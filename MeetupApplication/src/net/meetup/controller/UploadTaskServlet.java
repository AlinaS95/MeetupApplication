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
		String comment = request.getParameter("comment");
		String completion = request.getParameter("completion");
		Integer wID = Integer.parseInt(request.getParameter("wID"));

		
		Part part = request.getPart("file");
		String fileName = extractFileName(part);// file name
		String savePath = "C:\\Users\\alina\\git\\MeetupApplication\\MeetupApplication\\WebContent\\pictures\\"
				+ File.separator + fileName;
		File fileSaveDir = new File(savePath);

		part.write(savePath + File.separator);


		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement ps = con.prepareStatement(
					"INSERT INTO tasks (taskName, description, dueDate, taskStatus, assignee, internalInquiries, comment, filename, path, completion, wID) VALUES (?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, taskName);
			ps.setString(2, description);
			ps.setDate(3, JDBCUtils.getSQLDate(dueDate));
			ps.setString(4, taskStatus);
			ps.setString(5, assignee);
			ps.setString(6, internalInquiries);
			ps.setString(7, comment);
			ps.setString(8, fileName);
			ps.setString(9, savePath);
			ps.setString(10, completion);
			ps.setInt(11, wID);
			ps.executeUpdate();
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