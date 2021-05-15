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
						<input type="hidden"
					name="userID" value='${login.userID}' />
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
					<a class="aButtons" onclick="checkWeek(this)">Week Number</a> <input
						type="text" name="kw" id="KWInput" required="required">
					<label style="margin-left: 5px">Date</label> <input type="date"
						name="date" id="dateInput" required="required"> <label
						style="margin-left: 15px">Start</label> <input type="time"
						name="startTime" id="starttime" required="required"> <label
						style="margin-left: 15px" required="required">Stop</label> <input
						type="time" name="stopTime" id="stoptime"> <label
						style="margin-left: 15px">Pause</label> <input type="time"
						name="pauseTime" id="pausetime"> <a
						style="margin-left: 5px" required="required">Working Hours: <input
						type="text" name="duration" id="total" readonly="readonly">
					</a>
					<input type="hidden"
					name="userSID" value='${login.userID}' />
					<button type="submit" style="margin-right: 5px">Save</button>
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
		<br>

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

		<table class="workingtime" id="19">
			<thead>
				<tr class="week">
					<td style="text-align: left; padding: 0px 10px">KW 19</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td style="text-align: right; padding:0px 10px">
						<%
							try {
								Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
								Statement st = con.createStatement();
								String strQuery = "SELECT sum(CAST(duration AS DECIMAL(9,2))) FROM workingtime WHERE kw='KW 19'";
								ResultSet rs = st.executeQuery(strQuery);
								String totalDuration = "";
								while (rs.next()) {
									totalDuration = rs.getString(1);
									out.println("Total Hours: " + totalDuration + "h");
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						%>
					</td>
				</tr>
				<tr>
					<th style="width: 200px">Date</th>
					<th style="width: 200px">Start</th>
					<th style="width: 200px">Stop</th>
					<th style="width: 200px">Break</th>
					<th style="width: 200px">Duration</th>
					<th style="width: 175px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				String userID = request.getParameter("userID");
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM workingtime WHERE kw='KW 19' AND userSID=" + userID;
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String id = rs.getString("id");
					String kw = rs.getString("kw");
					LocalDate date = rs.getDate("date").toLocalDate();
					LocalTime startTime = rs.getTime("startTime").toLocalTime();
					LocalTime stopTime = rs.getTime("stopTime").toLocalTime();
					LocalTime pauseTime = rs.getTime("pauseTime").toLocalTime();
					String duration = rs.getString("duration");
					String userSID = rs.getString("userSID");
		%>
		<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
		<table class="workingtime">
			<tr>
				<td style="width: 100x;"><input type="hidden" id="kwInput"
					name="kw" value='<%=rs.getString("kw")%>' /><input type="hidden"
					name="userSID" value='<%=rs.getString("userSID")%>' /></td>
				<td style="width: 200px;"><%=date%></td>
				<td style="width: 200px;"><%=startTime%></td>
				<td style="width: 200px;"><%=stopTime%></td>
				<td style="width: 200px;"><%=pauseTime%></td>
				<td style="width: 200px;"><%=duration%>h</td>
				<td style="width: 175px;"><a
					href="editTime.jsp?id=<%=rs.getString("id")%>"><img
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

		<table class="workingtime" id="20">
			<thead>
				<tr class="week">
					<td style="text-align: left; padding: 0px 10px">KW 20</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td style="text-align: right; padding:0px 10px">
						<%
							try {
								Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
								Statement st = con.createStatement();
								String strQuery = "SELECT sum(CAST(duration AS DECIMAL(9,2))) FROM workingtime WHERE kw='KW 19'";
								ResultSet rs = st.executeQuery(strQuery);
								String totalDuration = "";
								while (rs.next()) {
									totalDuration = rs.getString(1);
									out.println("Total Hours: " + totalDuration + "h");
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						%>
					</td>
				</tr>
				<tr>
					<th style="width: 200px">Date</th>
					<th style="width: 200px">Start</th>
					<th style="width: 200px">Stop</th>
					<th style="width: 200px">Break</th>
					<th style="width: 200px">Duration</th>
					<th style="width: 175px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				String userID = request.getParameter("userID");
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM workingtime WHERE kw='KW 20' AND userSID=" + userID;
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String id = rs.getString("id");
					String kw = rs.getString("kw");
					LocalDate date = rs.getDate("date").toLocalDate();
					LocalTime startTime = rs.getTime("startTime").toLocalTime();
					LocalTime stopTime = rs.getTime("stopTime").toLocalTime();
					LocalTime pauseTime = rs.getTime("pauseTime").toLocalTime();
					String duration = rs.getString("duration");
					String userSID = rs.getString("userSID");
		%>
		<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
		<table class="workingtime">
			<tr>
				<td style="width: 100x;"><input type="hidden" id="kwInput"
					name="kw" value='<%=rs.getString("kw")%>' /><input type="hidden"
					name="userSID" value='<%=rs.getString("userSID")%>' /></td>
				<td style="width: 200px;"><%=date%></td>
				<td style="width: 200px;"><%=startTime%></td>
				<td style="width: 200px;"><%=stopTime%></td>
				<td style="width: 200px;"><%=pauseTime%></td>
				<td style="width: 200px;"><%=duration%>h</td>
				<td style="width: 175px;"><a
					href="editTime.jsp?id=<%=rs.getString("id")%>"><img
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

		<table class="workingtime" id="21">
			<thead>
				<tr class="week">
					<td style="text-align: left; padding: 0px 10px">KW 21</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td style="text-align: right; padding:0px 10px">
						<%
							try {
								Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
								Statement st = con.createStatement();
								String strQuery = "SELECT sum(CAST(duration AS DECIMAL(9,2))) FROM workingtime WHERE kw='KW 19'";
								ResultSet rs = st.executeQuery(strQuery);
								String totalDuration = "";
								while (rs.next()) {
									totalDuration = rs.getString(1);
									out.println("Total Hours: " + totalDuration + "h");
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						%>
					</td>
				</tr>
				<tr>
					<th style="width: 200px">Date</th>
					<th style="width: 200px">Start</th>
					<th style="width: 200px">Stop</th>
					<th style="width: 200px">Break</th>
					<th style="width: 200px">Duration</th>
					<th style="width: 175px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				String userID = request.getParameter("userID");
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM workingtime WHERE kw='KW 21' AND userSID=" + userID;
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String id = rs.getString("id");
					String kw = rs.getString("kw");
					LocalDate date = rs.getDate("date").toLocalDate();
					LocalTime startTime = rs.getTime("startTime").toLocalTime();
					LocalTime stopTime = rs.getTime("stopTime").toLocalTime();
					LocalTime pauseTime = rs.getTime("pauseTime").toLocalTime();
					String duration = rs.getString("duration");
					String userSID = rs.getString("userSID");
		%>
		<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
		<table class="workingtime">
			<tr>
				<td style="width: 100x;"><input type="hidden" id="kwInput"
					name="kw" value='<%=rs.getString("kw")%>' /><input type="hidden"
					name="userSID" value='<%=rs.getString("userSID")%>' /></td>
				<td style="width: 200px;"><%=date%></td>
				<td style="width: 200px;"><%=startTime%></td>
				<td style="width: 200px;"><%=stopTime%></td>
				<td style="width: 200px;"><%=pauseTime%></td>
				<td style="width: 200px;"><%=duration%>h</td>
				<td style="width: 175px;"><a
					href="editTime.jsp?id=<%=rs.getString("id")%>"><img
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
		<div class="newTime">
			<form action="addTime" method="post">
				<div>
					<input class="newTask" type="text" name="taskName"
						placeholder="What are you working on?"></input> <label
						style="margin-left: 20px;">Start</label> <input type="time"
						name="startTask" id="startTask"> <label
						style="margin-left: 20px;">Stop</label> <input type="time"
						name="stopTask" id="stopTask"> <a
						style="margin-left: 15px;">Hours: <input type="text"
						name="totalTask" id="totalTask" readonly="readonly"></a>
					<button type="submit">Save</button>
				</div>
			</form>
		</div>

		<script>
			// Zeit-Differenz ermitteln
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
					document.getElementById('totalTask').value = secondsToHHmmSS(diff);
				}

				function ConvertToSeconds(time) {
					var splitTime = time.split(":");
					return splitTime[0] * 3600 + splitTime[1] * 60;
				}

				function secondsToHHmmSS(secs) {
					var hours = parseInt(secs / 3600);
					var seconds = parseInt(secs % 3600);
					var minutes = parseInt(seconds/60);
					if (minutes < 10) {
						minutes = '0' + minutes;
					}
					return hours + "," + minutes;
				}
			}
		</script>
		<br>

		<table class="taskTime">
			<thead>
				<tr>
					<td style="text-align: left">Today</td>
					<td style="text-align: right">Total Hours<input type="text"
						name="totalHours" id="totalHours"></input></td>
				</tr>
			</thead>
		</table>

		<table class="workingtime">
			<tr>
				<td style="width: 200px;"><input type="text"></td>
				<td style="width: 200px;"><input type="time"></td>
				<td style="width: 200px;"><input type="time"></td>
				<td style="width: 200px;"><input type="time"></td>
				<td style="width: 150px;"><a href="editTime.jsp?id="><img
						src="pictures/settings.png" alt="Settings"
						style="width: 35px; height: 35px; position: absolute; margin: -17px -45px;"></a>
					<a href="deleteTime.jsp?id="><img src="pictures/delete2.png"
						alt="Delete post"
						style="width: 30px; height: 30px; position: absolute; margin: -17px 5px;" /></a>
				</td>
			</tr>
			</tbody>
		</table>
		<br>
	</div>


</body>
</html>