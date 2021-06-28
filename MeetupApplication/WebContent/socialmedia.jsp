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
<title>Social Media</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="socialmedia.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!--Search Tasks -->
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

	<!-- main content-->
	<div class="background2">
		<br>
		<div class="header2">Social Media Schedule</div>
		<div class="socialmedia_navigation">
			<nav>
				<ul>
					<li><a class="socialmediaPopup"
						onclick="document.getElementById('add_post').style.display='block'"
						style="width: auto;"><img src="pictures/add.png" alt="Add">New
							Post</a></li>
				</ul>
			</nav>
		</div>

		<!-- Pop-Up-Window New Post -->
		<div id="add_post" class="socialmedia_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					Add new Post <span
						onclick="document.getElementById('add_post').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
				<div class="popupBody_SocialMedia">
					<div class="popupInfo">
						<form action="UploadPost" method="post"
							enctype="multipart/form-data">
							<div>
								<label>Person</label> <select name="userSID"
									style="margin-left: 17px" id="person"
									onchange="singleSelectChangeText2()" required="required">
									<option value="" disabled selected>Select person</option>
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
								</select> <input id="selectPerson" type="hidden" name="person" required>
							</div>
							<div>
								<label>Channel</label> <select name="channel">
									<option selected="">Select the channel</option>
									<option value="Facebook">Facebook</option>
									<option value="Instagram">Instagram</option>
									<option value="Xing">Xing</option>
									<option value="LinkedIn">LinkedIn</option>
								</select>
							</div>
							<div>
								<label>Category</label> <select name="category"
									style="margin-left: -2px">
									<option selected="">Select the category</option>
									<option value="Image Post">Image Post</option>
									<option value="Story">Story</option>
									<option value="Video">Video</option>
								</select>
							</div>
							<div>
								<label>Design</label> <input type="file" id="file-upload-button"
									name="file" required="required" />
							</div>
							<div>
								<label>Status</label> <select name="status"
									style="margin-left: 22px">
									<option value="In Progress">In Progress</option>
									<option value="Published">Published</option>
								</select>
							</div>
							<div>
								<label>Date</label> <input type="date" name="postDate"
									style="margin-left: 33px;" required="required">
							</div>
							<div>
								<label style="position: absolute">Text</label>
								<textarea name="text"></textarea>
							</div>
							<button type="submit">Save</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<script>
			function singleSelectChangeText2() {
				//Getting Value

				var selObj = document.getElementById("person");
				var selValue = selObj.options[selObj.selectedIndex].text;

				//Setting Value
				document.getElementById("selectPerson").value = selValue;
			}
		</script>

		<hr>
		<br>

		<p style="font-weight: bold">${message}</p>
		<table class="socialmedia">
			<thead>
				<tr>
					<th style="width: 200px">Person</th>
					<th style="width: 150px">Channel</th>
					<th style="width: 150px">Category</th>
					<th style="width: 200px">Design</th>
					<th style="width: 250px">Text</th>
					<th style="width: 150px">Status</th>
					<th style="width: 185px">Date</th>
					<th style="width: 150px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM socialmedia";
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String id = rs.getString("id");
					String person = rs.getString("person");
					String channel = rs.getString("channel");
					String category = rs.getString("category");
					String filename = rs.getString("filename");
					String status = rs.getString("status");
					LocalDate postDate = rs.getDate("postDate").toLocalDate();
					String text = rs.getString("text");
		%>
		<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
		<table class="socialmedia">
			<tr>
				<td style="hyphens: auto; word-break: break-word; width: 200px;"><%=person%></td>
				<td style="width: 150px;"><%=channel%></td>
				<td style="width: 150px;"><%=category%></td>
				<td style="width: 200px;"><img src="pictures/<%=filename%>" /><a
					href="editImage.jsp?id=<%=rs.getString("id")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 25px; height: 25px;"></a></td>
				<td style="hyphens: auto; word-break: break-word; width: 250px;"><%=text%></td>
				<td style="width: 150px;"><%=status%></td>
				<td style="width: 185px;"><p align="center"><%=postDate%></td>
				<td style="width: 150px;"><a
					href="editPost.jsp?id=<%=rs.getString("id")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 35px; height: 35px; position: absolute; margin: -17px -45px;"></a>
					<a href="deletePost.jsp?id=<%=rs.getString("id")%>"
					<%=rs.getString("id")%> style="width: auto;"><img
						src="pictures/delete2.png" alt="Delete post"
						style="width: 30px; height: 30px; position: absolute; margin: -17px 5px;" />
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
		<br>
		<hr>
		<br>
	</div>
</body>
</html>