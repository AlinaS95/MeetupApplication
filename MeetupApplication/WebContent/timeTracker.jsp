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
				<a class="information" href="profile.jsp?wID=${login.WID}"><img
					src="pictures/infoicon.png" alt="Information"></a>
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
			<dialog id="dialog"> <img src="pictures/meetup_logo.png"
				height="70" width="80" alt="Meetup Logo" hspace="100" vspace="10">
			<hr>

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
		<form style="margin-top: -15px"
			action="timeTracker.jsp?userSID=${login.userID}" method="post">
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
					<td style="width: 200px;"><a class="linkWorktime"
						href="showWorktime.jsp?id=<%=rs.getString("id")%>"><%=date%></a></td>
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