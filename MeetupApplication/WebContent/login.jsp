<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="<%=common.url%>/login.css">
<link rel="icon" type="image/png"
	href="<%=common.url%>pictures/meetup_logo.png">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.min.js"></script>
<script type="text/javascript" src="methods.js"></script>
</head>
<body>
	<div class="logo">
		<img src="pictures/meetup_logo.png" alt="Meetup">
	</div>
	<div class="loginbox">
		<h1>Already a Member?</h1>
		<h1>Login here</h1>
		<form action="login" method="post" id="loginForm">
			<p>E-Mail</p>
			<input type="text" name="email" placeholder="Enter E-Mail" />
			<p>Password</p>
			<input type="password" name="password" placeholder="Enter Password" /><br>${message}
			<p>Workspace</p>
			<input type="text" name="workspace" placeholder="Enter Workspace" />
			<input type="submit" value="Login">
			<input type="submit" value="Not a member?" onClick="register()"><br>
		</form>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
				rules : {
					email : {
						required : true,
						email : true
					},

					password : "required",
				},

				messages : {
					email : {
						required : "Please enter email",
						email : "Please enter a valid email address"
					},

					password : "Please enter password"
				}
			});

		});
	</script>
</body>
</html>