<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List</title>
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
				<a href="home.jsp?wID=${login.WID}"><img src="pictures/meetup_logo.png"
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
					<a href="profile.jsp?wID=${login.WID}"><img src="pictures/${login.fileName}"
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
					<li><a href="home.jsp?wID=${login.WID}"> <dfn class="tooltip">
								Home <span role="tooltip" style="font-weight: normal">You
									can find the home area here </span>
							</dfn></a></li>
					<li><a href="list.jsp?wID=${login.WID}" style="font-weight: bold">
							<dfn class="tooltip">
								List <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and create them</span>
							</dfn>
					</a></li>

					<li><a href="board.jsp?wID=${login.WID}" style="font-weight: normal">
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

					<li><a href="progress.jsp?wID=${login.WID}"
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
		<br> <div class="header2">Tasks</div>
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
					<li><a class="socialmediaPopup"
						onclick="document.getElementById('add_post').style.display='block'"
						style="width: auto;"><img src="pictures/add.png" alt="Add">New
							Task</a></li>
				</ul>
			</nav>
		</div>

		<!-- Pop-Up-Window New Post -->
		<div id="add_post" class="list_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					Add new Task <span
						onclick="document.getElementById('add_post').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
				<div class="popupBody_list">
					<div class="popupInfo">
						<form action="UploadTask" method="post" enctype="multipart/form-data">
							<div>
								<label>Title</label> <input type="text" name="taskName"
									required="required" />
								<input type="hidden" name="wID" value="${login.WID}"/>
							</div>
							<div>
								<label>Description</label> <textarea name="description"></textarea>
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
								<label>Assignee</label> <input type="text" name="assignee"
									required="required" />
							</div>
							<div>
								<label>Internal Inquiries</label> <input type="text" name="internalInquiries"
									required="required" />
							</div>
							<div>
								<label>Comment</label> <input type="text" name="comment"
									required="required" />
							</div>
							
							<div>
								<label>Attachment</label> <input type="file" id="file-upload-button"
									name="file" required="required" />
							</div>
							
							<div>
								<label>Completion in %</label> <input type="number" name="completion"
									required="required" />
							</div>
							
							<button type="submit">Save</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<hr>
		<br>

		<p style="font-weight:bold">${message}</p>
		<table class="list">
			<thead>
				<tr>
					<th style="width: 200px">Title</th>
					<th style="width: 200px">Description</th>
					<th style="width: 150px">Due Date</th>
					<th style="width: 150px">Status</th>
					<th style="width: 150px">Assignee</th>
					<th style="width: 200px">Internal Inquiries</th>
					<th style="width: 200px">Comment</th>
					<th style="width: 150px">Attachment</th>
					<th style="width: 150px">Completion in %</th>
					<th style="width: 150px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				String wID = request.getParameter("wID");
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM tasks WHERE wID="+wID;
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String taskID = rs.getString("taskID");
					String taskName = rs.getString("taskName");
					String description = rs.getString("description");
					LocalDate dueDate = rs.getDate("dueDate").toLocalDate();
					String taskStatus = rs.getString("taskStatus");
					String assignee = rs.getString("assignee");
					String internalInquiries = rs.getString("internalInquiries");
					String comment = rs.getString("comment");
					String filename = rs.getString("filename");
					String completion = rs.getString("completion");
		%>
		<input type="hidden" name="taskID" value='<%=rs.getString("taskID")%>' />
		<input type="hidden"
					name="wID" value='<%=rs.getString("wID")%>' />
		<table class="list">
			<tr>
				<td style="width: 200px;"><%=taskName%></td>
				<td style="width: 200px;"><%=description%></td>
				<td style="width: 150px;"><p align="center"><%=dueDate%></td>
				<td style="width: 150px;"><%=taskStatus%></td>
				<td style="width: 150px;"><%=assignee%></td>
				<td style="hyphens: auto; word-break: break-word; width: 200px;"><%=internalInquiries%></td>
				<td style="hyphens: auto; word-break: break-word; width: 200px;"><%=comment%></td>
				<td style="width: 150px;"><img src="pictures/<%=filename%>" /><a
					href="editImageTask.jsp?taskID=<%=rs.getString("taskID")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 25px; height: 25px;"></a></td>
				<td style="width: 150px;"><%=completion%></td>
				<td style="width: 150px;"><a
					href="editTask.jsp?taskID=<%=rs.getString("taskID")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 35px; height: 35px; position: absolute; margin: -17px -45px;"></a>
					<a
					onclick="document.getElementById('delete_info').style.display='block'"
					<%=rs.getString("taskID")%> style="width: auto;"><img
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

		<!-- Pop-Up-Window Delete Info -->
		<div id="delete_info" class="list_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					<img src="pictures/delete2.png" alt="Delete post"
						style="width: 30px; height: 30px; margin: -4px -2px;" /> Delete
					Post <span
						onclick="document.getElementById('delete_info').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
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
						String description =  rs.getString("description");
						LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));
						String taskStatus = rs.getString("taskStatus");
						String assignee = rs.getString("assignee");
						String internalInquiries = rs.getString("internalInquiries");
						String comment = rs.getString("comment");
						String filename = rs.getString("filename");
						String completion = rs.getString("completion");
				%>
				<div class="popupBody_list">

					<div class="popupInfo">
						<input type="text" name="taskID" value='<%=rs.getString("taskID")%>' /> 
						<a class="aButtons" href="deleteTask.jsp?taskID=<%=rs.getString("taskID")%>">Delete</a>
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
	</div>


</body>
</html>