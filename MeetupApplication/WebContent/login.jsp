<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="login.css">
<script type="text/javascript" src="methods.js"></script>
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
</head>
<body>
	<div class="logo">
		<img src="pictures/meetup_logo.png" alt="Meetup">
	</div>
	<div class="loginbox">
		<h1>Already a Member?</h1>
		<h1>Login here</h1>
		<form action="<%=request.getContextPath()%>/login" method="post">
			<p>E-Mail</p>
			<input type="text" name="email" placeholder="Enter E-Mail" />
			<p>Password</p>
			<input type="password" name="password" placeholder="Enter Password" />
			<input type="submit" value="Submit"> 
			<input type="submit" name="" value="Not a member?" onClick="register()"><br>
		</form>
	</div>
</body>
</html>