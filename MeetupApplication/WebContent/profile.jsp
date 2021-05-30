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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
</head>
<body>
	<div class="background1">
		<div class="headliner_block">
			<div class="logo">
				<a href="home.jsp?wID=${login.WID}"><img
					src="pictures/meetup_logo.png" alt="Home"></a>
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
					<li><a href="home.jsp?wID=${login.WID}">Home</a></li>
					<li><a href="list.jsp?wID=${login.WID}">List</a></li>
					<li><a href="board.jsp?wID=${login.WID}">Board</a></li>
					<li><a href="calendar.jsp?wID=${login.WID}">Calendar</a></li>
					<li><a href="progress.jsp?wID=${login.WID}">Progress</a></li>
					<li><a href="socialmedia.jsp?wID=${login.WID}">Social
							Media</a></li>
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
			<a class="workspace_tasks"
				onclick="document.getElementById('task_info').style.display='block'"
				style="width: auto;"></a>
		</div>

		<div class="organization_title">Organization</div>
		<br>
		<div class="organization">
			<div class="workingtime">Working Time</div>
			<br>
			<div class="newTime">
				<form action="addTime" method="post">
					<div style="margin: -12px 0px">
						<a class="aButtons2" onclick="checkWeek(this)">Week Number</a> <input
							type="text" name="kw" id="KWInput" required="required">
					</div>
					<div style="margin: 16px 0px">
						<label>Date</label> <input type="date" name="date" id="dateInput"
							style="margin-left: 20px;" required="required">
					</div>
					<div style="margin: 10px 0px">
						<label>Start</label> <input type="time" name="startTime"
							id="starttime" style="margin-left: 20px;" required="required">
					</div>
					<div style="margin: 10px 0px">
						<label>Stop</label> <input type="time" name="stopTime"
							id="stoptime" style="margin-left: 20px;" required="required">
					</div>
					<div style="margin: 10px 0px">
						<label>Pause</label> <input type="time" name="pauseTime"
							id="pausetime" style="margin-left: 10px;" required="required">
						<a style="margin-left: 10px;">Working Hours: <input
							type="text" name="duration" id="total" readonly="readonly"></a>
					</div>
					<input type="hidden" name="userSID" value='${login.userID}' />
					<div style="margin: 10px 0px">
						<a class="aButtons2" style="margin-right: 5px"
							href="startTimeTracker.jsp?userID=${login.userID}">Time Tracker</a>
						<button class="aButtons2" type="submit">Save</button>
					</div>
				</form>
			</div>
			<script>
			// Zeit-Differenz ermitteln
			window.addEventListener("DOMContentLoaded", function() {
				document.getElementById("starttime").addEventListener("change",
						SumHours);
				document.getElementById("stoptime").addEventListener("change",
						SumHours);
				document.getElementById("pausetime").addEventListener("change",
						SumHours);
			});

			function SumHours() {
				var starttime = document.getElementById('starttime').value;
				var stoptime = document.getElementById('stoptime').value;
				var pausetime = document.getElementById('pausetime').value;
				var diff = 0;

				if (starttime && stoptime && pausetime) {
					starttime = ConvertToSeconds(starttime);
					stoptime = ConvertToSeconds(stoptime);
					pausetime = ConvertToSeconds(pausetime);
					diff = Math.abs(stoptime - starttime - pausetime);
					document.getElementById('total').value = secondsToHHmmSS(diff);
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
			<script>
		Date.prototype.getWeekNumber = function(){
			  var d = new Date(Date.UTC(this.getFullYear(), this.getMonth(), this.getDate()));
			  var dayNum = d.getUTCDay() || 7;
			  d.setUTCDate(d.getUTCDate() + 4 - dayNum);
			  var yearStart = new Date(Date.UTC(d.getUTCFullYear(),0,1));
			  return "KW " + Math.ceil((((d - yearStart) / 86400000) + 1)/7)
			};

			function checkWeek() {
			  var dateInput = document.getElementById('dateInput').value;
			  var m = moment(dateInput, 'YYYY-MM-DD');
			  document.getElementById('KWInput').value = m.toDate().getWeekNumber();      
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