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
					<li><a href="home.jsp?wID=${login.WID}"> <dfn
								class="tooltip">
								Home <span role="tooltip" style="font-weight: normal">You
									can find the home area here </span>
							</dfn></a></li>
					<li><a href="list.jsp?wID=${login.WID}"
						style="font-weight: normal"> <dfn class="tooltip">
								List <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and create them</span>
							</dfn>
					</a></li>

					<li><a href="board.jsp?wID=${login.WID}"
						style="font-weight: normal"> <dfn class="tooltip">
								Board <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and their processing status </span>
							</dfn>
					</a></li>

					<li><a href="calendar.jsp?wID=${login.WID}"
						style="font-weight: normal"> <dfn class="tooltip">
								Calendar <span role="tooltip" style="font-weight: normal">You
									can find your calendar here </span>
							</dfn></a></li>

					<li><a href="progress.jsp?wID=${login.WID}"
						style="font-weight: normal"> <dfn class="tooltip">
								Progress <span role="tooltip" style="font-weight: normal">Here
									you can find your project and team status</span>
							</dfn></a></li>

					<li><a href="socialmedia.jsp?wID=${login.WID}"
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
		<div class="backIcon">
			<a href="startTimeTracker.jsp?userSID=${login.userID}"><img
				src="pictures/back.png" alt="Back"></a>
		</div>
		<b class="editHeader">Time Tracker</b>
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
		<%
			Date dNow = new Date();
			SimpleDateFormat ft = new SimpleDateFormat("EEEE',' dd.MM.yyyy");
			out.print("<h2>" + ft.format(dNow) + "</h2>");
		%>
		<form style="margin-top:-15px" action="timeTracker.jsp?userSID=${login.userID}" method="post">
			Show Week: <br> <input type="number"
				value="<%=request.getParameter("kw")%>" name="kw"
				style="width: 35px"><input type="submit" value="Submit"
				style="margin-left: 5px">
		</form>
		<br>
		
		<!-- Show weeks before-->
		<table class="workingtime">
			<thead>
				<tr class="week">
					<td style="text-align: left; padding: 0px 10px">Before</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td style="text-align: right; padding: 0px 5px">
						<%
							try {
								String kw = request.getParameter("kw");
								String userSID = request.getParameter("userSID");
								Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
								Statement st = con.createStatement();
								String strQuery = "SELECT sum(CAST(duration AS DECIMAL(9,2))) FROM workingtime WHERE kw<'" + kw
										+ "' AND userSID=" + userSID;
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
				</tr>
				<tr>
					<th style="font-style: italic; width: 100px">Week</th>
					<th style="width: 200px">Date</th>
					<th style="width: 200px">Start</th>
					<th style="width: 200px">Stop</th>
					<th style="width: 200px">Break</th>
					<th style="width: 200px">Duration</th>
					<th style="width: 200px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");

				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();

				String kw = request.getParameter("kw");
				String userSID = request.getParameter("userSID");
				String sql = "select * from workingtime where kw < '" + kw + "'AND userSID='" + userSID
						+ "'ORDER BY date";
				ResultSet rs = st.executeQuery(sql);

				while (rs.next()) {
					String id = rs.getString("id");
					LocalDate date = rs.getDate("date").toLocalDate();
					LocalTime startTime = rs.getTime("startTime").toLocalTime();
					LocalTime stopTime = rs.getTime("stopTime").toLocalTime();
					String pauseTime = rs.getString("pauseTime");
					String duration = rs.getString("duration");
		%>
		<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
		<table class="workingtime">
			<tr>
				<td><input type="hidden" name="kw"
					value='<%=rs.getString("kw")%>' /><input type="hidden"
					name="userSID" value='<%=rs.getString("userSID")%>' /></td>
				<td style="font-style: italic; width: 100px"><%=rs.getString("kw")%></td>
				<td style="width: 200px;"><%=date%></td>
				<td style="width: 175px;"><%=startTime%></td>
				<td style="width: 200px;"><%=stopTime%></td>
				<td style="width: 200px;"><%=pauseTime%></td>
				<td style="width: 200px;"><%=duration%></td>
				<td style="width: 200px;"><a
					href="editTime.jsp?id=<%=rs.getString("id")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 35px; height: 35px; position: absolute; margin: -17px -20px;"></a>
				</td>
			</tr>
			</tbody>
		</table>
		<%
			}
			} catch (Exception e) {
				out.println("Sorry, could not find that kw. ");
			}
		%>

		<br>

		<!-- Current Week -->
		<div>
			<table class="workingtime">
				<thead>
					<tr class="week">
						<td style="text-align: left; padding: 0px 10px; font-weight: bold"><%=request.getParameter("kw")%></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td style="text-align: right; padding: 0px 10px">
							<%
								try {
									String kw = request.getParameter("kw");
									String userSID = request.getParameter("userSID");
									Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
									Statement st = con.createStatement();
									String strQuery = "SELECT sum(CAST(duration AS DECIMAL(9,2))) FROM workingtime WHERE kw='" + kw
											+ "' AND userSID=" + userSID;
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
					</tr>
					<tr>
						<th style="width: 100px">Week</th>
						<th style="width: 200px">Date</th>
						<th style="width: 200px">Start</th>
						<th style="width: 200px">Stop</th>
						<th style="width: 200px">Break</th>
						<th style="width: 200px">Duration</th>
						<th style="width: 200px">Settings</th>
					</tr>
				</thead>
			</table>
			<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");

					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
					Statement st = con.createStatement();

					String kw = request.getParameter("kw");
					String userSID = request.getParameter("userSID");
					String sql = "select * from workingtime where kw = '" + kw + "'AND userSID='" + userSID
							+ "'ORDER BY date";
					ResultSet rs = st.executeQuery(sql);

					while (rs.next()) {
						String id = rs.getString("id");
						LocalDate date = rs.getDate("date").toLocalDate();
						LocalTime startTime = rs.getTime("startTime").toLocalTime();
						LocalTime stopTime = rs.getTime("stopTime").toLocalTime();
						String pauseTime = rs.getString("pauseTime");
						String duration = rs.getString("duration");
			%>
			<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
			<table class="workingtime">
				<tr>
					<td><input type="hidden" id="theWeek" name="kw"
						value='<%=rs.getString("kw")%>' /><input type="hidden"
						name="userSID" value='<%=rs.getString("userSID")%>' /></td>
					<td style="width: 100px; font-weight: bold;"><%=rs.getString("kw")%></td>
					<td style="width: 200px;"><%=date%></td>
					<td style="width: 175px;"><%=startTime%></td>
					<td style="width: 200px;"><%=stopTime%></td>
					<td style="width: 200px;"><%=pauseTime%></td>
					<td style="width: 200px;"><%=duration%></td>
					<td style="width: 200px;"><a
						href="editTime.jsp?id=<%=rs.getString("id")%>"><img
							src="pictures/settings.png" alt="Settings"
							style="width: 35px; height: 35px; position: absolute; margin: -17px -20px;"></a>
					</td>
				</tr>
				</tbody>
			</table>
			<%
				}
				} catch (Exception e) {
					out.println("Sorry, could not find that kw. ");
				}
			%>
		</div>
		<br>

		<!-- after weeks-->
		<table class="workingtime">
			<thead>
				<tr class="week">
					<td style="text-align: left; padding: 0px 10px">After</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td style="text-align: right; padding: 0px 5px">
						<%
							try {
								String kw = request.getParameter("kw");
								String userSID = request.getParameter("userSID");
								Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
								Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
								Statement st = con.createStatement();
								String strQuery = "SELECT sum(CAST(duration AS DECIMAL(9,2))) FROM workingtime WHERE kw>'" + kw
										+ "' AND userSID=" + userSID;
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
				</tr>
				<tr>
					<th style="font-style: italic; width: 100px">Week</th>
					<th style="width: 200px">Date</th>
					<th style="width: 200px">Start</th>
					<th style="width: 200px">Stop</th>
					<th style="width: 200px">Break</th>
					<th style="width: 200px">Duration</th>
					<th style="width: 200px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");

				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();

				String kw = request.getParameter("kw");
				String userSID = request.getParameter("userSID");
				String sql = "select * from workingtime where kw > '" + kw + "'AND userSID='" + userSID
						+ "'ORDER BY date";
				ResultSet rs = st.executeQuery(sql);

				while (rs.next()) {
					String id = rs.getString("id");
					LocalDate date = rs.getDate("date").toLocalDate();
					LocalTime startTime = rs.getTime("startTime").toLocalTime();
					LocalTime stopTime = rs.getTime("stopTime").toLocalTime();
					String pauseTime = rs.getString("pauseTime");
					String duration = rs.getString("duration");
		%>
		<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
		<table class="workingtime">
			<tr>
				<td><input type="hidden" id="kwInput" name="kw"
					value='<%=rs.getString("kw")%>' /><input type="hidden"
					name="userSID" value='<%=rs.getString("userSID")%>' /></td>
				<td style="font-style: italic; width: 100px"><%=rs.getString("kw")%></td>
				<td style="width: 200px;"><%=date%></td>
				<td style="width: 175px;"><%=startTime%></td>
				<td style="width: 200px;"><%=stopTime%></td>
				<td style="width: 200px;"><%=pauseTime%></td>
				<td style="width: 200px;"><%=duration%></td>
				<td style="width: 200px;"><a
					href="editTime.jsp?id=<%=rs.getString("id")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 35px; height: 35px; position: absolute; margin: -17px -20px;"></a>
				</td>
			</tr>
			</tbody>
		</table>
		<%
			}
			} catch (Exception e) {
				out.println("Sorry, could not find that kw. ");
			}
		%>
		<br>

	</div>

	<script>
		function singleSelectChangeText() {
			//Getting Value

			var selObj = document.getElementById("week");
			var selValue = selObj.options[selObj.selectedIndex].text;

			//Setting Value
			document.getElementById("myWeek").value = selValue;
		}
	</script>


</body>
</html>