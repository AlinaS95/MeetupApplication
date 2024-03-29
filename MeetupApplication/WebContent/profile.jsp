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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

<!-- Search Tasks -->
<script>
	var request = new XMLHttpRequest();
	function searchInfo() {
		var taskName = document.vinform.taskName.value;
		var url = "search.jsp?val=" + taskName;

		try {
			request.onreadystatechange = function() {
				if (request.readyState == 4) {
					var val = request.responseText;
					document.getElementById('taskOutput').innerHTML = val;
				}
			}//end of function  
			request.open("GET", url, true);
			request.send();
		} catch (e) {
			alert("Unable to connect to server");
		}
	}
</script>
</head>
<body>
	<div class="background1">
	
		<!-- workspace -->
		<div class="headliner_block">
			<div class="logo">
				<a href="home.jsp?wID=${login.WID}"><img
					src="pictures/meetup_logo.png" alt="Home"></a>
			</div>
			<div class="firstBox">
				<h3>
					Welcome <a class="firstname">${login.firstName}</a>
				</h3>
				<a class="information" href="profile.jsp?wID=${login.WID}"><img
					src="pictures/infoicon.png" alt="Information"></a>
			</div>
			<br>
			
			<!-- search block -->
			<div class="secondblock">
				<div class="searchbox">
					<span class="searchicon"><img src="pictures/search.png"></span>
					<form name="vinform">
						<input id="search" type="text" name="taskName"
							onkeyup="searchInfo()">
					</form>
					<span id="taskOutput"></span>
				</div>
				<div class="user">
					<a href="profile.jsp?wID=${login.WID}"><img
						src="pictures/${login.fileName}" alt="Profile Picture" /></a>
				</div>
			</div>
			<br>
		</div>
		
		<!-- main menu -->
		<div class="mainmenu">
			<nav>
				<ul>
					<li><a><button id="start" class="buttonStart">
								<img src="pictures/navigation.png"
									style="width: 50px; height: 50px" alt="Menu">
							</button></a></li>
					<li><a href="home.jsp?wID=${login.WID}"><dfn
								class="tooltip">
								Home <span role="tooltip" style="font-weight: normal">You
									can find the home area here </span>
							</dfn></a></li>
					<li><a href="list.jsp?wID=${login.WID}"><dfn
								class="tooltip">
								List <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and create them</span>
							</dfn></a></li>
					<li><a href="board.jsp?wID=${login.WID}"><dfn
								class="tooltip">
								Board <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and their processing status </span>
							</dfn></a></li>
					<li><a href="startTimeTracker.jsp?userSID=${login.userID}"><dfn
								class="tooltip">
								Time Tracker <span role="tooltip" style="font-weight: normal">You
									can track your working time here </span>
							</dfn></a></li>
					<li><a href="progress.jsp?wID=${login.WID}"><dfn
								class="tooltip">
								Progress <span role="tooltip" style="font-weight: normal">Here
									you can find your project and team status</span>
							</dfn></a></li>
					<li><a href="socialmedia.jsp?wID=${login.WID}"><dfn
								class="tooltip">
								Social Media <span role="tooltip" style="font-weight: normal">Here
									you can find everything about your social media tasks</span>
							</dfn></a></li>
				</ul>
				
				<!-- second navigation -->
				<div class="secondNavigation">
					<ul>
						<li><a class="add"
							onclick="document.getElementById('add_task').style.display='block'"
							style="width: auto;"><img src="pictures/add.png" alt="Add"></a></li>
						<li><a
							onclick="document.getElementById('p_settings').style.display='block'"
							style="width: auto;"><img src="pictures/settings.png"
								alt="Settings"></a></li>
					</ul>
				</div>
			</nav>
			<dialog id="dialog"> <img src="pictures/meetup_logo.png"
				height="70" width="80" alt="Meetup Logo" hspace="100" vspace="10">
			<hr>
			
			<!-- second menu -->
			<ul class="navMenu">
				<li><img src="pictures/home.png" height="40" width="40"
					hspace="1" vspace="1" alt="home"><a
					href="home.jsp?wID=${login.WID}" style="text-decoration: none">Home</a></li>
				<li><img src="pictures/task.png" height="40" width="40"
					hspace="1" vspace="1" alt="task"><a
					href="list.jsp?wID=${login.WID}" style="text-decoration: none">My
						Tasks</a></li>
				<li><img src="pictures/inbox.png" height="40" width="40"
					hspace="1" vspace="1" alt="inbox"><a
					href="inbox.jsp?wID=${login.WID}" style="text-decoration: none">Inbox</a></li>
				<li><img src="pictures/person.png" height="40" width="40"
					hspace="1" vspace="1" alt="person"><a
					href="profile.jsp?wID=${login.WID}" style="text-decoration: none">Profile</a></li>

				<hr>
				<a href="progress.jsp?wID=${login.WID}">Reports:</a>
				<li><a href="progress.jsp?wID=${login.WID}"
					style="text-decoration: none">Tasks I created</a></li>
				<li><a href="list.jsp?wID=${login.WID}"
					style="text-decoration: none">Tasks I assigned to others</a></li>
				<li><a href="progress.jsp?wID=${login.WID}"
					style="text-decoration: none">Recently completed Tasks</a></li>
				<br>
				<hr>
				<p>Team:</p>
				<%
					try {
						String wID = request.getParameter("wID");
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
						Statement st = con.createStatement();
						String sql = "SELECT * FROM user WHERE wID=" + wID;
						ResultSet rs = st.executeQuery(sql);
						int i = 0;
						while (rs.next()) {
							String firstName = rs.getString("firstName");
							String lastName = rs.getString("lastName");
							String workspace = rs.getString("workspace");
							String fileName = rs.getString("filename");
				%>
				<input type="hidden" name="wID" value='<%=rs.getString("wID")%>' />
				<img class="membersImg"
					style="border-radius: 100%; width: 50px; height: 50px"
					src="pictures/<%=fileName%>" title="<%=firstName%> <%=lastName%>" />
				<input type="hidden" name="wID" value='<%=rs.getString("wID")%>' />

				<%
					}
					} catch (Exception e) {
						out.println(e);
					}
				%>

			</ul>
			<div id="Abbruch">
				<img src="pictures/baseline_close_black_18dp.png">
			</div>
			<br>
			<div id="punkte"></div>
			</dialog>

			<script>
				var startbutton = document.getElementById("start"), dialog = document
						.getElementById('dialog'), Abbruch = document
						.getElementById("Abbruch");
				startbutton.addEventListener('click', zeigeFenster);
				Abbruch.addEventListener('click', schließeFenster);

				function zeigeFenster() {
					dialog.showModal();
				}

				function schließeFenster() {
					dialog.close();
				}
			</script>

			<!-- Pop-Up-Window New Task -->
			<div id="add_task" class="navigation_addBlock">
				<!-- Window content -->
				<div class="addBlock">
					<div class="popupHeader">
						Add new Task <span
							onclick="document.getElementById('add_task').style.display='none'
					"
							class="close" title="Schließen">&times;</span>
					</div>
					<div class="popupBody_list">
						<div class="popupInfo">
							<form action="UploadTask" method="post"
								enctype="multipart/form-data">
								<div>
									<label>Title</label> <input type="text" name="taskName"
										required="required" style="margin-left:55px" /> <input type="hidden" name="wID"
										value="${login.WID}" />
								</div>
								<div>
									<label>Description</label>
									<textarea name="description"></textarea>
								</div>
								<div>
									<label>Due Date</label> <input type="date" name="dueDate"
										style="margin-left: 18px;" required="required">
								</div>
								<div>
									<label>Status</label> <select name="taskStatus"
										style="margin-left: 45px">
										<option selected="">Select the category</option>
										<option value="To do">To do</option>
										<option value="In Progress">In Progress</option>
										<option value="Done">Done</option>
									</select>
								</div>
								<div>
									<label>Assignee</label> <select name="userSID"
										style="margin-left: 20px" id="assignee"
										onchange="singleSelectChangeText()" required="required">
										<option value="" disabled selected>Select the
											assignee</option>
										<%
											try {
												String wID = request.getParameter("wID");
												Class.forName("com.mysql.cj.jdbc.Driver");
												Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
												Statement st = con.createStatement();
												String sql = "SELECT * FROM user WHERE user.wID=" + wID;
												ResultSet rs = st.executeQuery(sql);
												int i = 0;
												while (rs.next()) {
													String userID = rs.getString("userID");
													String firstName = rs.getString("firstName");
										%>
										<option value="<%=userID%>"><%=firstName%></option>
										<%
											}
											} catch (Exception e) {
												out.println(e);
											}
										%>
									</select> <input id="selectAssignee" type="hidden" name="assignee">
								</div>
								<div>
									<label>Internal Inquiries</label> <input type="text"
										name="internalInquiries"/>
								</div>

								<div>
									<label>Attachment</label> <input type="file"
										style="margin-left:-1px" id="file-upload-button" name="file" required="required" />
								</div>

								<div>
									<label>Completion in %</label> <input type="number"
										style="width:50px" name="completion" required="required" />
								</div>

								<button type="submit">Save</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<script>
			function singleSelectChangeText() {
				//Getting Value

				var selObj = document.getElementById("assignee");
				var selValue = selObj.options[selObj.selectedIndex].text;

				//Setting Value
				document.getElementById("selectAssignee").value = selValue;
			}
		</script>

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
						<input type="hidden" name="userID" value="${login.userID}" /> <input
							type="hidden" name="wID" value="${login.WID}" /> <img
							src="pictures/${login.fileName}"
							style="width: 65px; height: 65px" /><br> <a
							class="aButtons2"
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
							<a class="aButtons2"
								href="editProfile.jsp?userID=${login.userID}"><img
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
		</div>
	</div>

	<!-- main content-->
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

		<!-- Workspace -->
		<div class="workspace_title">Workspace</div>
		<br>
		<div class="workspace">
			<div class="project_name">${login.workspace}</div>
			
			<!-- Workspace Members -->
			<br> Members<br>
			<%
				try {
					String wID = request.getParameter("wID");
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
					Statement st = con.createStatement();
					String sql = "SELECT * FROM user WHERE wID=" + wID;
					ResultSet rs = st.executeQuery(sql);
					int i = 0;
					while (rs.next()) {
						String firstName = rs.getString("firstName");
						String lastName = rs.getString("lastName");
						String workspace = rs.getString("workspace");
						String fileName = rs.getString("filename");
			%>
			<input type="hidden" name="wID" value='<%=rs.getString("wID")%>' />
			<img class="membersImg"
				style="border-radius: 100%; width: 50px; height: 50px"
				src="pictures/<%=fileName%>" title="<%=firstName%> <%=lastName%>" /><input
				type="hidden" name="wID" value='<%=rs.getString("wID")%>' />

			<%
				}
				} catch (Exception e) {
					out.println(e);
				}
			%>

			<!-- Workspace Tasks -->
			<br> Tasks<br>
			<%
				try {
					String wID = request.getParameter("wID");
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
					Statement st = con.createStatement();
					String sql = "SELECT * FROM tasks,user WHERE user.firstName = tasks.assignee AND tasks.wID=" + wID;
					ResultSet rs = st.executeQuery(sql);
					int i = 0;
					while (rs.next()) {
						String taskID = rs.getString("taskID");
						String taskName = rs.getString("taskName");
						String filename = rs.getString("filename");
			%>
			<img class="taskImage" src="pictures/workspaceTasks.png" alt="Tasks"><input
				type="hidden" name="taskID" value='<%=rs.getString("taskID")%>' />
			<a class="taskName" href="list.jsp?wID=${login.WID}"><%=taskName%></a><input
				type="hidden" name="wID" value='<%=rs.getString("wID")%>' /><br>
			<%
				}
				} catch (Exception e) {
					out.println(e);
				}
			%>
			<a href="list.jsp?wID=${login.WID}"><img class="taskImage"
				src="pictures/add.png" alt="Add"></a>
		</div>

		<div class="organization_title">Organization</div>
		<br>
		<div class="organization">
			<div class="workingtime">Working Time</div>
			<br>

			<!-- Add Task Time -->
			<div class="newTaskTime">
				<form action="addTaskTime" method="post">
					<div style="margin: -5px 0px">
						<img class="taskImage" style="position: absolute"
							src="pictures/workspaceTasks.png" alt="Tasks"> <input
							type="hidden" name="tID" value="${login.userID}"> <select
							name="taskSID" id="taskName" style="margin: 5px 40px"
							onchange="singleSelectChangeText()" required="required">
							<option selected="">What are you working on?</option>
							<%
								try {
									String wID = request.getParameter("wID");
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
									Statement st = con.createStatement();
									String sql = "SELECT * FROM tasks WHERE wID=" + wID;
									ResultSet rs = st.executeQuery(sql);
									int i = 0;
									while (rs.next()) {
										String taskID = rs.getString("taskID");
										String taskName = rs.getString("taskName");
										String assignee = rs.getString("assignee");
							%>
							<option value="<%=taskID%>"><%=taskName%></option>
							<%
								}
								} catch (Exception e) {
									out.println(e);
								}
							%>
						</select> <input id="selectTask" type="hidden" name="taskName"><br>
						<label style="margin-left: 20px;">Date</label> <input type="date"
							style="margin: 5px 0px; margin-right: 5px" id="theDate"
							name=taskDate><label>Week</label> <input type="number"
							style="width: 35px" name="week" id="theWeek" required="required"><br>
						<label style="margin-left: 20px;">Start</label> <input type="time"
							style="margin: 5px 0px" name="startTask" id="startTask"><br>
						<label style="margin-left: 20px;">Stop</label> <input type="time"
							style="margin: 5px 0px" name="stopTask" id="stopTask"> <a
							style="margin-left: 15px;">Hours: <input type="text"
							name="taskSum" id="taskSum" style="width: 50px"
							readonly="readonly"></a><br>
						<div style="margin: 15px 0px">
							<a class="aButtons2" style="margin: 20px"
								href="startTimeTracker.jsp?userSID=${login.userID}">Time
								Tracker</a>
							<button class="aButtons2" type="submit">Save</button>
						</div>
					</div>
				</form>
			</div>

			<script>
			function singleSelectChangeText() {
				//Getting Value

				var selObj = document.getElementById("taskName");
				var selValue = selObj.options[selObj.selectedIndex].text;

				//Setting Value
				document.getElementById("selectTask").value = selValue;
			}
		</script>

			<!-- Show current week -->
			<script> 
			Date.prototype.getWeek = function() {
				  var onejan = new Date(this.getFullYear(),0,1);
				  return Math.ceil((((this - onejan) / 86400000) + onejan.getDay()+1)/7);
				}

				var today = new Date();
				var weekNumber = today.getWeek();
				document.getElementById('theWeek').value = weekNumber;
		</script>

			<!-- Show current date -->
			<script> 
		var date = new Date();

		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();

		if (month < 10) month = "0" + month;
		if (day < 10) day = "0" + day;

		var today = year + "-" + month + "-" + day;


		document.getElementById('theDate').value = today;
		</script>

			<!-- Calculate time difference  -->
			<script>
			window.addEventListener("DOMContentLoaded", function() {
				document.getElementById("startTask").addEventListener("change",
						SumHoursTask);
				document.getElementById("stopTask").addEventListener("change",
						SumHoursTask);
			});

			function SumHoursTask() {
				var startTask = document.getElementById('startTask').value;
				var stopTask = document.getElementById('stopTask').value;
				var diff = 0;

				if (startTask && stopTask) {
					startTask = ConvertToSeconds(startTask);
					stopTask = ConvertToSeconds(stopTask);
					diff = Math.abs(stopTask - startTask);
					document.getElementById('taskSum').value = secondsToHHmmSS(diff);
				}

				function ConvertToSeconds(time) {
					var splitTime = time.split(":");
					return splitTime[0] * 3600 + splitTime[1] * 60;
				}

				function secondsToHHmmSS(secs) {
					var hours = parseInt(secs / 3600);
					var seconds = parseInt(secs % 3600);
					var minutes = parseInt(Math.trunc(seconds/60)/60*100);
					if (minutes < 10) {
						minutes = '0' + minutes;
					}
					return hours + "." + minutes;
				}
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