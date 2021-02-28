<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="profile.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
<script type="text/javascript" src="methods.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>
	function myFunction() {
		var x = document.getElementById("settingsText");
		if (x.style.display === "none") {
			x.style.display = "block";
		} else {
			x.style.display = "none";
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
			<div class="welcome">
				<h3>
					Welcome <a class="firstname">${user.firstName}</a>
				</h3>
				<a class="favorites"
							onclick="document.getElementById('p_favorites').style.display='block'"
							style="width: auto;"><img src="pictures/favorite.png"
								alt="Favorites"></a>
				<a class="status" href="javascript:progress()"><img
								src="pictures/greenCircle.png" alt="Status"></a>
			</div>
			<br>
			<div class="secondblock">
				<div class="searchbox">
					<span class="searchicon"><img src="pictures/search.png"></span>
					<input type="search" id="search" placeholder="Search..." />
				</div>
				<div class="user">
					<a href="javascript:profile()"><img src="pictures/usericon.png"
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
					<li><a href="javascript:home()">Home</a></li>
					<li><a href="javascript:list()">List</a></li>
					<li><a href="javascript:board()">Board</a></li>
					<li><a href="javascript:calendar()">Calendar</a></li>
					<li><a href="javascript:progress()">Progress</a></li>
					<li><a href="javascript:socialmedia()">Social Media</a></li>
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
		<div class="profile_title">Profile</div>
		<br>
		<div class="profile_overview">
			<div class="profile_icon">
				<img src="pictures/usericon.png" alt="user" />
			</div>
			<br style="margin-bottom: 15px"> <a class="profile_info"><img
				src="pictures/infoicon.png" alt="information" />Max Mustermann</a> <br>
			<br>maxmustermann@gmx.de <br> <br> <a
				class="profile_settings"
				onclick="document.getElementById('p_settings').style.display='block'"
				style="width: auto;"><img src="pictures/settings.png"
				alt="Settings">Settings</a>
		</div>

		<!-- Pop-Up-Window -->
		<div id="p_settings" class="profile_popup">

			<!-- Window content -->
			<div class="popupBlock">
				<div class="popupHeader">
					<img src="pictures/settings.png">Settings <span
						onclick="document.getElementById('p_settings').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
				<div class="popupBody">
					<img src="pictures/usericon.png" alt="Members">
					<button onClick="changePicture()">Upload new photo</button>
					<button onClick="deletePicture()">Remove photo</button>
					<br>
					<div class="popupInfo">
						<a>Name:</a>
						<button onclick="myFunction()">
							<img src="pictures/settings.png">
						</button>
						<div id="settingsText">
							<form action="check-input.php" method="post">
								<label><textarea class="textPopup" name="html_elemente"
										cols="20" rows="10" maxlength="10000" wrap="soft"></textarea>
								</label>
							</form>
						</div>
						<br> <a>E-Mail:</a>
						<div id="settingsText">
							<form action="check-input.php" method="post">
								<label><textarea class="textPopup" name="html_elemente"
										cols="20" rows="10" maxlength="10000" wrap="soft"></textarea>
								</label>
							</form>
						</div>
						<br> <a>Company:</a>
						<div id="settingsText">
							<form action="check-input.php" method="post">
								<label><textarea class="textPopup" name="html_elemente"
										cols="20" rows="10" maxlength="10000" wrap="soft"></textarea>
								</label>
							</form>
						</div>
					</div>
				</div>
				<div class="popupFooter">
					<button onClick="save()">Save</button> 
					<a href="delete">Delete profile</a>
				</div>
			</div>
		</div>

		<div class="workspace_title">Workspace</div>
		<br>
		<div class="workspace">
			<div class="project_name">University</div>
			<br>Team<br> <br> <br>Members<br> <a
				class="workspace_members"
				onclick="document.getElementById('w_members').style.display='block'
				"
				style="width: auto;"><img src="pictures/usericon.png"
				alt="Members"></a> <a class="workspace_members"
				onclick="document.getElementById('w_members').style.display='block'
				"
				style="width: auto;"><img src="pictures/usericon.png"
				alt="Members"></a> <a class="workspace_addmembers"
				onclick="document.getElementById('t_add').style.display='block'
				"
				style="width: auto;"><img src="pictures/add.png"
				alt="Add Members"></a> <br> <br> Tasks<br> <a
				class="workspace_tasks"
				onclick="document.getElementById('w_tasks').style.display='block'"
				style="width: auto;"><img src="pictures/workspaceTasks.png"
				alt="Tasks"></a>
		</div>
		<!-- Pop-Up-Window Members -->
		<div id="w_members" class="profile_popup">

			<!-- Window content -->
			<div class="popupBlock">
				<div class="popupHeader">
					Project<span
						onclick="document.getElementById('w_members').style.display='none'"
						class="close" title="Schließen">&times;</span>
				</div>
				<div class="popupBody"></div>
			</div>
		</div>

		<!-- Pop-Up-Window Add Members-->
		<div id="t_add" class="navigation_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					Manage your Team <span
						onclick="document.getElementById('t_add').style.display='none'
					"
						class="close" title="Schließen">&times; </span>
				</div>
				<div class="popupBody">
					<a>Add new member</a>
					<form action="workspace" method="post">
						<p>Team name</p>
						<input type="text" id="teamName" name="teamName"
							placeholder="Enter team name" />
						<p>Full name</p>
						<input type="text" id="fullName" name="fullName"
							placeholder="Enter your full Name" />
						<p>Email</p>
						<input type="text" id="email" name="email"
							placeholder="Enter Email" /> <input type="image"
							src="pictures/add.png" alt="Add">
					</form>
					<hr>
					<div class="membersList">
						<a>Members</a><br>
						<table>
							<tr>
								<td><input type="image" src="pictures/usericon.png"
									alt="Member"></td>
								<td>Max Mustermann | max.mustermann@gmx.de</td>
								<td><input type="image" src="pictures/delete.png"
									alt="delete member"
									style="width: 20px; height: 20px; margin-top: -10px; position: absolute"></td>
							</tr>
							<tr>
								<td><input type="image" src="pictures/usericon.png"
									alt="Member"></td>
								<td>Susi Strolch | susi.strolch@gmx.de</td>
								<td><input type="image" src="pictures/delete.png"
									alt="delete member"
									style="width: 20px; height: 20px; margin-top: -10px; position: absolute"></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="popupFooter">
					<button onClick="save()">Save</button>
				</div>
			</div>
		</div>

		<!-- Pop-Up-Window Tasks-->
		<div id="w_tasks" class="profile_popup">

			<!-- Window content -->
			<div class="popupBlock">
				<div class="popupHeader">
					Project<span
						onclick="document.getElementById('w_tasks').style.display='none'"
						class="close" title="Schließen">&times;</span>
				</div>
				<div class="popupBody"></div>
			</div>
		</div>
		<div class="organization_title">Organization</div>
		<br>
		<div class="organization">
			<div class="workingtime">Working Time</div>
			<br>
			<div class="clock">
				<canvas id="profileClock">
			</canvas>
				<script src="profile.js"></script>
			</div>
			<div class="workingtime_Buttons" style="margin: -15px 2px;">
				<img src="pictures/playButton.png" alt="set Time"> <input
					type="text" placeholder='input entry time' id='entry'> <br>
				<img src="pictures/pauseButton.png" alt="start Pause"> <input
					type="text" placeholder='input pause time' id='pause'> <br>
				<img src="pictures/stopButton.png" alt="set Time"> <input
					type="text" placeholder="input exit time" id='exit'><br> <input
					type="button" value='calculate' onclick='calculateTime()' style="width:100px; height:30px;">
				<p>You worked today:</p>
				<input type="text" placeholder="Working hours" id='total'><a style="text-align">Hours</a>
			</div>
			<script>
				function calculateTime() {
					var entry = document.getElementById('entry');
					var exit = document.getElementById('exit');
					var pause = document.getElementById('pause');

					var entryTime = entry.value.split(':');
					var entryTimeInMins = entryTime[0] + entryTime[1];

					var pauseTime = pause.value.split(':');
					var pauseTimeInMins = pauseTime[0] + pauseTime[1];

					var exitTime = exit.value.split(':');
					var exitTimeInMins = exitTime[0] + exitTime[1];

					var totalTime = exitTimeInMins - entryTimeInMins;
					var totalTimeHour = (totalTime - pauseTimeInMins) / 100;

					document.getElementById('total').value = totalTimeHour;

				}
			</script>
		</div>
		<br> <br>
		<div class="logout">
			<a href="login.jsp"><img src="pictures/logout.png" alt="Logout" />Logout</a>
		</div>
	</div>
</body>
</html>