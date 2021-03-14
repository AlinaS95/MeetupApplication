<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List</title>
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="stylesheet" type="text/css" href="list.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
<script type="text/javascript" src="list.js"></script>


</head>
<body>
	<div class="background1">
		<div class="headliner_block">
			<div class="logo">
				<a href="javascript:home()"><img src="pictures/meetup_logo.png"
					alt="Home"></a>
			</div>
			<div class="firstBox">
				<h3>
					Workspace: <a class="workspace">${login.workspace}</a>
				</h3>
				<a class="information"
					onclick="document.getElementById('p_info').style.display='block'"
					style="width: auto;"><img src="pictures/infoicon.png"
					alt="Information"></a> <a class="status"
					href="javascript:progress()"><img
					src="pictures/greenCircle.png" alt="Status"></a>
			</div>
			<br>
			<div class="secondblock">
				<div class="searchbox">
					<span class="searchicon"><img src="pictures/search.png"></span>
					<input type="search" id="search" placeholder="Search..." />
				</div>
				<div class="user">
					<a href="javascript:profile()"><img src="pictures/usericon.png"
						alt="Profil Icon" /></a>
				</div>
			</div>
			<br>
		</div>
		<div class="mainmenu">
			<nav>
				<ul>
					<li><a href="javascript:menue()"><img
							src="pictures/navigation.png" alt="Menu"></a></li>
					<li><a href="javascript:home()"> <dfn class="tooltip">
								Home <span role="tooltip" style="font-weight: normal">You
									can find the home area here </span>
							</dfn></a></li>
					<li><a href="javascript:list()" style="font-weight: bold">
							<dfn class="tooltip">
								List <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and create them</span>
							</dfn>
					</a></li>

					<li><a href="javascript:board()" style="font-weight: normal">
							<dfn class="tooltip">
								Board <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and their processing status </span>
							</dfn>
					</a></li>

					<li><a href="javascript:calendar()"
						style="font-weight: normal"> <dfn class="tooltip">
								Calendar <span role="tooltip" style="font-weight: normal">You
									can find your calendar here </span>
							</dfn></a></li>

					<li><a href="javascript:progress()"
						style="font-weight: normal"> <dfn class="tooltip">
								Progress <span role="tooltip" style="font-weight: normal">Here
									you can find your project and team status</span>
							</dfn></a></li>

					<li><a href="javascript:socialmedia()"
						style="font-weight: normal"> <dfn class="tooltip">
								Social Media <span role="tooltip" style="font-weight: normal">Here
									you can find everything about your social media tasks</span>
							</dfn></a></li>
				</ul>
				<div class="secondNavigation">
					<ul>
						<li><a class="add"
							onclick="document.getElementById('l_add').style.display='block'"
							style="width: auto;"><img src="pictures/add.png" alt="Add"></a></li>
						<li><a class="profile_settings"
							onclick="document.getElementById('p_settings').style.display='block'"
							style="width: auto;"><img src="pictures/settings.png"
								alt="Settings"></a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	<!-- Pop-Up-Window -->
	<div id="l_add" class="navigation_addBlock">

		<!-- Window content -->
		<div class="addBlock">
			<div class="popupHeader">
				Add<span
					onclick="document.getElementById('l_add').style.display='none'"
					class="close" title="Schließen">&times;</span>
			</div>
			<div class="popupBody"></div>
		</div>
	</div>

	<div class="background2">
		<br>

		<!-- List Navigation -->

		<div class="list_navigation">
			<nav>
				<ul>
					<li><a class="sortTask"
						onclick="document.getElementById('task_sort').style.display='block'"
						style="width: auto;"><img src="pictures/sort.png" alt="Sort">Sort</a></li>
					<li><a class="filterTask"
						onclick="document.getElementById('task_filter').style.display='block'"
						style="width: auto;"><img src="pictures/filter.png"
							alt="Settings">Filter</a></li>
					<li><a class="addTask"
						onclick="document.getElementById('task_add').style.display='block'"
						style="width: auto;"><img src="pictures/add.png" alt="Add">New
							Task</a></li>
				</ul>
			</nav>
		</div>

		<!-- Pop-Up-Window Workspace Add Tasks -->
		<div id="task_add" class="navigation_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<span
						onclick="document.getElementById('task_add').style.display='none'
					"
						class="close" title="Schließen">&times; </span>
					<div class="listBody">
						<div>
							<div>
								<c:if test="${task != null}">
									<form action="update" method="post">
								</c:if>
								<c:if test="${task == null}">
									<form action="insert" method="post">
								</c:if>

								<caption>
									<h2>
										<c:if test="${task != null}">Edit Task</c:if>
										<c:if test="${task == null}">Add New Task</c:if>
									</h2>
								</caption>
							</div>
							<div class="popupBody">
								<c:if test="${task != null}">
									<input type="hidden" name="taskID"
										value="<c:out value='${task.taskID}' />" />
								</c:if>
								<fieldset>
									<label>Task Name</label> <input type="text"
										value="<c:out value='${task.title}' />" class="form-control"
										name="title" required="required" minlength="5">
								</fieldset>

								<fieldset>
									<label>Description</label> <input type="text"
										value="<c:out value='${task.description}' />"
										class="form-control" name="description" minlength="5">
								</fieldset>

								<fieldset>
									<label>Due Date</label> <input type="date"
										value="<c:out value='${task.targetDate}' />"
										class="form-control" name="targetDate" required="required">
								</fieldset>

								<fieldset>
									<label>Task Status</label> <select class="form-control"
										name="isDone">
										<option value="false">In Progress</option>
										<option value="true">Complete</option>
									</select>
								</fieldset>

								<fieldset>
									<label>Assignee</label> <input type="text"
										value="<c:out value='${task.assignee}' />"
										class="form-control" name="assignee" required="required">
								</fieldset>
								<div class="popupFooter">
								<button type="submit">Save</button>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<hr>
		<br>
		<ul>
			<li style="list-style: none;"><a
				href="<%=request.getContextPath()%>/list" class="nav-link">Tasks</a></li>
		</ul>

		<!-- List Tabelle -->
		<table class="list-table">
			<thead>
				<tr>
					<th>Task Name</th>
					<th>Description</th>
					<th>Due Date</th>
					<th>Task Status</th>
					<th>Assignee</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<!--   for (Task task: tasks) {  -->
				<c:forEach var="task" items="${listTasks}">

					<tr>
						<td><c:out value="${task.title}" /></td>
						<td><c:out value="${task.description}" /></td>
						<td><c:out value="${task.targetDate}" /></td>
						<td><c:out value="${task.status}" /></td>
						<td><c:out value="${task.assignee}" /></td>
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
<div></div>
	</div>


</body>
</html>