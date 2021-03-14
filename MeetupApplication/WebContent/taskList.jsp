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
				<a>Tasks App</a>
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

	<div class="row">
		<!-- <div class="alert alert-success" *ngIf='message'>{{message}}</div> -->

		<div class="container">
			<h3 class="text-center">List of Tasks</h3>
			<hr>
			<div class="container text-left">

				<a href="<%=request.getContextPath()%>/new" class="btn btn-success">Add
					Task</a>
			</div>
			<br>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Title</th>
						<th>Target Date</th>
						<th>Task Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<!--   for (Task task: tasks) {  -->
					<c:forEach var="task" items="${listTasks}">

						<tr>
							<td><c:out value="${task.title}" /></td>
							<td><c:out value="${task.targetDate}" /></td>
							<td><c:out value="${task.status}" /></td>

							<td><a href="edit?taskID=<c:out value='${task.taskID}' />">Edit</a>
								&nbsp;&nbsp;&nbsp;&nbsp; <a
								href="delete?taskID=<c:out value='${task.taskID}' />">Delete</a></td>

							<!--  <td><button (click)="updateTask(task.taskID)" class="btn btn-success">Update</button>
                 <button (click)="deleteTask(task.taskID)" class="btn btn-warning">Delete</button></td> -->
						</tr>
					</c:forEach>
					<!-- } -->
				</tbody>

			</table>
		</div>
	</div>
</body>
</html>