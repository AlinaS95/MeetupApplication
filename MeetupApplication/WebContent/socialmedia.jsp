<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Social Media</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="socialmedia.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
<script type="text/javascript" src="socialmedia.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	var loadFile = function(event) {
		var image = document.getElementById('output');
		image.src = URL.createObjectURL(event.target.files[0]);
	};
</script>
<script>
	Date.prototype.getWeekNumber = function() {

		var oneJan = new Date(this.getFullYear(), 0, 1);

		// calculating number of days  
		//in given year before given date 

		var numberOfDays = Math.floor((this - oneJan) / (24 * 60 * 60 * 1000));

		// adding 1 since this.getDay() 
		//returns value starting from 0 

		return Math.ceil((this.getDay() + 1 + numberOfDays) / 7);

	}

	function printWeekNumber() {
		var dateInput = document.getElementById("dateInput").value;
		var date = new Date(dateInput);
		var result = date.getWeekNumber();
		document.getElementById("result").innerHTML = +result;
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
					<li><a href="socialmedia.jsp" style="font-weight: bold"><dfn class="tooltip">
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

	<div class="background2">
		<br>
		<div class="category_socialmedia">
			Social Media Schedule <img src="pictures/splitButton.png">
		</div>
		<div class="socialmedia_navigation">
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
							Post</a></li>
				</ul>
			</nav>
		</div>
		<hr>
		<br>
		<table class="socialmedia">
			<thead>
				<tr>
					<th>Week</th>
					<th>Person</th>
					<th>Channel</th>
					<th>Category</th>
					<th>Design</th>
					<th>Text</th>
					<th>Status</th>
					<th>Date</th>
				</tr>
			</thead>
			<tr>
				<td><p>
						<button onclick="printWeekNumber()">Week Number</button>
					</p> <a id="result"></a></td>
				<td>Max Mustermann</td>
				<td>Facebook</td>
				<td><div class="select-wrapper">
						<select>
							<option value="imagePost">Image Post</option>
							<option value="story">Story</option>
							<option value="linkPost">Link Post</option>
						</select>
					</div></td>
				<td><p>
						<input type="file" accept="image/*" name="image" id="file"
							onchange="loadFile(event)" style="display: none;">
					</p>
					<p>
						<label for="file" style="cursor: pointer;"><img
							src="pictures/add.png" alt="Add"></label>
					</p>
					<p>
						<img id="output" width="200" />
					</p></td>
				<td><form action="check-input.php" method="post">
						<label><textarea class="text" name="html_elemente"
								cols="20" rows="10" maxlength="10000" wrap="soft"></textarea> </label>
					</form></td>
				<td>Published</td>
				<td><p align="center">
						<input type="date" id="dateInput"></td>
			</tr>
			</tbody>
		</table>
		<br>
		<hr>
		<br>
	</div>
	<!-- Pop-Up-Window New Post-->
	<div id="add_post" class="socialmedia_addBlock">

		<!-- Window content -->
		<div class="addBlock">
			<div class="popupHeader">
				New Post<span
					onclick="document.getElementById('add_post').style.display='none'"
					class="close" title="Schließen">&times;</span>
			</div>
			<div class="popupBody"></div>
		</div>
	</div>
</body>
</html>