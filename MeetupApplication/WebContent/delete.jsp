<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Account</title>
</head>
<body>
<form action="deleteAction.jsp" method="post">
<table align="center">
<th colspan="2" style="padding:20px">Delete Account</th>
<tr>
<td>Email: </td>
<td><input type="text" name="email"></td>
</tr>
<tr>
<td></td>
<td><input type="reset" value="Clear"> &nbsp <input type ="submit" value="Delete"></td>
</tr>
<tr>
<td> Go to <a href="home.html">Home</a></td>
</tr>
</table></form>

</body>
</html>