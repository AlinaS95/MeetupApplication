package net.meetup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.meetup.utils.JDBCUtils;

@WebServlet("/UpdatePost")

public class UpdatePostServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String driverName = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/meetup";
        String user = "root";
        String psw = "";
        
        String id = request.getParameter("id");
    	String person = request.getParameter("person");
    	String channel = request.getParameter("channel");
    	String category = request.getParameter("category");
    	String text = request.getParameter("text");
    	String status = request.getParameter("status");
    	LocalDate postDate = LocalDate.parse(request.getParameter("postDate"));
        
        if (id != null) {
    		Connection con = null;
    		PreparedStatement ps = null;
    		int socialID = Integer.parseInt(id);
    		try {
    			Class.forName(driverName);
    			con = DriverManager.getConnection(url, user, psw);
    			String sql = "Update socialmedia set id=?,person=?,channel=?,category=?, text=?, status=?, postDate=? where id=" + id;
    			ps = con.prepareStatement(sql);
    			ps.setString(1, id);
    			ps.setString(2, person);
    			ps.setString(3, channel);
    			ps.setString(4, category);
    			ps.setString(5, text);
    			ps.setString(6, status);
    			ps.setDate(7, JDBCUtils.getSQLDate(postDate));

    			ps.executeUpdate();
    			response.sendRedirect("socialmedia.jsp");
    			
    		} catch (Exception e) {
                out.println(e);
    		}
    	}

    }
}