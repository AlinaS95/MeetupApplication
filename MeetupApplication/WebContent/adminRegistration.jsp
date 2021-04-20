<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
<link rel="stylesheet" href="<%=common.url%>/login.css">
<link rel="icon" type="image/png"
	href="<%=common.url%>/pictures/meetup_logo.png">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.min.js"></script>
</head>
<body>
	<div class="logo">
		<img src="pictures/meetup_logo.png" alt="Meetup">
	</div>

	<div class="loginbox">
		<h1>Create a Admin-Account</h1>
		<form action="adminRegister" method="post" onsubmit="return validate();"
			id="registerForm">
			<p>*First Name</p>
			<input type="text" id="firstName" name="firstName"
				placeholder="Enter First Name" />

			<p>*Last Name</p>
			<input type="text" id="lastName" name="lastName"
				placeholder="Enter Last Name" />

			<p>*Email</p>
			<input type="text" id="email" name="email" placeholder="Enter Email" />

			<p>*Password</p>
			<input type="password" id="password" name="password"
				placeholder="Enter Password" />

			<p>*Password reply</p>
			<input type="password" name="" placeholder="Reply Password">

			<input type="submit" name="btn_register" value="Register">
		</form>
		<a class="buttonL" href="adminLogin.jsp" style="padding:10px 55px;">Already a member?</a>
	</div>
</body>
</html>
