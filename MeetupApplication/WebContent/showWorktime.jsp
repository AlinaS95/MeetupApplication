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
					<a href="javascript:profile()"><img
						src="pictures/${login.fileName}" alt="Profil Icon" /></a>
				</div>
			</div>
			<br>
		</div>
		<div class="mainmenu">
			<nav>
				<ul>
					<li><a href="javascript:menue()"><img
							src="pictures/navigation.png" alt="Menu"></a></li>
					<li><a href="home.jsp"><dfn class="tooltip">
								Home <span role="tooltip" style="font-weight: normal">You
									can find the home area here </span>
							</dfn></a></li>
					<li><a href="javascript:list()"><dfn class="tooltip">
								List <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and create them</span>
							</dfn> </a></li>
					<li><a href="javascript:board()"> <dfn class="tooltip">
								Board <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and their processing status </span>
							</dfn>
					</a></li>
					<li><a href="calendar.jsp"><dfn class="tooltip">
								Calendar <span role="tooltip" style="font-weight: normal">You
									can find your calendar here </span>
							</dfn></a></li>
					<li><a href="javascript:progress()"><dfn class="tooltip">
								Progress <span role="tooltip" style="font-weight: normal">Here
									you can find your project and team status</span>
							</dfn></a></li>
					<li><a href="socialmedia.jsp" style="font-weight: normal"><dfn
								class="tooltip">
								Social Media <span role="tooltip" style="font-weight: normal">Here
									you can find everything about your social media tasks</span>
							</dfn></a></li>
				</ul>
				<div class="secondNavigation">
					<ul>
						<li><a class="add"
							onclick="document.getElementById('add').style.display='block'"
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
		<div class="backIcon">
			<a href="startTimeTracker.jsp?userSID=${login.userID}"><img
				src="pictures/back.png" alt="Back"></a>
		</div>
		<b class="editHeader">Working Time</b>
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
		<table class="selectWorkingtime" style="margin:0px 285px">
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
		<table class="selectWorkingtime" style="margin:0px 285px">
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
