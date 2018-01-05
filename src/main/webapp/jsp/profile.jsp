<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
	integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css"
	integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M"
	crossorigin="anonymous">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"
	integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1"
	crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/style.css' />">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
			$(document).ready(function() {
				$("#navbar").load("<c:url value='/jsp/partials/navbar.jsp' />");
			});
		</script>

</head>

<body>

	<div id="navbar"></div>

	<div class="container">

		<div class="row">

			<div class="col-sm-6 col-md-4 mb-5">
				<img
					src="<c:out value='${pageContext.request.contextPath}'></c:out>/img/<c:out value='${currentUser.username}'></c:out>.jpg"
					class="profile-image">
			</div>

			<div class="col-sm-6 col-md-8">
				<div class="row">
					<div class="col">
						<h1>Profile</h1>
					</div>
				</div>

				<div class="field-row row">
					<div class="field-name col-md-4">Name</div>
					<div class="field-value col-md-8">
						<c:out value="${currentUser.name}" />
					</div>
				</div>

				<div class="field-row row">
					<div class="field-name col-md-4">Surname</div>
					<div class="field-value col-md-8">
						<c:out value="${currentUser.surname}" />
					</div>
				</div>

				<div class="field-row row">
					<div class="field-name col-md-4">Username</div>
					<div class="field-value col-md-8">
						<c:out value="${currentUser.username}" />
					</div>
				</div>

				<div class="field-row row">
					<div class="field-name col-md-4">Password</div>
					<div class="field-value col-md-8">
						<c:out value="${currentUser.password}" />
					</div>
				</div>

				<div class="field-row row">
					<div class="field-name col-md-4">E-mail</div>
					<div class="field-value col-md-8">
						<c:out value="${currentUser.email}" />
					</div>
				</div>

				<div class="field-row row">
					<div class="field-name col-md-4">Birthday</div>
					<div class="field-value col-md-8">
						<c:out value="${currentUser.birthday}" />
					</div>
				</div>

				<div class="field-row row">
					<div class="field-name col-md-4">Sex</div>
					<div class="field-value col-md-8">
						<c:out value="${currentUser.sex}" />
					</div>
				</div>

				<div class="field-row row">
					<div class="field-name col-md-4">Region</div>
					<div class="field-value col-md-8">
						<c:out value="${currentUser.region}" />
					</div>
				</div>

				<div class="field-row row">
					<div class="field-value col">
						<form action="EditAdmin" method="POST">
							<button type="submit" class="btn btn-primary">Edit</button>
							<input type="hidden" name="action" value="EDIT_ADMIN">
						</form>
					</div>
				</div>

			</div>

		</div>

	</div>

</body>

</html>