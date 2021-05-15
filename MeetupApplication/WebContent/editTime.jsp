<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="net.meetup.utils.JDBCUtils"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Time Tracker</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="list.css">
<link rel="stylesheet" type="text/css" href="editor.css">
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
		<div class="editHeader">Edit Working Time</div>
		<hr>
		<br>
		<div class="editBody">
			<%
				String id = request.getParameter("id");
				String driver = "com.mysql.jdbc.Driver";
				String connectionUrl = "jdbc:mysql://localhost:3306/";
				String database = "meetup";
				String userid = "root";
				String password = "";
				try {
					Class.forName(driver);
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
				Connection connection = null;
				Statement statement = null;
				ResultSet rs = null;
			%>
			<%
				try {
					connection = DriverManager.getConnection(connectionUrl + database, userid, password);
					statement = connection.createStatement();
					String sql = "select * from workingtime where id=" + id;
					rs = statement.executeQuery(sql);
					while (rs.next()) {
			%>
			<form action="UpdateTime" method="post">
				<input type="hidden" name="id" value="<%=rs.getString("id")%>">
				<input type="hidden" name="userID" value="${login.userID}" />
				<input type="hidden" name="userSID" value="<%=rs.getString("userSID")%>"/>
				<div>
					<input type="hidden" name="kw" value='<%=rs.getString("kw")%>' /> <label>Date</label><input
						type="date" name="date" value='<%=rs.getDate("date")%>' />
				</div>
				<div>
					<label style="margin: 0px -50px;">Start</label> <input type="time"
						name="startTime" id="starttime" style="margin: 0px 50px"
						value='<%=rs.getTime("startTime").toLocalTime()%>' />
				</div>
				<div>
					<label style="margin-left: -95px">Stop</label><input type="time"
						name="stopTime" id="stoptime"
						value='<%=rs.getTime("stopTime").toLocalTime()%>' />
				</div>
				<div>
					<label style="margin-left: -105px">Pause</label><input type=time
						name="pauseTime" id="pausetime"
						value='<%=rs.getTime("pauseTime").toLocalTime()%>' />
				</div>
				<div>
					<label style="margin-left: -130px">Duration</label><input
						type="text" name="duration" id="total"
						value='<%=rs.getString("duration")%>' />
				</div>
				<div>
					<a class="aButtons" href="timeTracker.jsp?userID=${login.userID}">Back</a>
					<button type="submit">Update</button>
				</div>
			</form>

			<%
				}
					connection.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
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
					return hours + "," + minutes;
				}
			}
		</script>
		<hr>
	</div>
</body>
</html>
