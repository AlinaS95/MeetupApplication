<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="net.meetup.usermanagement.common" %>
<html>
<head>
<title>Registration</title>
<link rel="stylesheet" href="<%=common.url %>/login.css">
<script type="text/javascript" src="<%=common.url %>methods.js"></script>
<link rel="icon" type="image/png" href="<%=common.url %>/pictures/meetup_logo.png">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.min.js"></script>
</head>
<body>
	<div class="logo">
	 <img src="<%=common.url %>pictures/meetup_logo.png" alt="Meetup"/>
	</div>
	<div class="loginbox">
		<h1>Create a Account</h1>
		<c:if test="${user != null}">
			<form action="update" method="post">
		</c:if>
		<c:if test="${user == null}">
			<form action="register" method="post">
		</c:if>

		<caption>
			<h2>
				<c:if test="${user != null}">
            			Edit User
            		</c:if>
				<c:if test="${user == null}">
            			Add New User
            		</c:if>
			</h2>
		</caption>
		<form id="registerForm">
			<c:if test="${user != null}">
				<input type="hidden" name="userID"
					value="<c:out value='${user.userID}' />" />
			</c:if>
			<p>*First Name</p>
			<input type="text" id="firstName" name="firstName"
				value="<c:out value='${user.firstName}' />"
				placeholder="Enter First Name" />

			<p>*Last Name</p>
			<input type="text" id="lastName" name="lastName"
				value="<c:out value='${user.lastName}' />"
				placeholder="Enter Last Name" />

			<p>*Email</p>
			<input type="text" id="email" name="email"
				value="<c:out value='${user.email}' />" placeholder="Enter Email" />

			<p>*Company</p>
			<input type="text" id="company" name="company"
				value="<c:out value='${user.company}' />"
				placeholder="Enter Company" />

			<p>*Position</p>
			<input type="text" id="position" name="position"
				value="<c:out value='${user.position}' />"
				placeholder="Enter Position" />

			<p>*Password</p>
			<input type="password" id="password" name="password"
				value="<c:out value='${user.password}' />"
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
				position : "required",
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
				position : "Please enter a position",
				password : "Please enter password"
			}
		});

	});
</script>
</html>
