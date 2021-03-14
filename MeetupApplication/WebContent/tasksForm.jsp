<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Meetup</title>
</head>
<body>
	<header>
		<nav>
			<div>
				<a>Tasks</a>
			</div>

			<ul class="navbar-nav">
				<li><a href="<%=request.getContextPath()%>/list"
					class="nav-link">Tasks</a></li>
			</ul>

			<ul>
				<li><a href="<%=request.getContextPath()%>/logout"
					class="nav-link">Logout</a></li>
			</ul>
		</nav>
	</header>
	<div class="container col-md-5">
		<div class="card">
			<div class="card-body">
				<c:if test="${todo != null}">
					<form action="update" method="post">
				</c:if>
				<c:if test="${todo == null}">
					<form action="insert" method="post">
				</c:if>

				<caption>
					<h2>
						<c:if test="${task != null}">
               Edit Task
              </c:if>
						<c:if test="${task == null}">
               Add New Task
              </c:if>
					</h2>
				</caption>

				<c:if test="${task != null}">
					<input type="hidden" name="taskID"
						value="<c:out value='${task.taskID}' />" />
				</c:if>
				<form>
				<fieldset class="form-group">
					<label>Task Title</label> <input type="text"
						value="<c:out value='${task.title}' />" class="form-control"
						name="title" required="required" minlength="5">
				</fieldset>

				<fieldset class="form-group">
					<label>Task Description</label> <input type="text"
						value="<c:out value='${task.description}' />" class="form-control"
						name="description" minlength="5">
				</fieldset>

				<fieldset class="form-group">
					<label>Task Status</label> <select class="form-control"
						name="isDone">
						<option value="false">In Progress</option>
						<option value="true">Complete</option>
					</select>
				</fieldset>

				<fieldset class="form-group">
					<label>Task Target Date</label> <input type="date"
						value="<c:out value='${task.targetDate}' />" class="form-control"
						name="targetDate" required="required">
				</fieldset>

				<button type="submit" class="btn btn-success">Save</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>