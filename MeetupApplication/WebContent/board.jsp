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
<title>Dashboard</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="board.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
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
		<main> <dialog id="dialog">
		<div class="button" id="menuebutton"></div>
		<div>
			<img class="middle" src="pictures/meetup_logo.png" alt="link"
				width="80" height="70" />
		</div>
		<br>
		<hr>

		<ul>
			<p>
				<img src="pictures/home.png" height="40" width="40" hspace="1"
					vspace="1" alt="home">Home
			</p>
			<p>
				<img src="pictures/task.png" height="40" width="40" hspace="1"
					vspace="1" alt="task">My Task
			</p>
			<p>
				<img src="pictures/inbox.png" height="40" width="40" hspace="1"
					vspace="1" alt="inbox" onclick="inbox()">Inbox
			</p>
			<p>
				<img src="pictures/person.png" height="40" width="40" hspace="1"
					vspace="1" alt="person">Profile
			</p>

			<hr>
			<p>Reports:</p>
			<li>Tasks I created</li>
			<li>Tasks I assigned to others</li>
			<li>Recently completed Tasks</li>
			<li>Custom Field Order</li>
			<br>
			<hr>
			<p>Teams:</p>
			<td><div class="select-wrapper">
					<select>
						<option value="imagePost">Marketing</option>
						<option value="story">Production</option>
						<option value="linkPost">University</option>
					</select>
				</div></td>

		</ul>
		<div id="Abbruch">
			<img src="pictures/baseline_close_black_18dp.png">
		</div>
		<br>
		<div id="punkte"></div>
		</dialog> </main>
		<div class="mainmenu">
			<nav>

				<ul>
					<li><button id="start">
							<img src="pictures/navigation.png" height="50" width="50"
								align="left" alt="navigation">
						</button> </a></li>
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
					<li><a href="board.jsp?wID=${login.WID}" style="font-weight: bold"><dfn
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

		<hr>

		<div class="box1">
			<dfn class="tooltip2">
				To Do <span role="tooltip">In this column you will find all
					the tasks to be done</span>
			</dfn>
		</div>

		<div class="box2">
			<dfn class="tooltip2">
				In Progress <span role="tooltip">In this column you will find
					all the tasks that are in development</span>
			</dfn>
		</div>

		<div class="box3">
			<dfn class="tooltip2">
				Review <span role="tooltip">All tasks can be commented on,
					assessed and revised here</span>
			</dfn>
		</div>
		<div class="box4">
			<dfn class="tooltip2">
				Done <span role="tooltip">In this column you will find all
					the tasks that have been completed and reflected on</span>
			</dfn>
		</div>


		<a class="addnewtask"
			onclick="document.getElementById('l_add').style.display='block'"
			style="width: auto;"><img src="pictures/add.png" alt="Add"></a>
		<a class="addnewtask1"
			onclick="document.getElementById('l_add').style.display='block'"
			style="width: auto;"><img src="pictures/add.png" alt="Add"></a>
		<a class="addnewtask2"
			onclick="document.getElementById('l_add').style.display='block'"
			style="width: auto;"><img src="pictures/add.png" alt="Add"></a>
		<a class="addnewtask3"
			onclick="document.getElementById('l_add').style.display='block'"
			style="width: auto;"><img src="pictures/add.png" alt="Add"></a>

		<div class="boardtask1">
			<a class="addnewtask"
				onclick="document.getElementById('l_add').style.display='block'"
				style="width: auto;"><img src="pictures/add.png" alt="Add"></a>
		</div>
		<div class="profiletask">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask1">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask2">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask3">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask4">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask5">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask6">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask7">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask8">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask9">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask10">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>
		<div class="profiletask11">
			<img src="pictures/usericon.png" width="40" height="40" />
		</div>

		<div class="tasksHome">
		<div class="task1">
			<section>
				<div class="rechteck1"></div>
				<form>
					<label for="gebdat"></label> <input type="date" id="gebdat"
						name="gebdat">
				</form>
				<label><textarea class="text" name="html_elemente" cols="20"
						rows="10" maxlength="10000" wrap="soft"></textarea> </label>
			</section>
			<section>
				<div class="rechteck2"></div>
			</section>
		</div>
		<div class="task2">
			<section>
				<div class="rechteck3"></div>
			</section>
			<section>
				<div class="rechteck4"></div>
			</section>
		</div>
		<div class="task3">
			<section>
				<div class="rechteck5"></div>
			</section>
			<section>
				<div class="rechteck8"></div>
			</section>
		</div>
		<div class="task4">
			<section>
				<div class="rechteck6"></div>
			</section>
			<section>
				<div class="rechteck7"></div>
			</section>
		</div>
		</div>
	</div>

</body>
</html>