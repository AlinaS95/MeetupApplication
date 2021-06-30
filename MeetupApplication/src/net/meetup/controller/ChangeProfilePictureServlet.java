package net.meetup.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/ChangeProfilePictue")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50)

public class ChangeProfilePictureServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/meetup";
		String user = "root";
		String psw = "";

		String userID = request.getParameter("userID");
		String wID = request.getParameter("wID");

		Part part = request.getPart("file");
		String fileName = extractFileName(part);// file name
		String savePath = "C:\\Users\\alina\\git\\MeetupApplication\\MeetupApplication\\WebContent\\pictures\\"
				+ File.separator + fileName;
		File fileSaveDir = new File(savePath);

		part.write(savePath + File.separator);

		if (userID != null) {
			Connection con = null;
			PreparedStatement ps = null;
			int profileID = Integer.parseInt(userID);
			try {
				Class.forName(driverName);
				con = DriverManager.getConnection(url, user, psw);
				String sql = "Update user set userID=?,filename=?, path=?, wID=? where userID=" + userID;
				ps = con.prepareStatement(sql);
				ps.setString(1, userID);
				ps.setString(2, fileName);
				ps.setString(3, savePath);
				ps.setString(4, wID);

				ps.executeUpdate();
				response.sendRedirect("profile.jsp?wID=" + wID);

			} catch (Exception e) {
				out.println(e);
			}
		}

	}

	private String extractFileName(Part part) { // This method will print the file name.
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