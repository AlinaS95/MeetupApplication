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
</head>
<body>
	<div class="logo">
		<img src="pictures/meetup_logo.png" alt="Meetup">
	</div>
	<div class="loginbox">
		<h1>Already a Member?</h1>
		<h1>Login here</h1>
		<form action="LoginController" method="post" name="LoginForm" id="loginForm" onsubmit="return validate();">
		<p>
		<%
		if(request.getAttribute("WrongLoginMsg")!=null)
		{out.println(request.getAttribute("WrongLoginMsg"));
		}
		%>
		</p>
			<p>E-Mail</p>
			<input type="text" name="email" placeholder="Enter E-Mail" />
			<p>Password</p>
			<input type="password" name="password" placeholder="Enter Password" />
			<input type="submit" name="btn_login" value="Login"> 
			<input type="submit" value="Not a member?" onClick="registration.jsp"><br>
		</form>
	</div>
<script>
function validate()
{
	var email = document.email;
	var password = document.password;
	
	if (email.value == null || email.value == "")
		{
		window.alert("please enter email");
		email.focus();
		return false;
		}
	if (password.value == null || password.value == "")
		{
		window.alert("please enter password");
		password.focus();
		return false;
		}
	}
</script>
</body>
</html>