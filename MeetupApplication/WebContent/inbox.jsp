<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inbox</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="inbox.css">
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
			<div class="welcome">
				<h3>
					Workspace: <a class="firstname">${login.workspace}</a>
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
					<a href="profile.jsp"><img src="pictures/usericon.png"
						alt="Profil Icon" /></a>
				</div>
			</div>
			<br>
		</div>

		<div class="mainmenu">
			<nav>
				<ul>
					<li><button id="start">
							<img src="pictures/navigation.png" height="50" width="50"
								align="left" alt="navigation">
						</button>
						</a></li>
					<li><a href="javascript:home()" style="font-weight: bold">Home</a></li>
					<li><a href="javascript:list()">List</a></li>
					<li><a href="javascript:board()">Board</a></li>
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
					class="close" title="Schlie�en">&times;</span>
			</div>
			<div class="popupBody"></div>
		</div>
	</div>
	<div class="background2">

		<h1>Inbox</h1>
		<div class="notifi-item">
			<img src="pictures/notificationring.png" alt="">
		</div>
		<ul id="navigation">
			<li><a href="start.html">All</a></li>
			<li><a href="news.html">Assigned by me</a></li>
			<li><a href="infos.html">Assigned to me</a></li>
			<li><a href="galerie.html">Settings</a></li>
		</ul>
		<br>
		<br>
		<button id="open-dialog">Create new notification</button>
		<dialog role="dialog">
		<button id="close-dialog">Close</button>
		<h2>Create new notification</h2>
		<p>Dies ist eine zug�ngliche Dialog-Box, die Sie auch mit der
			Tastatur benutzen k�nnen.</p>
		</dialog>

		<div class="select-wrapper">
			<select>
				<option value="imagePost">Today</option>
				<option value="story">Last 7 days</option>
				<option value="linkPost">Last month</option>
			</select>
			<div class="signtonavigate">
				<img src="pictures/pfeil-nach-unten-skizze.png" alt="img">
			</div>

			<div class="inboxbox">
				<p class="bl2">18.03.2021/12:08
				<p>
				<p class="bl">Tuesday Marketing Meeting: Project 65
				<p>
				<div id="kreis1"></div>
				<div id="message">
					<img src="pictures/approved.png" alt="img">
				</div>
				<div id="settings">
					<img src="pictures/mehr.png" alt="img">
				</div>
				<div id="reply">
					<img src="pictures/email.png" alt="img">
				</div>
			</div>
			<div class="inboxbox1">
				<p class="bl3">16.03.2021/09:08
				<p>
				<p class="bl">Friday delivery: Project 12
				<p>
				<div id="kreis2"></div>
				<div id="message">
					<img src="pictures/approved.png" alt="img">
				</div>
				<div id="settings">
					<img src="pictures/mehr.png" alt="img">
				</div>
				<div id="reply">
					<img src="pictures/email.png" alt="img">
				</div>
			</div>
			<div class="inboxbox2">
				<p class="bl4">14.03.2021/15:46
				<p>
				<p class="bl">Monday Meeting with Jana Podschaske: 2pm
				<p>
				<div id="kreis3"></div>
				<div id="message">
					<img src="pictures/approved.png" alt="img">
				</div>
				<div id="settings">
					<img src="pictures/mehr.png" alt="img">
				</div>
				<div id="reply">
					<img src="pictures/email.png" alt="img">
				</div>
			</div>
			<div class="inboxbox3">
				<p class="bl5">14.03.2021/15:46
				<p>
				<div id="settings">
					<img src="pictures/mehr.png" alt="img">
				</div>
				<div id="reply">
					<img src="pictures/email.png" alt="img">
				</div>
				<div id="delete">
					<img src="pictures/garbage.png" alt="img">
				</div>
				<div id="avatar">
					<img src="pictures/avatar1.png" alt="img">
					<p class="bl1">From: Jana Podschaske
					<p>
				</div>
				<div id="rechteck7"></div>
				<br>
				<h3>Friday Meeting: Project x at 10am</h3>
				<p>
					Hello Mr. Mustermann, <br>I would like to remind you that
					there will be a meeting tomorrow at 10:00 am for project x. It
					would be very nice if you bring all the necessary documents with
					you. <br>Until then and best regards <br>Jana Podschaske
				</p>
			</div>




			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br> <br> <br>
			<br>
			<br> <br>
			<br> <br>
		</div>
		<script>
			'use strict';
			document.addEventListener("DOMContentLoaded", function() {
				//Polyfill f�r dialog-Element
				var lastFocus;
				var dialog = document.querySelector('dialog');
				var closeButton = document.getElementById('close-dialog');
				closeButton.addEventListener('click', toggleDialog);
				document.querySelector('#open-dialog').addEventListener(
						'click', toggleDialog);

				function toggleDialog(event) {
					if (!dialog.hasAttribute('open')) {
						// show the dialog 
						dialog.setAttribute('open', 'open');
						// after displaying the dialog, focus the closeButton inside it
						closeButton.focus();
						// only hide the background *after* you've moved focus out of the content that will be "hidden" 
						var div = document.createElement('div');
						div.id = 'mybackdrop';
						document.body.appendChild(div);
						if (event)
							lastFocus = event.target;
					} else {
						dialog.removeAttribute('open');
						var div = document.querySelector('#mybackdrop');
						div.parentNode.removeChild(div);
						lastFocus.focus();
					}
				}
				// EventListener f�r ESC-Taste
				document.addEventListener('keydown', keydown, true);

				function keydown(event) {
					if (event.keyCode == 27) {
						toggleDialog();
					}
				}
			});
		</script>
</body>
</html>