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
					<li><a href="javascript:home()"> <dfn class="tooltip">
								Home <span role="tooltip" style="font-weight: normal">You
									can find the home area here </span>
							</dfn></a></li>
					<li><a href="javascript:list()" style="font-weight: normal">
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
		<br> <b class="editHeader">Time Tracker</b>
		<div class="list_navigation">
			<nav>
				<ul>
					<li><a class="sortPosts"
						onclick="document.getElementById('posts_sort').style.display='block'"
						style="width: auto;"><img src="pictures/sort.png" alt="Sort">Sort</a></li>
					<li><a class="filterDate"
						onclick="document.getElementById('date_filter').style.display='block'"
						style="width: auto;"><img src="pictures/filter.png"
							alt="Settings">Filter</a></li>
				</ul>
			</nav>
		</div>
		<hr>
		<br>
		<%
			Date dNow = new Date();
			SimpleDateFormat ft = new SimpleDateFormat("EEEE',' dd.MM.yyyy");
			out.print("<h2 align=\"center\">" + ft.format(dNow) + "</h2>");
		%>
		<div class="newTime">
			<form action="addTime" method="post">
				<div>
					<label>Date</label> <input type="date" name="date"
						style="margin-left: 20px;" required="required">
				</div>
				<div>
					<label>Start</label> <input type="time" name="startTime" id="starttime" 
						style="margin-left: 20px;" required="required">
				</div>
				<div>
					<label>Stop</label> <input type="time" name="stopTime" id="stoptime" 
						style="margin-left: 20px;" required="required">
				</div>
				<div>
					<label>Pause</label> <input type="time" 
						name="pauseTime" id="pausetime"  style="margin-left: 20px;" required="required">
				</div>
				<div>
				<label>Duration</label> 
				<input name="workingSum" type="button" value="Calcuate"
						onclick="calculateTime()" />
						<br><input type="number" name="duration" placeholder="Working hours" id='total'>
				</div>
				<button type="submit">Save</button>
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
					var pauseTimeInMins = pauseTime[0] + pauseTime[1]/6*10;

					var exitTime = exit.value.split(':');
					var exitTimeInMins = exitTime[0] + exitTime[1];

					var totalTime = exitTimeInMins - entryTimeInMins;
					var totalTimeHour = (totalTime - pauseTimeInMins) /100;

					document.getElementById('total').value = totalTimeHour;

				}
			</script>
		<br>
		<table class="list">
			<thead>
				<tr>
					<th style="width: 200px">Date</th>
					<th style="width: 200px">Time</th>
					<th style="width: 200px">Duration</th>
					<th style="width: 200px">Break</th>
					<th style="width: 200px">Duration(Total)</th>
					<th style="width: 150px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM workingtime";
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String id = rs.getString("id");
					LocalDate date = rs.getDate("date").toLocalDate();
					LocalTime startTime = rs.getTime("startTime").toLocalTime();
					LocalTime stopTime = rs.getTime("stopTime").toLocalTime();
					String pauseTime = rs.getString("pauseTime");
					String duration = rs.getString("duration");
		%>
		<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
		<table class="list">
			<tr>
				<td style="width: 200px;"><%=date%></td>
				<td style="width: 200px;"><%=startTime%></td>
				<td style="width: 200px;"><%=stopTime%></td>
				<td style="width: 200px;"><%=pauseTime%></td>
				<td style="width: 200px;"><%=duration%></td>
				<td style="width: 150px;"><a
					href="editTask.jsp?id=<%=rs.getString("id")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 35px; height: 35px; position: absolute; margin: -17px -45px;"></a>
					<a href="deleteTime.jsp?id=<%=rs.getString("id")%>"><img
						src="pictures/delete2.png" alt="Delete post"
						style="width: 30px; height: 30px; position: absolute; margin: -17px 5px;" /></a>
				</td>
			</tr>
			</tbody>
		</table>
		<%
			}
			} catch (Exception e) {
				out.println(e);
			}
		%>
		<br>
		<hr>
		<br>
	</div>


</body>
</html>