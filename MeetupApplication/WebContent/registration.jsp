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
		<h1>Create a Account</h1>
		<form action="register" method="post" onsubmit="return validate();"
			id="registerForm" enctype="multipart/form-data">
			<p>*First Name</p>
			<input type="text" id="firstName" name="firstName"
				placeholder="Enter First Name" />

			<p>*Last Name</p>
			<input type="text" id="lastName" name="lastName"
				placeholder="Enter Last Name" />

			<p>*Email</p>
			<input type="text" id="email" name="email" placeholder="Enter Email" />

			<p>*Company</p>
			<input type="text" id="company" name="company"
				placeholder="Enter Company" />

			<p>*Workspace</p>
			<select name="wID" id="wID" onchange="singleSelectChangeText()">
				<option selected="">Select your workspace</option>
				<option value="1">Marketing</option>
				<option value="2">Website</option>
				<option value="3">IT</option>
			</select> <input id="myWorkspace" type="hidden" name="workspace"><br><br>

			<p>*Password</p>
			<input type="password" id="password" name="password"
				placeholder="Enter Password" />

			<p>*Password reply</p>
			<input type="password" name="" placeholder="Reply Password">

			<p>Profile Picture</p>
			<input type="file" id="file-upload-button" name="file"
				required="required" /> <input type="submit" name="btn_register"
				value="Register">
		</form>
		<a class="buttonL" href="login.jsp">Already a member?</a><br><br>
	</div>

	<script>
		function singleSelectChangeText() {
			//Getting Value

			var selObj = document.getElementById("wID");
			var selValue = selObj.options[selObj.selectedIndex].text;

			//Setting Value
			document.getElementById("myWorkspace").value = selValue;
		}
	</script>
</body>
</html>
