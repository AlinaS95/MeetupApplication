<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.sql.Time"%>
<%@page import="java.io.*,java.util.*"%>
<%@page import="javax.servlet.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Time Tracker</title>
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="stylesheet" type="text/css" href="list.css">
<link rel="stylesheet" type="text/css" href="timeTracker.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
<script type="text/javascript" src="list.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
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
				<a href="home.jsp?wID=${login.WID}"><img
					src="pictures/meetup_logo.png" alt="Home"></a>
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
		<div class="header2">Time Tracker</div>
		<hr>

		<%
			Date dNow = new Date();
			SimpleDateFormat ft = new SimpleDateFormat("EEEE',' dd.MM.yyyy");
			out.print("<h2>" + ft.format(dNow) + "</h2>");
		%>
		<!-- Add Task Time -->
		<div class="newTaskTime">
			<form action="addTaskTime" method="post">
				<div>
					<img class="taskImage" src="pictures/workspaceTasks.png"
						alt="Tasks"> <input type="hidden" name="tID"
						value="${login.userID}"> <select name="taskSID"
						id="taskName" style="margin-left: -2px"
						onchange="singleSelectChangeText()" required="required">
						<option selected="">What are you working on?</option>
						<%
							try {
								String userSID = request.getParameter("userSID");
								Class.forName("com.mysql.cj.jdbc.Driver");
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
								Statement st = con.createStatement();
								String sql = "SELECT * FROM tasks WHERE userSID=" + userSID;
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
					</select><input id="selectTask" type="hidden" name="taskName"> <input
						type="hidden" id="theDate" name=taskDate> <input
						type="hidden" style="width: 35px" name="week" id="theWeek"
						required="required"><label style="margin-left: 20px;">Start</label>
					<input type="time" name="startTask" id="startTask"> <label
						style="margin-left: 20px;">Stop</label> <input type="time"
						name="stopTask" id="stopTask"> <a
						style="margin-left: 15px;">Hours: <input type="text"
						name="taskSum" id="taskSum" style="width: 50px"
						readonly="readonly"></a>
					<button type="submit">Save</button>
				</div>
			</form>

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
		</div>

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
		<br>
		<!-- Break -->
		<div class="newTaskTime">
			<form action="addTaskTime" method="post">
				<label style="font-weight: bold">Take a break: </label><input
					type="hidden" name="tID" value="${login.userID}"> <input
					type="hidden" name="taskName" value="Break"> <input
					type="hidden" id="theDate2" name=taskDate> <input
					type="hidden" style="width: 35px" name="week" id="theWeek2">
				<label style="margin-left: 20px;">Start</label> <input type="time"
					name="startTask" id="startPause"> <label
					style="margin-left: 20px;">Stop</label> <input type="time"
					name="stopTask" id="stopPause"> <a
					style="margin-left: 15px;">Hours: <input type="text"
					name="taskSum" id="pauseSum" style="width: 50px"
					readonly="readonly">
				</a>
				<button type="submit">Save</button>
			</form>

			<!-- Show current week -->
			<script> 
			Date.prototype.getWeek = function() {
				  var onejan = new Date(this.getFullYear(),0,1);
				  return Math.ceil((((this - onejan) / 86400000) + onejan.getDay()+1)/7);
				}

				var today = new Date();
				var weekNumber = today.getWeek();
				document.getElementById('theWeek2').value = weekNumber;
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


		document.getElementById('theDate2').value = today;
		</script>

			<!-- Calculate time difference  -->
			<script>
			window.addEventListener("DOMContentLoaded", function() {
				document.getElementById("startPause").addEventListener("change",
						SumHoursPause);
				document.getElementById("stopPause").addEventListener("change",
						SumHoursPause);
			});

			function SumHoursPause() {
				var startPause = document.getElementById('startPause').value;
				var stopPause = document.getElementById('stopPause').value;
				var diff = 0;

				if (startPause && stopPause) {
					startPause = ConvertToSeconds(startPause);
					stopPause = ConvertToSeconds(stopPause);
					diff = Math.abs(stopPause - startPause);
					document.getElementById('pauseSum').value = secondsToHHmmSS(diff);
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
					return "-"+hours + "." + minutes;
				}
			}
		</script>
		</div>
		<br>
		<table class="taskTime">
			<thead>
				<tr>
					<td style="text-align: left; font-weight: bold">Today:</td>

					<td style="text-align: right; padding: 0px 10px">
						<%
							try {
								String userSID = request.getParameter("userSID");
								Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
								Statement st = con.createStatement();
								String strQuery = "SELECT sum(CAST(taskSum AS DECIMAL(9,2))) FROM tasktime WHERE DATE(taskDate)=DATE(NOW()) AND tID="
										+ userSID;
								ResultSet rs = st.executeQuery(strQuery);
								String totalDuration = "";
								while (rs.next()) {
									totalDuration = rs.getString(1);
									if (totalDuration != null) {
										out.println("Total Hours: " + totalDuration + "h");
									} else {
										out.println("Total Hours: 0h");
									}
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						%>
					</td>
					<td></td>
				</tr>
			</thead>
		</table>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");

				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();

				String userSID = request.getParameter("userSID");
				String sql = "select * from tasktime WHERE DATE(taskDate)=DATE(NOW()) AND tID=" + userSID;
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
		<table class="workingtime">
			<tr>
				<td><input type="hidden" name=taskTimeID
					value='<%=taskTimeID%>' /></td>
				<td style="width: 335px;"><%=taskName%></td>
				<td><input type="hidden" name=week value='<%=week%>' /></td>
				<td><input type="hidden" name=taskDate value='<%=taskDate%>' /></td>
				<td style="width: 200px;"><%=startTask%></td>
				<td style="width: 200px;"><%=stopTask%></td>
				<td style="width: 200px;"><%=taskSum%>h</td>
				<td style="width: 200px;"><a
					href="editTaskTime.jsp?taskTimeID=<%=rs.getString("taskTimeID")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 35px; height: 35px; position: absolute; margin: -17px -20px;"></a>
				</td>
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

		<hr>

		<!--Working Time -->
		<br> <b>Finish? Add your working hours to your Timesheet</b> <br>
		<br>
		<div class="newTime">
			<form action="addTime" method="post">
				<div>
					<input type="hidden" name="kw" id="theWeek3" required="required">
					<label style="margin-left: 5px">Date</label> <input type="date"
						name="date" style="width: 150px" id="theDate3" required="required">
					<label style="margin-left: 15px">Start</label> <input type="text"
						style="width: 45px" name="startTime"
						value="<%try {
				String userSID = request.getParameter("userSID");
				Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String strQuery = "SELECT MIN(startTask) FROM tasktime WHERE DATE(taskDate)=DATE(NOW()) AND tID="
						+ userSID;
				ResultSet rs = st.executeQuery(strQuery);
				String minTime = "";
				while (rs.next()) {
					minTime = rs.getString(1);
					if (minTime != null) {
						out.println(minTime);
					} else {
						out.println("");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}%>"
						id="starttimeTotal" required="required"> <label
						style="margin-left: 15px" required="required">Stop</label> <input
						type="text" style="width: 45px" name="stopTime" id="stoptimeTotal"
						value="<%try {
				String userSID = request.getParameter("userSID");
				Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String strQuery = "SELECT MAX(stopTask) FROM tasktime WHERE DATE(taskDate)=DATE(NOW()) AND tID="
						+ userSID;
				ResultSet rs = st.executeQuery(strQuery);
				String minTime = "";
				while (rs.next()) {
					minTime = rs.getString(1);
					if (minTime != null) {
						out.println(minTime);
					} else {
						out.println("");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}%>">
					<label style="margin-left: 15px">Pause</label> <input type="text"
						name="pauseTime" style="width: 70px" id="pausetimeTotal"
						value="<%try {
				String userSID = request.getParameter("userSID");
				Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String strQuery = "SELECT taskSum FROM tasktime WHERE DATE(taskDate)=DATE(NOW()) AND taskName='Break' AND tID="
						+ userSID;
				ResultSet rs = st.executeQuery(strQuery);
				String minTime = "";
				while (rs.next()) {
					minTime = rs.getString(1);
					if (minTime != null) {
						out.println(minTime);
					} else {
						out.println("0");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}%>">
					<a style="margin-left: 5px" required="required">Working Hours:
						<input type="text" name="duration"
						value="<%try {
				String userSID = request.getParameter("userSID");
				Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String strQuery = "SELECT sum(CAST(taskSum AS DECIMAL(9,2))) FROM tasktime WHERE DATE(taskDate)=DATE(NOW()) AND tID="
						+ userSID;
				ResultSet rs = st.executeQuery(strQuery);
				String totalDuration = "";
				while (rs.next()) {
					totalDuration = rs.getString(1);
					if (totalDuration != null) {
						out.println(totalDuration);
					} else {
						out.println("0");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}%>h"
						id="totalTask" readonly="readonly">
					</a> <input type="hidden" name="userSID" value='${login.userID}' />
					<button type="submit" style="margin-right: 5px">Save</button>
				</div>
			</form>

			<!-- Show current week -->
			<script> 
			Date.prototype.getWeek = function() {
				  var onejan = new Date(this.getFullYear(),0,1);
				  return Math.ceil((((this - onejan) / 86400000) + onejan.getDay()+1)/7);
				}

				var today = new Date();
				var weekNumber = today.getWeek();
				document.getElementById('theWeek3').value = weekNumber;
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


		document.getElementById('theDate3').value = today;
		</script>

		</div>

		<!-- Calculate time difference -->
		<script>
			window.addEventListener("DOMContentLoaded", function() {
				document.getElementById("starttimeTotal").addEventListener("change",
						SumHours);
				document.getElementById("stoptimeTotal").addEventListener("change",
						SumHours);
				document.getElementById("pausetimeTotal").addEventListener("change",
						SumHours);
			});

			function SumHours() {
				var starttime = document.getElementById('starttimeTotal').value;
				var stoptime = document.getElementById('stoptimeTotal').value;
				var pausetime = document.getElementById('pausetimeTotal').value;
				var diff = 0;

				if (starttime && stoptime && pausetime) {
					pausetime = ConvertToSeconds(pausetime);
					diff = Math.abs(stoptime - starttime - pausetime);
					document.getElementById('totalTask').value = secondsToHHmmSS(diff);
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
		<br>

		<form action="timeTracker.jsp?userSID=${login.userID}" method="post">
			Show Week: <br> <input type="number" id="theWeek4" name="kw"
				style="width: 50px"><input type="submit" value="Submit"
				style="margin-left: 5px">
		</form>

		<br>
	</div>

	<!-- Show current week -->
	<script> 
			Date.prototype.getWeek = function() {
				  var onejan = new Date(this.getFullYear(),0,1);
				  return Math.ceil((((this - onejan) / 86400000) + onejan.getDay()+1)/7);
				}

				var today = new Date();
				var weekNumber = today.getWeek();
				document.getElementById('theWeek4').value = weekNumber;
		</script>

	<script>
		function singleSelectChangeText2() {
			//Getting Value

			var selObj = document.getElementById("week");
			var selValue = selObj.options[selObj.selectedIndex].text;

			//Setting Value
			document.getElementById("myWeek").value = selValue;
		}
	</script>


</body>
</html>