<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<%
	String url = "jdbc:mysql://localhost:3306/meetup";
	Statement stat = null;
	ResultSet result = null;

	PreparedStatement stmt = null;

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(url, "root", "");
%>
<form action="" method="post" enctype="multipart/form-data">
	<%
	stat = conn.createStatement();
	String u = request.getParameter("u");
	int num = Integer.parseInt(u);
	String data = "select * from socialmedia where id='"+num+"'";
	result = stat.executeQuery(data);
	while(result.next()){
	%>
	<input type="hidden" name="id" value='<%=result.getString("id") %>'/>
	<div>
		<label>Person</label> <input type="text" name="person" value='<%=result.getString("person") %>'/>
	</div>
	<div>
		<label>Channel</label><input type="text" name="channel" value='<%=result.getString("channel") %>'/>
	</div>
	<div>
		<label>Category</label> <input type="text" name="category" value='<%=result.getString("category") %>'/>
	</div>
	<div>
		<label>Design</label> <input type="file" id="file-upload-button"
			name="file" value='<%=result.getString("file") %>'/>
	</div>
	<div>
		<label>Text</label>
		<textarea type="text" name="text" <input type="text" name="text" value='<%=result.getString("text") %>'/>></textarea>
	</div>
	<%
	}
	%>
	<button type="submit">Update</button>
	<a href="socialmedia.jsp">Back</a>
</form>
</html>
<%
String a = request.getParameter("id");
String person = request.getParameter("person");
String channel = request.getParameter("channel");
String category = request.getParameter("category");

Part part = request.getPart("file");//
String fileName = extractFileName(part);//file name
String savePath = "C:\\Users\\alina\\git\\MeetupApplication\\MeetupApplication\\WebContent\\pictures\\" + File.separator + fileName;
File fileSaveDir = new File(savePath);

part.write(savePath + File.separator);

private String extractFileName(Part part){//This method will print the file name.
    String contentDisp = part.getHeader("content-disposition");
    String[] items = contentDisp.split(";");
    for (String s : items) {
        if (s.trim().startsWith("filename")) {
            return s.substring(s.indexOf("=") + 2, s.length() - 1);
        }
    }
    return "";
}
%>
