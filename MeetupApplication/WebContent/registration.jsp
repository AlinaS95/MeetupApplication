<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
<link rel="stylesheet" type="text/css" href="login.css">
<script type="text/javascript" src="methods.js"></script>
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
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
		<h1>Create a Account</h1>
		<form action="register" method="post" id="registerForm">
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

			<input type="submit" value="Submit">${message}

		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#registerForm").validate({
			rules : {
				email : {
					required : true,
					email : true
				},
				firstName : "required",
				lastName : "required",
				company : "required",
				position: "required",
				password : "required",
			},

			messages : {
				email : {
					required : "Please enter email",
					email : "Please enter a valid email address"
				},
				firstName : "Please enter your first name",
				lastName : "Please enter your last name",
				company : "Please enter a company",
				position: "Please enter a position",
				password : "Please enter password"
			}
		});

	});
</script>
</html>
