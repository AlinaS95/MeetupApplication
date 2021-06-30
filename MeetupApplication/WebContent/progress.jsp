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
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%
	Gson gsonObj = new Gson(); //Gson:Open Source-Java-Bibliothek mit der Java-Objekte in ihre JSON-Darstellung konvertiert werden können
	Map<Object, Object> map = null;
	List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();
	String dataPoints = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
		Statement statement = connection.createStatement();
		String xVal, yVal;

		ResultSet resultSet = statement.executeQuery("SELECT * FROM tasks");

		while (resultSet.next()) {
			xVal = resultSet.getString("taskName");
			yVal = resultSet.getString("completion");
			map = new HashMap<Object, Object>();
			map.put("label", (xVal));
			map.put("y", Double.parseDouble(yVal));
			list.add(map);
			dataPoints = gsonObj.toJson(list);
		}
		connection.close();
	} catch (SQLException e) {
		out.println(
				"<div  style='width: 50%; margin-left: auto; margin-right: auto; margin-top: 200px;'>Could not connect to the database. Please check if you have mySQL Connector installed on the machine - if not, try installing the same.</div>");
		dataPoints = null;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Progress</title>

<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="stylesheet" type="text/css" href="progress.css">
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
<script type="text/javascript">
	window.onload = function() {

		var chart = new CanvasJS.Chart("chartContainer", {
			width : "1400",
			theme : "light2",
			title : {
				text : "Task Progress"
			},

			axisY : {
				title : "Task Status",
				labelFormatter : addSymbols
			},
			data : [ {
				type : "bar",
				indexLabel : "{y}",
				indexLabelFontColor : "#444",
				indexLabelPlacement : "inside",
				dataPoints :
<%out.print(dataPoints);%>
	} ]
		});
		chart.render();

		function addSymbols(e) {
			var suffixes = [ "", "K", "M", "B" ];

			var order = Math.max(Math.floor(Math.log(e.value) / Math.log(100)),
					0);
			if (order > suffixes.length - 1)
				order = suffixes.length - 1;

			var suffix = suffixes[order];
			return CanvasJS.formatNumber(e.value / Math.pow(100, order))
					+ suffix;
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
					<li><a href="socialmedia.jsp?wID=${login.WID}"
						style="font-weight: bold"><dfn class="tooltip">
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

	<h4>This Project is</h4>
	<a style="position: absolute; margin: -48px 135px" class="workspace">${login.workspace}</a>

	<!-- Task Counter -->
	<div class="box1">
		New Task<br> <a> <%
 	try {
 		String wID = request.getParameter("wID");
 		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
 		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
 		Statement st = con.createStatement();
 		String strQuery = "SELECT COUNT(*) FROM tasks WHERE taskStatus='To Do' AND wID=" + wID;
 		ResultSet rs = st.executeQuery(strQuery);
 		String Countrow = "";
 		while (rs.next()) {
 			Countrow = rs.getString(1);
 			out.println(Countrow);
 		}
 	} catch (Exception e) {
 		e.printStackTrace();
 	}
 %></a>
	</div>

	<div class="box2">
		Incompleted Task<br> <a> <%
 	try {
 		String wID = request.getParameter("wID");
 		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
 		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
 		Statement st = con.createStatement();
 		String strQuery = "SELECT COUNT(*) FROM tasks WHERE taskStatus='In Progress' AND wID=" + wID;
 		ResultSet rs = st.executeQuery(strQuery);
 		String Countrow = "";
 		while (rs.next()) {
 			Countrow = rs.getString(1);
 			out.println(Countrow);
 		}
 	} catch (Exception e) {
 		e.printStackTrace();
 	}
 %></a>
	</div>

	<div class="box3">
		Completed Task<br> <a> <%
 	try {
 		String wID = request.getParameter("wID");
 		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
 		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
 		Statement st = con.createStatement();
 		String strQuery = "SELECT COUNT(*) FROM tasks WHERE taskStatus='Done' AND wID=" + wID;
 		ResultSet rs = st.executeQuery(strQuery);
 		String Countrow = "";
 		while (rs.next()) {
 			Countrow = rs.getString(1);
 			out.println(Countrow);
 		}
 	} catch (Exception e) {
 		e.printStackTrace();
 	}
 %></a>
	</div>


	<h6>Team Status</h6>
	<div class="teamstatus">

		<div id="chartContainer" style="height: 370px; width: 100%;"></div>
		<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
	</div>

</body>
</html>