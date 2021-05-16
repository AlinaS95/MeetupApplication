<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="home.css">
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
					<a href="javascript:profile()"><img src="pictures/${login.fileName}"
						alt="Profil Icon" /></a>
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
					<li><a href="socialmedia.jsp" style="font-weight: bold"><dfn
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
	</div>

	<div class="background2">
		<br>
		<main>

		<p id="uhr"></p>
		<div id="datum"></div>

		<!-- Date --> <script language="javascript" type="text/javascript">
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
		</script>  <main> <br>

		<div class="box1">Short Messages:</div>
		<br><br>
		<table class="list1">
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
					String fullName = rs.getString("fullName");
					LocalDate dueDate = rs.getDate("dueDate").toLocalDate();
		%>
		<input type="hidden" name="inboxID" value='<%=rs.getString("inboxID")%>' />
		<table class="homeTask">
			<tr class="tableTask" onclick="list()">
				<td id="fullName"><%=fullName%></td>
				<td style="width: 150px;"><%=dueDate%></td>
			</tr> 
			</tbody>
		</table>
		<%
			}
			} catch (Exception e) {
				out.println(e);
			}
		%>
		<div class="box2">Most recently edited tasks:
		<br><br>
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
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM tasks";
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String taskID = rs.getString("taskID");
					String taskName = rs.getString("taskName");
					LocalDate dueDate = rs.getDate("dueDate").toLocalDate();
		%>
		<input type="hidden" name="taskID" value='<%=rs.getString("taskID")%>' />
		<table class="homeTask">
			<tr class="tableTask" onclick="list()">
				<td id="taskName"><%=taskName%></td>
				<td style="width: 150px;"><%=dueDate%></td>
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
		<div class="box3">
		<a onclick="document.getElementById('add_note').style.display='block'" style="width: auto;"><img src="pictures/add.png" alt="Add">Notes</a>
		<br>
		<br>
		<table class="list">
			<thead>
				<tr>
					<th style="width: 350px">Note</th>
					<th style="width: 400px">Date</th>
				</tr>
			</thead>
		</table>
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
		<table class="list">
			<tr>
				<td style="hyphens: auto; word-break: break-word; width: 200px;"><%=noteTitle%></td>
				<td style="width: 200px;"><%=date%></td>
				<td style="width: 10px;"><a
					href="editNote.jsp?id=<%=rs.getString("id")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 25px; height: 25px; position: absolute; margin: -14px -37px;"></a>
					<a
					onclick="document.getElementById('delete_info').style.display='block'"
					<%=rs.getString("id")%> style="width: auto;"><img
						src="pictures/delete2.png" alt="Delete post"
						style="width: 25px; height: 25px; position: absolute; margin: -17px -8px;" />
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
									style="margin-left: 20px;" required="required">
							</div>
							<button type="submit">Save</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		
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
						<input type="text" name="id"
							value='<%=rs.getString("id")%>' /> <a class="aButtons"
							href="deleteNote.jsp?id=<%=rs.getString("id")%>">Delete</a>
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

		<h1 class="separator">Favorites</h1>

		<form>
			<p class="choice">
				<button id="win">Add Task</button>
				<button id="and" onclick="inbox()">Inbox</button>
				<button id="mac" onclick="profile()">Profile</button>
			</p>
		</form>


		<div class="popup" onclick="myFunction()">
			<img src="pictures/mannschaft.png" alt=""> <span
				class="popuptext" id="myPopup"><h4>Marketing-Team</h4>
				<hr> <br>
				<div class="chip">
					<img src="pictures/avatar5.png" alt="Person" width="96" height="96">
					Alina Schomacher
				</div> <br> <br>
				<div class="chip1">
					<img src="pictures/avatar4.png" alt="Person" width="96" height="96">
					Jana Podschaske
				</div> <br> <br>
				<div class="chip2">
					<img src="pictures/avatar4.png" alt="Person" width="96" height="96">
					Lea Brüggemann
				</div> <br> <br>
				<h4>Production-Team</h4>
				<hr> <br>
				<div class="chip3">
					<img src="pictures/avatar5.png" alt="Person" width="96" height="96">
					Jana Podschaske
				</div> <br> <br>
				<div class="chip4">
					<img src="pictures/avatar4.png" alt="Person" width="96" height="96">
					Lea Brüggemann
				</div> <br> <br>
				<h4>University-Team</h4>
				<hr> <br>
				<div class="chip5">
					<img src="pictures/avatar2.png" alt="Person" width="96" height="96">
					Max Mustermann
				</div> <br> <br>
				<div class="chip6">
					<img src="pictures/avatar1.png" alt="Person" width="96" height="96">
					Max Mustermann
				</div> </span>
		</div>

		</main> <!-- Teams Pop Up --> <script>
			// When the user clicks on div, open the popup
			function myFunction() {
				var popup = document.getElementById("myPopup");
				popup.classList.toggle("show");
			}
		</script> <script>
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
		</script> <!-- Watch --> <script>
	'use strict';
	(function() {
		function uhrzeit() {
			var jetzt = new Date(), h = jetzt.getHours(), m = jetzt
					.getMinutes(), s = jetzt.getSeconds();
			m = fuehrendeNull(m);
			s = fuehrendeNull(s);
			document.getElementById('uhr').innerHTML = h + ':' + m + ':' + s;
			setTimeout(uhrzeit, 500);
		}

		function fuehrendeNull(zahl) {
			zahl = (zahl < 10 ? '0' : '') + zahl;
			return zahl;
		}
		document.addEventListener('DOMContentLoaded', uhrzeit);
	}());
</script>
	</div>
	</div>
</body>
</html>