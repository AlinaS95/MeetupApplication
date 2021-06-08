<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,java.io.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="net.meetup.utils.JDBCUtils"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.sql.Time"%>
<%@page import="javax.servlet.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Time Tracker</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="list.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="stylesheet" type="text/css" href="timeTracker.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
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
		<div class="headliner_block">
			<div class="logo">
				<a href="javascript:home()"><img src="pictures/meetup_logo.png"
					alt="Home"></a>
			</div>
			<div class="firstBox">
				<h3>
					Workspace: <a class="workspace">${login.workspace}</a>
				</h3>
				<a class="information" href="profile.jsp?wID=${login.WID}"><img src="pictures/infoicon.png"
					alt="Information"></a>
			</div>
			<br>
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
		<div class="mainmenu">
			<nav>
				<ul>
					<li><a href="javascript:menue()"><img
							src="pictures/navigation.png" alt="Menu"></a></li>
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
					<li><a href="startTimeTracker.jsp?userSID=${login.userID}"
						style="font-weight: bold"><dfn class="tooltip">
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
		</div>
	</div>
	<!-- Pop-Up-Window New Task -->
	<div id="add_task" class="navigation_addBlock">
		<!-- Window content -->
		<div class="popupBlock">
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
								required="required" /> <input type="hidden" name="wID"
								value="${login.WID}" />
						</div>
						<div>
							<label>Description</label>
							<textarea name="description"></textarea>
						</div>
						<div>
							<label>Due Date</label> <input type="date" name="dueDate"
								style="margin-left: 33px;" required="required">
						</div>
						<div>
							<label>Status</label> <select name="taskStatus"
								style="margin-left: -2px">
								<option selected="">Select the category</option>
								<option value="To do">To do</option>
								<option value="In Progress">In Progress</option>
								<option value="Done">Done</option>
							</select>
						</div>
						<div>
							<label>Assignee</label> <select name="userSID"
								style="margin-left: -2px" id="assignee"
								onchange="singleSelectChangeText()" required="required">
								<option value="" disabled selected>Select the assignee</option>
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
								name="internalInquiries" required="required" />
						</div>

						<div>
							<label>Attachment</label> <input type="file"
								id="file-upload-button" name="file" required="required" />
						</div>

						<div>
							<label>Completion in %</label> <input type="number"
								name="completion" required="required" />
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
						style="width: 25px; height: 25px; margin-left: -30px" alt="Logout" />Save
						and Logout</a>
				</div>
			</div>
		</div>
	</div>

	<div class="background2">
		<br>
		<div class="backIcon">
			<a href="startTimeTracker.jsp?userSID=${login.userID}"><img
				src="pictures/back.png" alt="Back"></a>
		</div>
		<div class="header2">Working Time</div>
		<hr>
		<br>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");

				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();

				String id = request.getParameter("id");
				String sql = "select * from workingtime WHERE id=" + id;
				ResultSet rs = st.executeQuery(sql);

				while (rs.next()) {
		%>
		<div class="workingOutput">
			<b><%=rs.getDate("date")%></b>
		</div>

		<%
			}
			} catch (Exception e) {
				out.println("No tasks today");
			}
		%>
		<br>
		<table class="selectWorkingtime">
			<thead>
				<tr class="week">
					<th style="width: 335px">Task</th>
					<th style="width: 200px">Start</th>
					<th style="width: 200px">Stop</th>
					<th style="width: 200px">Hours</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");

				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();

				String id = request.getParameter("id");
				String sql = "select * from tasktime,workingtime WHERE DATE(tasktime.taskDate)=DATE(workingtime.date) AND workingtime.id="
						+ id;
				ResultSet rs = st.executeQuery(sql);

				while (rs.next()) {
					String taskTimeID = rs.getString("taskTimeID");
					String taskName = rs.getString("taskName");
					String week = rs.getString("week");
					LocalDate taskDate = rs.getDate("taskDate").toLocalDate();
					LocalTime startTask = rs.getTime("startTask").toLocalTime();
					LocalTime stopTask = rs.getTime("stopTask").toLocalTime();
					String taskSum = rs.getString("taskSum");
					String tID = rs.getString("tID");
		%>
		<input type="hidden" name="taskTimeID"
			value='<%=rs.getString("taskTimeID")%>' />
		<table class="selectWorkingtime">
			<tr>
				<td style="width: 335px;"><%=taskName%></td>
				<td style="width: 200px;"><%=startTask%></td>
				<td style="width: 200px;"><%=stopTask%></td>
				<td style="width: 200px;"><%=taskSum%>h</td>
			</tr>
			</tbody>
		</table>
		<%
			}
			} catch (Exception e) {
				out.println("No tasks today");
			}
		%>
		<br>
		<table class="selectWorkingtime" style="margin: 0px 285px">
			<thead>
				<tr class="week">
					<th style="width: 830px">Working Time</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");

				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();

				String id = request.getParameter("id");
				String sql = "select * from workingtime WHERE id=" + id;
				ResultSet rs = st.executeQuery(sql);

				while (rs.next()) {
		%>
		<table class="selectWorkingtime" style="margin: 0px 285px">
			<tr>
				<td style="width: 200px;"><%=rs.getTime("startTime")%></td>
				<td style="width: 200px;"><%=rs.getTime("stopTime")%></td>
				<td style="width: 200px;"><%=rs.getString("pauseTime")%></td>
				<td style="width: 200px;"><%=rs.getString("duration")%></td>
			</tr>
			</tbody>
		</table>

		<%
			}
			} catch (Exception e) {
				out.println("No tasks today");
			}
		%>
		<hr>
	</div>
</body>
</html>
