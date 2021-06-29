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
<title>Home</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="home.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">

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
					Workspace: <a class="workspace">${login.workspace}</a>
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
					<li><a href="home.jsp?wID=${login.WID}"
						style="font-weight: bold"><dfn class="tooltip">
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
								required="required" style="margin-left: 55px" /> <input
								type="hidden" name="wID" value="${login.WID}" />
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
								name="internalInquiries" />
						</div>

						<div>
							<label>Attachment</label> <input type="file"
								style="margin-left: -1px" id="file-upload-button" name="file"
								required="required" />
						</div>

						<div>
							<label>Completion in %</label> <input type="number"
								style="width: 50px" name="completion" required="required" />
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

<!-- main content-->
	<div class="background2">
		<br>
		

		<p id="uhr"></p>
		<div id="datum"></div>

		<!-- Date --> 
		<script language="javascript" type="text/javascript">
			window.setInterval("datum()", 60000);

			function datum() {
				var d = new Date();

				var wochentage = new Array("Sonntag", "Montag", "Dienstag",
						"Mittwoch", "Donnerstag", "Freitag", "Samstag");

				var monate = new Array("Januar", "Februar", "März", "April",
						"Mai", "Juni", "Juli", "August", "September",
						"Oktober", "November", "Dezember");

				document.getElementById("datum").innerHTML = ' '
						+ wochentage[d.getDay()] + ', der ' + d.getDate()
						+ '. ' + monate[d.getMonth()] + ' ' + d.getFullYear();

			}

			window.onload = datum
		</script> <main> <br>
<<<<<<< HEAD

		<!-- Box short messages -->
=======
		<!-- inbox-->
>>>>>>> branch 'master' of https://github.com/AlinaS95/MeetupApplication.git
		<div class="box1">
			Short Messages: <br> <br>
			<table class="list">
				<thead>
					<tr>
						<th style="width: 200px">Message</th>
						<th style="width: 150px">Due Date</th>
					</tr>
				</thead>
			</table>
			<hr>
			<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
					Statement st = con.createStatement();
					String sql = "SELECT * FROM inbox";
					ResultSet rs = st.executeQuery(sql);
					int i = 0;
					while (rs.next()) {
						String inboxID = rs.getString("inboxID");
						String title = rs.getString("title");
						LocalDate dueDate = rs.getDate("dueDate").toLocalDate();
			%>
			<input type="hidden" name="inboxID"
				value='<%=rs.getString("inboxID")%>' />
			<table class="homeTask">
				<tr class="tableTask">
					<td id="title"><a href="inbox.jsp?wID=${login.WID}" style="text-decoration: none"><%=title%></a></td>
					<td style="width: 150px;"><a href="inbox.jsp?wID=${login.WID}" style="text-decoration: none"><%=dueDate%></a></td>
				</tr>
				</tbody>
			</table>
			<%
				}
				} catch (Exception e) {
					out.println(e);
				}
			%>
		</div>

<<<<<<< HEAD
		<!-- Box tasks -->
=======
		<!-- edited tasks-->
>>>>>>> branch 'master' of https://github.com/AlinaS95/MeetupApplication.git
		<div class="box2">
			Most recently edited tasks: <br> <br>
			<table class="list">
				<thead>
					<tr>
						<th style="width: 200px">Title</th>
						<th style="width: 150px">Due Date</th>
					</tr>
				</thead>
			</table>
			<hr>
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
						LocalDate dueDate = rs.getDate("dueDate").toLocalDate();
						String filename = rs.getString("filename");
			%>
			<input type="hidden" name="taskID"
				value='<%=rs.getString("taskID")%>' />
			<table class="homeTask">
				<tr class="tableTask">
					<td id="filename"><a href="list.jsp?wID=${login.WID}"><img
							src="pictures/<%=filename%>" /></a></td>
					<td id="taskName"><a style="text-decoration: none"
						href="list.jsp?wID=${login.WID}"><%=taskName%></a></td>
					<td style="width: 200px;"><a style="text-decoration: none"
						href="list.jsp?wID=${login.WID}"><%=dueDate%></a></td>
				</tr>
				</tbody>
			</table>
			<%
				}
				} catch (Exception e) {
					out.println(e);
				}
			%>
		</div>
<<<<<<< HEAD

		<!-- Box notes -->
=======
		
		<!-- notes-->
>>>>>>> branch 'master' of https://github.com/AlinaS95/MeetupApplication.git
		<div class="box3">
			<a style="margin-right: 160px">Notes:</a><a
				onclick="document.getElementById('add_note').style.display='block'"
				style="width: auto;"><img src="pictures/add.png" alt="Add"></a><br>
			<br>
			<table class="list">
				<thead>
					<tr>
						<th style="width: 180px">Note</th>
						<th style="width: 150px">Date</th>
					</tr>
				</thead>
			</table>
			<hr>
			<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
					Statement st = con.createStatement();
					String sql = "SELECT * FROM notes";
					ResultSet rs = st.executeQuery(sql);
					int i = 0;
					while (rs.next()) {
						String id = rs.getString("id");
						String noteTitle = rs.getString("noteTitle");
						LocalDate date = rs.getDate("date").toLocalDate();
			%>
			<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
			<table class="homeTask">
				<tr class="tableTask">
					<td id="taskName"
						style="hyphens: auto; word-break: break-word; width: 180px;"><%=noteTitle%></td>
					<td style="width: 150px;"><%=date%></td>
					<td style="width: 10px;"><a
						href="editNote.jsp?id=<%=rs.getString("id")%>"><img
							src="pictures/settings.png" alt="Settings"
							style="width: 35px; height: 35px; position: absolute; margin: -18px -15px;"></a>
						<a href="deleteNote.jsp?id=<%=rs.getString("id")%>"><img
							src="pictures/delete2.png" alt="Delete Note"
							style="width: 25px; height: 25px; position: absolute; margin: -14px 25px;" />
					</a></td>
				</tr>
				</tbody>
			</table>
			<%
				}
				} catch (Exception e) {
					out.println(e);
				}
			%>
		</div>


		<!-- Pop-Up-Window New Note -->
		<div id="add_note" class="note_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					Add new Note <span
						onclick="document.getElementById('add_note').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
				<div class="popupBody_note">
					<div class="popupInfo">
						<form class="noteForm" action="AddNote" method="post">
							<div>
								<label>Note</label> <input type="text" name="noteTitle"
									required="required" />
							</div>
							<div>
								<label>Date</label> <input type="date" name="date"
									style="margin-left: 57px;" required="required">
							</div>
							<button type="submit">Save</button>
						</form>
					</div>
				</div>
			</div>
		</div>

<<<<<<< HEAD
=======
		<!-- Pop-Up-Window Delete Note -->
		<div id="delete_info" class="note_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					<img src="pictures/delete2.png" alt="Delete post"
						style="width: 30px; height: 30px; margin: -4px -2px;" /> Delete
					Note <span
						onclick="document.getElementById('delete_info').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
				<%
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
						Statement st = con.createStatement();
						String sql = "SELECT * FROM notes";
						ResultSet rs = st.executeQuery(sql);
						int i = 0;
						while (rs.next()) {
							String id = rs.getString("id");
							String noteTitle = rs.getString("noteTitle");
							LocalDate date = rs.getDate("date").toLocalDate();
				%>
				<div class="popupBody_list">

					<div class="popupInfo">
						<input type="text" name="id" value='<%=rs.getString("id")%>' /> <a
							class="aButtons" href="deleteNote.jsp?id=<%=rs.getString("id")%>">Delete</a>
						<br>
					</div>
				</div>
				<%
					}
					} catch (Exception e) {
						out.println(e);
					}
				%>
			</div>
		</div>


	<!-- Favorites-->
>>>>>>> branch 'master' of https://github.com/AlinaS95/MeetupApplication.git
		<h1 class="separator">Favorites</h1>

		<form class="homeForm">
			<p class="choice">
				<a class="win" style="text-decoration: none"
					href="list.jsp?wID=${login.WID}">Add Task</a><a class="and"
					style="text-decoration: none" href="inbox.jsp?wID=${login.WID}">Inbox</a>

				<a style="text-decoration: none" class="mac"
					href="profile.jsp?wID=${login.WID}">Profile</a>
			</p>
		</form>


		<div class="popup" onclick="myFunction()">
			<img src="pictures/mannschaft.png" alt=""> <span
				class="popuptext" id="myPopup"><h4 style="text-align: center">${login.workspace}-Team</h4>
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
				%> <input type="hidden" name="wID" value='<%=rs.getString("wID")%>' />
				<table class="list">
					<tr style="height: 55px">
						<td style="width: 65px;"><img class="membersImg"
							src="pictures/<%=fileName%>" /></td>
						<td
							style="hyphens: auto; word-break: break-word; width: 150px; text-align: left"><%=firstName%>
							<%=lastName%><input type="hidden" name="wID"
							value='<%=rs.getString("wID")%>' /></td>

					</tr>
					</tbody>
				</table> <%
 	}
 	} catch (Exception e) {
 		out.println(e);
 	}
 %>
		</div>

		</main> 
		<!-- Teams Pop Up --> 
		<script>
			// When the user clicks on div, open the popup
			function myFunction() {
				var popup = document.getElementById("myPopup");
				popup.classList.toggle("show");
			}
		</script> 
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
		
		<!-- watch --> 
		<script>
			'use strict';
			(function() {
				function uhrzeit() {
					var jetzt = new Date(), h = jetzt.getHours(), m = jetzt
							.getMinutes(), s = jetzt.getSeconds();
					m = fuehrendeNull(m);
					s = fuehrendeNull(s);
					document.getElementById('uhr').innerHTML = h + ':' + m
							+ ':' + s;
					setTimeout(uhrzeit, 500);
				}

				function fuehrendeNull(zahl) {
					zahl = (zahl < 10 ? '0' : '') + zahl;
					return zahl;
				}
				document.addEventListener('DOMContentLoaded', uhrzeit);
			}());
		</script> <br>
		<br>
		<br>
		<br>
		<br>
	</div>
</body>
</html>