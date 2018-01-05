<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>

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
	src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.9/validator.js"></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/style.css' />">

</head>

<body>

	<div class="container h-100">
		<div class="row h-100 justify-content-center align-items-center">
			<div class="col-md-4">
				<form action="Login" method="POST" role="form"
					data-toggle="validator" modelAttribute="user">
					<h1>Login</h1>
					<br>
					<div class="form-group">
						<label for="username" class="control-label">Username</label> <input
							type="text" class="form-control" id="username" name="username"
							autofocus="true" required="true"
							data-error="Error: username not valid"> <small
							class="help-block with-errors text-danger"></small>
					</div>
					<div class="form-group">
						<label for="password" class="control-label">Password</label> <input
							type="password" class="form-control" id="password"
							name="password" required="true"
							data-error="Error: password not valid"> <small
							class="help-block with-errors text-danger"></small>
					</div>
					<button class="btn btn-lg btn-primary btn-block" type="submit"
						name="login">Login</button>
					<br>
					<c:choose>
						<c:when test="${!empty error}">
							<div ID="error" class="alert alert-danger" role="alert">
								<strong>Error</strong>
								<c:out value="${error}"></c:out>
							</div>
						</c:when>
					</c:choose>
				</form>
				<a href="Signup" class="btn btn-link btn-block">Signup</a>
			</div>
		</div>
	</div>

</body>

</html>