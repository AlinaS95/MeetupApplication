package net.meetup.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
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

@WebServlet("/UploadPost")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)

public class UploadPostServlet extends HttpServlet {

	//private static final String SAVE_DIR=*pictures*; //this is our folder name

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String person = request.getParameter("person");
        String channel = request.getParameter("channel");
        String category = request.getParameter("category");
        String text = request.getParameter("text");

        Part part = request.getPart("file");//
        String fileName = extractFileName(part);//file name
        String savePath = "C:\\Users\\alina\\git\\MeetupApplication\\MeetupApplication\\WebContent\\pictures\\" + File.separator + fileName;
        File fileSaveDir = new File(savePath);
        
        part.write(savePath + File.separator);
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
            PreparedStatement pst = con.prepareStatement("INSERT INTO socialmedia (person, channel, category, filename, path, text) VALUES (?,?,?,?,?,?)");
            pst.setString(1, person);
            pst.setString(2, channel);
            pst.setString(3, category);
            pst.setString(4, fileName);
            pst.setString(5, savePath);
            pst.setString(6, text);
            pst.executeUpdate();
            String message = "New Post";
            request.setAttribute("message", message);
            request.getRequestDispatcher("socialmedia.jsp").forward(request, response);
        } catch (Exception e) {
            out.println(e);
        }

    }
    // file name of the upload file is included in content-disposition header like this:
    //form-data; name="dataFile"; filename="PHOTO.JPG"

    private String extractFileName(Part part) {//This method will print the file name.
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