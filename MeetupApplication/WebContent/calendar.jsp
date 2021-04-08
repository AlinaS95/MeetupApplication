<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Calendar</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="calendar.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
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
					<li><a href="home.jsp">Home</a></li>
					<li><a href="javascript:list()">List</a></li>
					<li><a href="javascript:board()">Board</a></li>
					<li><a href="calendar.jsp"style="font-weight: bold">Calendar</a></li>
					<li><a href="javascript:progress()">Progress</a></li>
					<li><a href="socialmedia.jsp">Social Media</a></li>
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
			<div class="popupBody">
			</div>
		</div>
		</div>
		
	<div class="background2">
	<br>
	<div class="month">Dezember 2020
	<img src="pictures/splitButton.png">
	</div>
	<div class="calendar_navigation">
	<nav>
		<ul>	
			<li><a class="filterDate" onclick="document.getElementById('date_filter').style.display='block'"
					style="width: auto;"><img src="pictures/filter.png" alt="Settings">Filter</a></li>
			<li><a class="addDate" onclick="document.getElementById('date_add').style.display='block'"
					style="width: auto;"><img src="pictures/add.png" alt="Add">New Date</a></li>
		</ul>
	</nav>
	</div>
	<hr>
	<div class="container">
	<br>
	<table class="table table-bordered">
		<tr>
			<th>M</th>
			<th>T</th>
			<th>W</th>
			<th>T</th>
			<th>F</th>
			<th>S</th>
			<th>S</th>
		</tr>
		<td style="width: 150px;"><p>
						<button onclick="printWeekNumber()">Week Number</button>
					</p> <a id="result"></a></td>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>1</td>
			<td>2</td>
			<td>3</td>
		</tr>
		<tr>
			<td>4</td>
			<td>5</td>
			<td>6</td>
			<td>7</td>
			<td>8</td>
			<td>9</td>
			<td>10</td>
		</tr>
		<tr>
			<td>11</td>
			<td>12</td>
			<td class="today">13</td>
			<td>14</td>
			<td>15</td>
			<td>16</td>
			<td>17</td>
		</tr>
		<tr>
			<td>18</td>
			<td>19</td>
			<td>20</td>
			<td>21</td>
			<td>22</td>
			<td>23</td>
			<td>24</td>
		</tr>
		<tr>
			<td>25</td>
			<td>26</td>
			<td>27</td>
			<td>28</td>
			<td>29</td>
			<td>30</td>
			<td>31</td>
		</tr>
	</table>
	</div>
	</div>
</body>
</html>