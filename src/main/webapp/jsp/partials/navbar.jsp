<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<nav class="navbar navbar navbar-toggleable-sm navbar-expand-md navbar-light bg-faded mb-5">
	<div class="container">
		<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<a class="navbar-brand" href="Home">People</a>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<a class="nav-link" href="Home">Home
						<span class="sr-only">(current)</span>
					</a>
				</li>
	           	<li class="nav-item">
					<a name="profile" id="buttonProfile" class="nav-link" href="Profile">Profile</a>
	           	</li>
			</ul>
			<form action="SearchPerson" method="POST" class="form-inline my-2 my-lg-0">
           		<input class="form-control mr-sm-2" type="text" placeholder="Search" name="search" id="searchInput" autocomplete="off">
          		<button class="btn btn-primary my-2 my-sm-0" type="submit" id="searchSubmit" disabled>Search</button>
          		<input type="hidden" name="action" value="SEARCH">
       		</form>
       		<c:if test="${currentUser.role == 'ADMIN'}">
           		<form action="Users" method="POST" class="navbar-form form-inline header-form">
					<button name="users" id="buttonUsers" class="btn btn-default" type="submit">Users</button>
           		</form>
           	</c:if>
           	<div class="name-surname">
           		<c:out value="${currentUser.name}"></c:out> <c:out value="${currentUser.surname}"></c:out>
           	</div>
           <!-- 	<button id="tooltip" type="button" class="btn btn-secondary" data-toggle="tooltip" data-placement="bottom" title="Tooltip on bottom">
			  	Tooltip on bottom
			</button> -->
           	<div>
           		<img src="<c:url value='/img/${currentUser.username}.jpg'></c:url>"
           			class="profile-icon rounded-circle" alt="" 
           			data-toggle="tooltip" data-placement="bottom" title="<c:out value='${currentUser.name}'></c:out><c:out value='${currentUser.surname}'></c:out>" />
           	</div>
			<form action="Logout" method="POST" class="header-form">
				<button name="logout" id="buttonLogout" type="submit" class="header-button btn btn-primary">Logout</button>
			</form>
		</div>
	</div>
</nav>

<script>
	$(document).ready(function() {
		$('#searchInput').on('keyup focusout', function() {
			if ($('#searchInput').val() != '') {
				$('#searchSubmit').attr('disabled', false);
			} else {
				$('#searchSubmit').attr('disabled', true);
			}
		});
		
		/* $(function () {
		  	$('#tooltip').tooltip();
		}); */
	});
</script>