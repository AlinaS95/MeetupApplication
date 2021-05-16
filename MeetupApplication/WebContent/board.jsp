<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
					<li><a href="javascript:home()">Home</a></li>
					<li><a href="javascript:list()">List</a></li>
					<li><a href="javascript:board()" style="font-weight: bold">Board</a></li>
					<li><a href="javascript:calendar()">Calendar</a></li>
					<li><a href="javascript:progress()">Progress</a></li>
					<li><a href="javascript:socialmedia()">Social Media</a></li>
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

		<hr>

		<div class="box1">
			<dfn class="tooltip">
				To Do <span role="tooltip">In this column you will find all
					the tasks to be done</span>
			</dfn>
		</div>

		<div class="box2">
			<dfn class="tooltip">
				In Progress <span role="tooltip">In this column you will find
					all the tasks that are in development</span>
			</dfn>
		</div>

		<div class="box3">
			<dfn class="tooltip">
				Review <span role="tooltip">All tasks can be commented on,
					assessed and revised here</span>
			</dfn>
		</div>
		<div class="box4">
			<dfn class="tooltip">
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

</body>
</html>