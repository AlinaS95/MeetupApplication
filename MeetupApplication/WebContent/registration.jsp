<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
<link rel="stylesheet" type="text/css" href="login.css">
<script type="text/javascript" src="methods.js"></script>
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
</head>
<body>
	<div class="logo">
		<img src="pictures/meetup_logo.png" alt="Meetup">
	</div>

	<div class="loginbox">
		<h1>Create a Account</h1>
		<form action="<%= request.getContextPath() %>/register" method="post">
			<p>*First Name</p>
			<input type="text" id="firstName" name="firstName"
				placeholder="Enter First Name" />

			<p>*Last Name</p>
			<input type="text" id="lastName" name="lastName"
				placeholder="Enter Last Name" />

			<p>*Email</p>
			<input type="text" id="email" name="email" placeholder="Enter Email"
				/>

			<p>*Company</p>
			<input type="text" id="company" name="company"
				placeholder="Enter Company" />

			<p>*Position</p>
			<input type="text" id="position" name="position"
				placeholder="Enter Position" />

			<p>*Password</p>
			<input type="password" id="password" name="password"
				placeholder="Enter Password" />

			<p>*Password reply</p>
			<input type="password" name="" placeholder="Reply Password">

			<input type="submit" value="submit">

		</form>
	</div>
</body>
</html>
