<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@page import="javax.servlet.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="profile.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
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
					Welcome <a class="firstname">${login.firstName}</a>
				</h3>
				<a class="favorites"
					onclick="document.getElementById('p_favorites').style.display='block'"
					style="width: auto;"><img src="pictures/favorite.png"
					alt="Favorites"></a> <a class="status"
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
					<a href="profile.jsp"><img src="pictures/${login.fileName}"
						alt="Profile Picture" /></a>
				</div>
			</div>
			<br>
		</div>
		<div class="mainmenu">
			<nav>
				<ul>
					<li><a href="javascript:menue()"><img
							src="pictures/navigation.png" alt="Menu"></a></li>
					<li><a href="home.jsp">Home</a></li>
					<li><a href="javascript:list()">List</a></li>
					<li><a href="javascript:board()">Board</a></li>
					<li><a href="calendar.jsp">Calendar</a></li>
					<li><a href="javascript:progress()">Progress</a></li>
					<li><a href="socialmedia.jsp">Social Media</a></li>
				</ul>
				<div class="secondNavigation">
					<ul>
						<li><a class="add Task"
							onclick="document.getElementById('task_add').style.display='block'"
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

	<div class="background2">
		<br>
		<div class="profile_title">Profile</div>
		<br>
		<div class="profile_overview">
			<div class="profile_icon">
				<img src="pictures/${login.fileName}" alt="Profile Picture" /><br>
			</div>
			<br style="margin-bottom: 15px"> <a class="profile_info"><img
				src="pictures/infoicon.png" alt="information" /><a>${login.firstName}
			</a><a style="margin-right: 50px">${login.lastName}</a></a><br> <br>
			<a>${login.email}</a><br> <br> <a class="profile_settings"
				onclick="document.getElementById('p_settings').style.display='block'"
				style="width: auto;"><img src="pictures/settings.png"
				alt="Settings">Settings</a>
		</div>

		<!-- Pop-Up-Window Profile Settings-->
		<div id="p_settings" class="profile_popup">

			<!-- Window content -->
			<div class="popupBlock">
				<div class="popupHeader">
					Settings <span
						onclick="document.getElementById('p_settings').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
				<div class="popupBody">
					<input type="hidden" name="userID" value="${login.userID}" /> <img
						src="pictures/${login.fileName}" style="width: 65px; height: 65px" /><br>
					<a class="aButtons2"
						href="editProfilePicture.jsp?userID=${login.userID}"
						style="margin-left: 70px">Upload new photo</a> <br> <br>
					<hr>
					<div class="popupInfo">
						<a style="font-weight: bold">First Name: </a><a>${login.firstName}</a><br>
						<a style="font-weight: bold">Last Name: </a><a>${login.lastName}</a><br>
						<a style="font-weight: bold">Email: </a><a>${login.email}</a><br>
						<a style="font-weight: bold">Company: </a><a>${login.company}</a><br>
						<a style="font-weight: bold">Workspace: </a><a>${login.workspace}</a><br>
					</div>
					<div style="margin: 15px 25px">
						<a class="aButtons2" href="editProfile.jsp?userID=${login.userID}"><img
							src="pictures/settings.png" alt="Settings"
							style="width: 30px; height: 30px; margin: -4px -35px;">Edit
							User</a> <a class="aButtons2" href="logout.jsp"
							style="margin-left: 135px"><img src="pictures/logout.png"
							style="width: 25px; height: 25px; margin-left: -30px"
							alt="Logout" />Save and Logout</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Workspace -->
		<div class="workspace_title">Workspace</div>
		<br>
		<div class="workspace">
			<div class="project_name">${login.workspace}</div>
			<!-- Workspace Members -->
			<br> <br>Members<br> <a class="workspace_members"
				onclick="document.getElementById('w_members').style.display='block'
				"
				style="width: auto;"><img src="pictures/usericon.png"
				alt="Members"></a> <a class="workspace_members"
				onclick="document.getElementById('w_members').style.display='block'
				"
				style="width: auto;"><img src="pictures/usericon.png"
				alt="Members"></a> <a class="workspace_addmembers"
				onclick="document.getElementById('members_add').style.display='block'
				"
				style="width: auto;"><img src="pictures/add.png"
				alt="Add Members"></a> <br>

			<!-- Workspace Tasks -->
			<br> Tasks<br> <a class="workspace_tasks"
				onclick="document.getElementById('task_info').style.display='block'"
				style="width: auto;"><img src="pictures/workspaceTasks.png"
				alt="Tasks"></a><a class="workspace_addmembers"
				onclick="document.getElementById('task_add').style.display='block'
				"
				style="width: auto;"><img src="pictures/add.png" alt="Add Tasks"></a>
		</div>

		<!-- Pop-Up-Window Add Members-->
		<div id="members_add" class="navigation_addBlock">
			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					Manage your Team <span
						onclick="document.getElementById('members_add').style.display='none'
					"
						class="close" title="Schließen">&times; </span>
				</div>
				<div class="popupBody">
					<a>Add new member</a>
					<form action="addMember" method="post" id="addMemberForm">
						<p>Full Name</p>
						<input type="text" id="fullName" name="fullName"
							placeholder="Enter full name" />
						<p>Email</p>
						<input type="text" id="email" name="email"
							placeholder="Enter email" />
						<p>Workspace</p>
						<input type="text" id="workspace" name="workspace"
							placeholder="Enter workspace" />
						<p>Position</p>
						<input type="text" id="position" name="position"
							placeholder="Enter position" /> <input type="submit"
							name="btn_addMember" value="Add Member"> <input
							type="image" src="pictures/add.png" alt="Add">
					</form>
					<hr>
					<div class="membersList">
						<a href="<%=request.getContextPath()%>/workspaceManagement"
							class="nav-link">Members</a><br>
						<table>
							<c:forEach var="workspace" items="${listWorkspace}">
								<tr>
									<td><input type="image" src="pictures/usericon.png"
										alt="Member"></td>
									<td><c:out value="${workspace.workspaceID}" /></td>
									<td><c:out value="${workspace.teamName}" /></td>
									<td><c:out value="${workspace.fullName}" /></td>
									<td><c:out value="${workspace.email}" /></td>
									<td><input
										src="delete?workspaceID=<c:out value='${workspace.workspaceID}' />"
										type="image" src="pictures/delete.png" alt="delete member"
										style="width: 20px; height: 20px; margin-top: -10px; position: absolute"></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="popupFooter">
					<button onClick="save()">Save</button>
				</div>
			</div>
		</div>

		<!-- Pop-Up-Window Workspace Add Tasks -->
		<div id="task_add" class="navigation_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					<span
						onclick="document.getElementById('task_add').style.display='none'
					"
						class="close" title="Schließen">&times; </span>
				</div>
				<div class="popupBody">
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
											value="<c:out value='${task.description}' />"
											class="form-control" name="description" minlength="5">
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
											value="<c:out value='${task.targetDate}' />"
											class="form-control" name="targetDate" required="required">
									</fieldset>

									<button type="submit" class="btn btn-success">Save</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Pop-Up-Window Workspace Info Tasks -->
		<div id="task_info" class="navigation_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					Create a Task <span
						onclick="document.getElementById('task_info').style.display='none'
					"
						class="close" title="Schließen">&times; </span>
				</div>
				<div class="popupBody">
					<ul class="navbar-nav">
						<li><a href="<%=request.getContextPath()%>/list"
							class="nav-link">Tasks</a></li>
					</ul>
					<div class="row">
						<!-- <div class="alert alert-success" *ngIf='message'>{{message}}</div> -->
						<table>
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

										<td><a
											href="edit?taskID=<c:out value='${task.taskID}' />">Edit</a>
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
			</div>
		</div>

		<div class="organization_title">Organization</div>
		<br>
		<div class="organization">
			<div class="workingtime">Working Time</div>
			<br>
			<div class="newTime">
				<form action="addTime" method="post">
					<div>
						<label>Date</label> <input type="date" name="date" id="date"
							style="margin-left: 20px;" required="required">
					</div><br>
					<div>
						<label>Start</label> <input type="time" name="startTime"
							id="starttime" style="margin-left: 20px;" required="required">
					</div><br>
					<div>
						<label>Stop</label> <input type="time" name="stopTime"
							id="stoptime" style="margin-left: 20px;" required="required">
					</div><br>
					<div>
						<label>Pause</label> <input type="time" name="pauseTime"
							id="pausetime" style="margin-left: 10px;" required="required">
					</div><br>
					<div>
						<input name="workingSum" type="button" class="aButtons2" value="Calcuate"
							onclick="calculateTime()" /> <input
							type="number" step="0.01" name="duration"
							placeholder="Working hours" id='total'>
					</div>
					<button class="aButtons2" type="submit">Save</button>
						<a class="aButtons2" href="timeTracker.jsp"
							style="margin-left: 10px">Time Tracker</a>
				</form>
			</div>
			<script>
				function calculateTime() {
					var entry = document.getElementById('starttime');
					var exit = document.getElementById('stoptime');
					var pause = document.getElementById('pausetime');

					var entryTime = entry.value.split(':');
					var entryTimeInMins = entryTime[0] + entryTime[1];

					var pauseTime = pause.value.split(':');
					var pauseTimeInMins = pauseTime[0] + pauseTime[1] / 6 * 10;

					var exitTime = exit.value.split(':');
					var exitTimeInMins = exitTime[0] + exitTime[1];

					var totalTime = exitTimeInMins - entryTimeInMins;
					var totalTimeHour = (totalTime - pauseTimeInMins) / 100;

					document.getElementById('total').value = totalTimeHour;

				}
			</script>
		</div>
		<br> <br>
		<div class="logout">
			<a href="logout.jsp"><img src="pictures/logout.png" alt="Logout" />Logout</a>
		</div>
	</div>
</body>
</html>