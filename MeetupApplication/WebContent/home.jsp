<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="stylesheet" type="text/css" href="inbox.css">
<link rel="stylesheet" type="text/css" href="home.css">
<link rel="stylesheet" type="text/css" href="menue.css">
<link rel="stylesheet" type="text/css" href="teams.css">
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
					<a href="javascript:profile()"><img src="pictures/usericon.png"
						alt="Profil Icon" /></a>
				</div>
			</div>
			<br>
		</div>
		<main class="mainmenu2"> <dialog id="dialog">
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
					vspace="1" alt="inbox">Inbox
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
						</button></li>
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
	
	<div class="background2">
	<div class="home">
		<p id="uhr"></p>
		<div id="datum"></div>


		<nav>
			<div class="icon" onclick="toggleNotifi()">
				<img src="pictures/notificationring.png" alt="">
			</div>
			<div class="notifi-box" id="box">
				<h2>
					Notifications <span>17</span>
				</h2>
				<div class="notifi-item">
					<img src="pictures/avatar5.png" alt="img">
					<div class="text">
						<h4>Jana Podschaske</h4>
						<p>Sie müssten mir die Unterlagen vom 28.02.2021 noch bitte
							zusenden.</p>
					</div>
				</div>

				<div class="notifi-item">
					<img src="pictures/avatar5.png" alt="img">
					<div class="text">
						<h4>Alina Schomacher</h4>
						<p>Ich möchte Sie nochmals an das Meeting am 27.02.2021
							erinnern.</p>
					</div>
				</div>

				<div class="notifi-item">
					<img src="pictures/avatar4.png" alt="img">
					<div class="text">
						<h4>Lea-Marie Brüggemann</h4>
						<p>In Ihrer To-Do Box befindet sich eine weitere Aufgabe.</p>
					</div>
				</div>

				<div class="notifi-item">
					<img src="pictures/avatar1.png" alt="img">
					<div class="text">
						<h4>Max Mustermann</h4>
						<p>bla bla bla bla</p>
					</div>
				</div>

				<div class="notifi-item">
					<img src="pictures/avatar2.png" alt="img">
					<div class="text">
						<h4>Rainer Zufall</h4>
						<p>bla bla bla bla bla</p>
					</div>
				</div>

			</div>
		</nav>
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
		</script>

		<script>
			var box = document.getElementById('box');
			var down = false;

			function toggleNotifi() {
				if (down) {
					box.style.height = '0px';
					box.style.opacity = 0;
					down = false;
				} else {
					box.style.height = '530px';
					box.style.opacity = 1;
					down = true;
				}
			}
		</script>



		<main> <br>

		<div class="box1">Last edited projects:</div>
		<div class="box2">Most recently edited tasks:</div>
		<div class="box3">Notes:</div>

		<h1 class="separator">Favorites</h1>

		<form>
			<p class="choice">
				<button id="win">Add Task</button>
				<button id="and">Inbox</button>
				<button id="mac">Profile</button>
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

		</main>
		</div>
	</div>

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
		</script>
</body>
</html>