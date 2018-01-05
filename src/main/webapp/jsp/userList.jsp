<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>

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

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/style.css' />">

<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$("#navbar").load(
								"<c:url value='/jsp/partials/navbar.jsp' />");

						$(".closeRefresh").click(function() {
							location.reload();
						});

						$(".editPersonButton").click(
								function() {
									$("#idPerson").val(
											$(this).parent().children(
													":first-child").val());
									$("#cf2").val(
											$(this).parents().siblings(
													"td:nth-child(1)").html());
									$("#name2").val(
											$(this).parents().siblings(
													"td:nth-child(2)").html());
									$("#surname2").val(
											$(this).parents().siblings(
													"td:nth-child(3)").html());
								});

						$(".deleteUser").click(
								function() {
									var id = $(this).parent().children().find(
											"input:hidden[name=idUser]").val();

									$.post("DeleteUser", {
										id : id,
										action : "DELETE"
									}, function(data, success) {
										location.reload();
									});
								});
					});
</script>

</head>

<body id="body">

	<div id="navbar"></div>

	<div class="container">
		<div class="col-md-8 col-md-offset-2 p-0">
			<c:choose>
				<c:when test="${search != null}">
					<h5>
						Search: "<b><c:out value="${search}"></c:out></b>"
					</h5>
				</c:when>
			</c:choose>

			<br>
			<table class="table">
				<c:choose>
					<c:when test="${users != null}">
						<thead>
							<tr>
								<th>Username</th>
								<th>Password</th>
								<th>E-mail</th>
							</tr>
						</thead>

						<tbody id="personList">
							<c:forEach var="userList" items="${users}">
								<c:if test="${userList.username != currentUser.username}">
									<tr>

										<td><c:out value="${userList.username}" /></td>
										<td><c:out value="${userList.password}" /></td>
										<td><c:out value="${userList.email}" /></td>

										<td class="updateForm">
											<div class="dropdown">
												<button class="btn btn-secondary dropdown-toggle"
													type="button" id="dropdownMenu2" data-toggle="dropdown"
													aria-haspopup="true" aria-expanded="false">
													Actions</button>
												<div class="dropdown-menu" aria-labelledby="dropdownMenu2">
													<form action="EditUser" method="POST" style="margin: 0">
														<input type="hidden" name="idUser"
															value='<c:out value="${userList.id}"></c:out>'> <input
															type="hidden" name="otherUsername"
															value='<c:out value="${userList.id}"></c:out>'> <input
															type="hidden" name="action"
															value='<c:out value="EDIT_USER"></c:out>'>
														<button type="submit" class="dropdown-item">Edit</button>
													</form>
													<button type="button" class="deleteUser dropdown-item">Delete</button>
												</div>
											</div>
										<td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</c:when>
				</c:choose>
			</table>
		</div>
	</div>

</body>

</html>