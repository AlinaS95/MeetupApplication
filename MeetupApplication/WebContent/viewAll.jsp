<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Image Show</title>
    </head>
    <body>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
                Statement st = con.createStatement();
                String sql = "SELECT * FROM socialmedia";
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {
                    int number = rs.getInt("number");
                    String person = rs.getString("person");
                    String channel = rs.getString("channel");
                    String category = rs.getString("category");
                    String filename = rs.getString("filename");
        %>

        <table style="width:100%" border="2">
            <tr>
                <th>Number</th>
                <th>Person</th>
                <th>Channel</th>
                <th>Category</th>
                <th>Image</th>
            </tr>
            <tr>
                <td><%=number%></td>
                <td><%=person%></td>
                <td><%=channel%></td>
                <td><%=category%></td>
                <td><image src="pictures/<%=filename%>" width="150" height="200"/></td>
            </tr>
        </table>
        <%
                }
            } catch (Exception e) {
                out.println(e);
            }
        %>
    </body>
</html>