<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<c:choose>
	<c:when test="${action} == 'EDIT_ADMIN' || ${action} == 'EDIT_USER'">
		<title>Update</title>
	</c:when>
	<c:otherwise>
		<title>Signup</title>
	</c:otherwise>
</c:choose>

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

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.9/validator.js"></script>-->
<script src="<c:url value='vendors/pwstrength.js' />"></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/style.css' />">

<script type="text/javascript">
		
			$(document).ready(function() {
				
				// Function to create a date from a string
				function today() {
					var today = new Date();
					var dd = today.getDate();
					var mm = today.getMonth() + 1;
					var yyyy = today.getFullYear();

					if(dd < 10) {
					    dd = '0' + dd
					} 

					if(mm < 10) {
					    mm = '0' + mm
					} 

					return today = yyyy + '/' + mm + '/' + dd;					
				}
				
				// Function to check all element on focus out
				// If on focus out an element is empty...
				// 1) Set input border color red.
				// 2) Set error text in danger <small></small> container
				// 3) Show this previous element
				// 4) Set data-value attribute equal to 'error'
				// 5) Execute check() function...
				$('.check').focusout(function() {
					if ($(this).val() == '') {
						$(this).css('border-color','red');
						$(this).siblings('.text-danger').text('Error: ' + $(this).attr('name') + ' not valid');
						$(this).siblings('.text-danger').show();
						$(this).attr('data-value','error');
					}
					check();
				});
				
				// Function to check data-value value of all .check element to disable Submit/Update/Manage button
				function check() {
					// console.log('check()');
					var ok = true;
					
					// If at least one .check element data-value is not equal to 'ok'...
					// ...set 'ok' variable at 'false'!
					$('.check').each(function() {	
						var attr = $(this).attr('data-value');
						if (attr != 'ok') {
							ok = false;						
						}
					});
					
					// If 'ok' variable is still true and #terms is checked (Signup),
					// or .title is Update,
					// or .title is Manage...
					// ...enable .submit button!
					// Otherwise, disable it!
					if (ok && ($('#terms').is(':checked') || $('.title').text() == 'Update' || $('.title').text() == 'Manage')) {
						$('.submit').prop('disabled', false);
						$('.submit').css('cursor','pointer');
						$('.submit').css('background-color','#007bff');
						$('.submit').css('border-color','#007bff');
					} else {
						$('.submit').prop('disabled', true);
						$('.submit').css('cursor','default');
						$('.submit').css('background-color','grey');
						$('.submit').css('border-color','grey');
					}
				}
				
				var timerUsername = null;
				var timerBirthday = null;
				
				function checkUsername(input) {
					$.ajax({
					  	type: 'GET',
					  	url: 'CheckUsername',
				    	data: 'username=' + $('#username').val(),
					  	success: function(data, success) {
					  		var dataJson = JSON.parse(data);
					    	if (dataJson.type == '1') {
					    		$('#' + input).css('border-color','red');
					    		$('#' + input).siblings('.text-danger').html(dataJson.message);
						    	$('#' + input).siblings('.text-danger').show();
						    	$('#username').attr('data-value','error');
							} else if (dataJson.type == '0') {
								$('#' + input).css('border-color','rgba(0,0,0,.15)');
								$('#' + input).siblings('.text-danger').text('');
								$('#' + input).siblings('.text-danger').hide();
								$('#username').attr('data-value','ok');
							}
					    	check();
					  	}
				    });
				}
												
				$('.form-control').on('keyup', function() {
					if ($(this).val() != '') {
						var input = $(this).attr('name');
						switch (input) {
							case 'username':
								clearTimeout(timerUsername);
								timerUsername = setTimeout(function() { checkUsername(input); check(); }, 1000);
							break;
							case 'email':
								var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
								if (!pattern.test($(this).val())) {
									$(this).css('border-color','red');
									$('#' + input).siblings('.text-danger').html('Error: email not valid');
							    	$('#' + input).siblings('.text-danger').show();
							    	$('#email').attr('data-value','error');
								} else {
									$('#' + input).css('border-color','rgba(0,0,0,.15)');
									$('#' + input).siblings('.text-danger').text('');
									$('#' + input).siblings('.text-danger').hide();
									$('#email').attr('data-value','ok');
								}
								check();
								break;
							case 'birthday':
								/* clearTimeout(timerBirthday);
								timerBirthday = setTimeout(function() { checkBirthday(input); check(); }, 1000); */
								checkBirthday(input);
								check();
							break;
							default:
								$(this).css('border-color','rgba(0,0,0,.15)');
								$(this).siblings('.text-danger').text('');
								$(this).attr('data-value','ok');
								check();
						}
					}
					check();
				});
				
				$('#password').on('keyup', function() {
					$('.progress').show();
					$('.password-verdict').show();
					
					/* if ($('.password-verdict').text() == 'Weak'
							|| $('.password-verdict').text() == 'Normal') {
						$('#password').css('border-color','red');
						$('.password-verdict').css('color','red');
						$('#password').attr('data-value','error');
					} else {
						$('#password').css('border-color','rgba(0,0,0,.15)');
						$('.password-verdict').css('color','black');
						$('#password').attr('data-value','ok');
					}
					check(); */
				});
				
				if (!$('#terms').is(':checked')) {
					$(this).attr('data-value','error');
					check();
				}
				
				$('#terms').click(function() {
					if ($('#terms').is(':checked')) {
						$('#terms-alert').hide();
						$(this).attr('data-value','ok');
					} else {
						$('#terms-alert').show();
						$(this).attr('data-value','error');
					}
					check();
				});
				
				$('#password, #confirmation').on('keyup', function() {
					if ($('#confirmation').val() != $('#password').val()) {
						$('#confirmation').css('border-color','red');
						$('#password-alert').show();
						$('#password-alert').text('Error: passwords not equals');
						$('#confirmation').attr('data-value','error');
					} else {
						$('#confirmation').css('border-color','rgba(0,0,0,.15)');
						$('#password-alert').hide();
						$('#confirmation').attr('data-value','ok');
					}
					check();
				});
				
				if ($('#confirmation').attr('data-value') == 'ok') {
					$('#confirmation').css('border-color','rgba(0,0,0,.15)');
				} else {
					$('#confirmation').css('border-color','red');
				}
				
				$('#password').focusout(function() {
					$('.progress').hide();
					if ($('.password-verdict').text() == 'Strong' || $('.password-verdict').text() == 'Very Strong' || $('.password-verdict').text() == 'Medium') {
						$('.password-verdict').hide();
						$('#password').attr('data-value','ok');
					} else {
						$('#password').attr('data-value','error');
					}
					check();
				});
				
				$('#password').focus(function() {
					if ($('#password').val() != '') {
						$('.progress').show();
						$('.password-verdict').show();
					}
				});
				
				$('#update').click(function() {
					$.post('UpdateProfile',
				    {
						id: $('#idUser').val(),
				        name: $('#name').val(),
				        surname: $('#surname').val(),
				        username: $('#username').val(),
				        password: $('#password').val(),
				        confirmation: $('#confirmation').val(),
				        email: $('#email').val(),
				        birthday: $('#birthday').val(),
				        sex: $("input[name='sex']:checked").val(),
				        region: $('#region').val(),
				        terms: $("input[name='terms']:checked").val(),
				        role: $("input[name='role']:checked").val(),
				        button: $('.submit').text(),
				        action: 'UPDATE'
				    },
				    function(data, success) {
						console.log(data);
				    	if (data.type == '0') {
							$('#' + data.field).siblings('.text-danger').text(data.message);
							$('#' + data.field).siblings('.text-danger').show();
							$('#' + data.field).attr('data-value', 'error');
							check();
						} else if (data.type == '1') {
							if ($('.submit').text() == 'Update') {
								window.location.href = 'Profile';
							} else if ($('.submit').text() == 'Manage') {
								window.location.href = 'Users';
							}
						}
				    });
				});
				
				$('#signup').click(function() {
					
				 	var formData = new FormData();
				 	
				    formData.append('name', $('#name').val());
				    formData.append('surname', $('#surname').val());
				    formData.append('username', $('#username').val());
				    formData.append('password', $('#password').val());
				    formData.append('confirmation', $('#confirmation').val());
				    formData.append('email', $('#email').val());
				    formData.append('birthday', $('#birthday').val());
				    formData.append('sex', $('input[name="sex"]:checked').val());
				    formData.append('region', $('#region').val());
				    formData.append('image', $('#image').val());
				    formData.append('terms', $('input[name="role"]:checked').val());
				    formData.append('button', $('.submit').val());
					
					$.ajax({
			    	 	type: 'POST',
			            url: 'Signup',
			            data: formData,
			    	 	contentType: false,
			    	 	enctype: 'multipart/form-data',
			            processData: false,
			            cache: false,
			            timeout: 600000,
					    success: function(data, success) {
							if (data.type == '0') {
								$('#' + data.field).siblings('.text-danger').text(data.message);
							} else {
								if ($('.submit').text() == 'Update') {
									window.location.href = 'Profile';
								} else if ($('.submit').text() == 'Manage') {
									window.location.href = 'Users';
								} else if ($('.submit').text() == 'Signup') {
									window.location.href = 'Login';
								}
							}
						}
					});
				});
				
				$('.submit').click(function() {
					if ($('#username').siblings('.text-danger').is(':empty')) {
						$('#username').attr('data-value','error');
						check();
					}
				});
				
				/* $('#upload').click(function() {
					var formData = new FormData();
				    var fileData = $('#input-image').prop('files')[0];   
					formData.append("file", $('input[type=file]')[0].files[0]);
					formData.append("fileData", fileData);
					console.log(formData);
					$.ajax({
			            type: "POST",
			            enctype: 'multipart/form-data',
			            url: "UploadImage",
			            data: {
			            	serial: formData,
			            },
			            processData: false,
			            contentType: false,
			            cache: false,
			            timeout: 600000,
			            success: function (data) {
			                console.log('SUCCESS:' + data);
			            },
			            error: function (e) {
		            		console.log('ERROR' + e);
			            }
			        });
				}); */
				
				function checkBirthday(input) {
					var dateSetted = 'birthday=' + $('#birthday').val();
					$.get('CheckBirthday',
					    dateSetted,
					    function(data, success) {
							var dataJson = JSON.parse(data);
					    	if (dataJson.type == '1') {
					    		$('#' + input).siblings('.text-danger').html(dataJson.message);
						    	$('#' + input).siblings('.text-danger').show();
						    	$('#birthday').attr('data-value','error');
							} else if (dataJson.type == '0') {
								$('#' + input).css('border-color','rgba(0,0,0,.15)');
								$('#' + input).siblings('.text-danger').text('');
								$('#' + input).siblings('.text-danger').hide();
								$('#birthday').attr('data-value','ok');
							}
					    }
					);
					check();
				}
				
				$('#region').val("<c:choose><c:when test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='${currentUser.region}'></c:out></c:when><c:otherwise><c:out value='Europe'></c:out></c:otherwise></c:choose>");
				$("input[name='sex'][value='<c:out value='${currentUser.sex}'></c:out>']").prop('checked', true);
				
				$('#role').ready(checkRole("<c:out value='${currentUser.role}'></c:out>"));
				
				function checkRole(value) {
					if (value == 'ADMIN') {
						$('#role').prop('checked', true);
					}
				}
				
				$('#birthday').on('input', function() {
					if ($(this).val() != '' || $(this).val() != 'aaaa-mm-dd') {
						var birthdayArray = $(this).val().split('-');
						var aaaa = birthdayArray[0];
						var mm = birthdayArray[1];
						var dd = birthdayArray[2];
						
						if (aaaa != 'aaaa' && mm != 'mm' && dd != 'dd') {
							$(this).siblings('.text-danger').text('');
							$(this).siblings('.text-danger').hide();
							$(this).attr('data-value','ok');
						} else {
							$(this).siblings('.text-danger').text('Error: birthday not valid');
							$(this).siblings('.text-danger').show();
							$(this).attr('data-value','error');
						}						
					}
			    	check();
				});
				
				
				if ($('#birthday').val() == '') {
					$('#birthday').siblings('.text-danger').html('Error: birthday not valid');
			    	$('#birthday').siblings('.text-danger').show();
			    	$('#birthday').attr('data-value','error');
				} else {
					$('#birthday').siblings('.text-danger').text('');
					$('#birthday').siblings('.text-danger').hide();
					$('#birthday').attr('data-value','ok');
				}
			});
		
		</script>

		<script type="text/javascript">
			$(document).ready(function () {
				'use strict';
				var options = {
					bootstrap4: true,
					useVerdictCssClass: true,
					ui: {scores: [0, 14, 26, 38, 50]}
				};
				$('#password').pwstrength(options);
			});
		</script>
</head>

<body id="body">

	<div class="container h-100">
		<div class="row h-100 justify-content-center align-items-center">
			<div class="col-md-4">
				<div>
					<input id="idUser" type="hidden" name="idUser"
						<c:if test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='value=${currentUser.id}'></c:out></c:if> />
					<c:choose>
						<c:when test="${action == 'EDIT_ADMIN'}">
							<h1 class="title">Update</h1>
						</c:when>
						<c:when test="${action == 'EDIT_USER'}">
							<h1 class="title">Manage</h1>
						</c:when>
						<c:otherwise>
							<h1 class="title">Signup</h1>
						</c:otherwise>
					</c:choose>
					<br>
					<div class="form-group">
						<label for="name" class="control-label">Name</label> <input
							type="text" class="form-control check" id="name" name="name"
							required data-error="Error: name not valid" autocomplete="off"
							autofocus="true"
							<c:if test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='value=${currentUser.name}'></c:out></c:if>
							<c:choose><c:when test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='data-value=ok'></c:out></c:when></c:choose>>
						<small class="text-danger"></small>
					</div>
					<div class="form-group">
						<label for="surname" class="control-label">Surname</label> <input
							type="text" class="form-control check" id="surname"
							name="surname" required="true"
							data-error="Error: surname not valid" autocomplete="off"
							<c:if test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='value=${currentUser.surname}'></c:out></c:if>
							<c:choose><c:when test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='data-value=ok'></c:out></c:when></c:choose>>
						<small class="text-danger"></small>
					</div>
					<div class="form-group">
						<label for="username">Username</label> <input
							class="form-control check" type="text" id="username"
							name="username"
							<c:if test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='value=${currentUser.username}'></c:out></c:if>
							<c:choose><c:when test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='disabled readonly data-value=ok'></c:out></c:when></c:choose>>
						<small class="text-danger"></small>
					</div>
					<div id="passwordMeter">
						<div class="form-group">
							<label for="password" class="control-label">Password</label> <input
								type="password" class="form-control check" id="password"
								name="password" required="true"
								data-error="Error: password not valid" autocomplete="off"
								<c:if test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='value=${currentUser.password}'></c:out></c:if>
								<c:choose><c:when test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='data-value=ok'></c:out></c:when></c:choose>>
							<small class="text-danger"></small>
						</div>
						<div class="pwstrength_viewport_progress"></div>
					</div>
					<div class="form-group">
						<label for="confirmation" class="control-label">Password</label> <input
							type="password" class="form-control check" id="confirmation"
							name="confirmation" required="true"
							data-error="Error: password not valid" autocomplete="off"
							<c:if test="${action != 'EDIT_ADMIN' || action != 'EDIT_USER'}"><c:out value='data-value=ok'></c:out></c:if>>
						<small id="password-alert" class="text-danger"></small>
					</div>
					<div class="form-group">
						<label for="email" class="control-label">E-mail</label> <input
							type="email" class="form-control check" id="email" name="email"
							required="true" data-error="Error: email not valid"
							autocomplete="off"
							<c:if test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='value=${currentUser.email}'></c:out></c:if>
							<c:choose><c:when test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='data-value=ok'></c:out></c:when></c:choose>>
						<small class="help-block with-errors text-danger"></small>
					</div>
					<div class="form-group">
						<label for="birthday" class="control-label">Birthday</label> <input
							class="form-control check" type="date" id="birthday"
							name="birthday" data-value="ok" autocomplete="off"
							<c:choose><c:when test="${action == 'EDIT_ADMIN' || action == 'EDIT_USER'}"><c:out value='value=${currentUser.birthday}'></c:out></c:when><c:otherwise><c:out value='value=1970-01-01'></c:out></c:otherwise></c:choose>>
						<small class="text-danger"></small>
					</div>

					<fieldset class="form-group">
						<label for="sex" class="control-label">Sex</label> <br>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="radio"
								class="sex form-check-input" name="sex" id="m" value="m" checked>
								M
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="radio"
								class="sex form-check-input" name="sex" id="f" value="f">
								F
							</label>
						</div>
						<small class="text-danger"></small>
					</fieldset>

					<div class="form-group">
						<label for="region">Region</label> <select class="form-control"
							id="region" name="region" data-value="ok">
							<option>Europe</option>
							<option>America</option>
							<option>Asia</option>
							<option>Africa</option>
							<option>Antarctica</option>
							<option>Oceania</option>
						</select> <small class="text-danger"></small>
					</div>

					<!-- <br> <label class="custom-file"> <input type="file"
						id="image" class="custom-file-input" name="image">
						<span class="custom-file-control" style="width: 350px"></span>
					</label> <br>
					<br> -->

					<c:choose>
						<c:when test="${action != 'EDIT_ADMIN' && action != 'EDIT_USER'}">
							<div class="form-check">
								<label class="form-check-label"> <input
									class="form-check-input" type="checkbox" name="terms"
									id="terms" required> Accept <a href="#">Terms of
										use</a>
								</label> <br> <small id="terms-alert" class="text-danger"
									style="display: none">Error: accept terms of use</small>
							</div>
							<br>
						</c:when>
					</c:choose>

					<c:choose>
						<c:when test="${action == 'EDIT_USER'}">
							<div class="form-check">
								<label class="form-check-label"> <input
									class="form-check-input" type="checkbox" name="role" id="role">
									Admin
								</label>
							</div>
						</c:when>
					</c:choose>

					<div id="feedbackSignup" class="alert" role="alert"
						style="display: none"></div>

					<c:choose>
						<c:when test="${action == 'EDIT_ADMIN'}">
							<button class="btn btn-lg btn-primary btn-block disabled submit"
								type="submit" name="update" id="update" disabled>Update</button>
						</c:when>
						<c:when test="${action == 'EDIT_USER'}">
							<button class="btn btn-lg btn-primary btn-block disabled submit"
								type="submit" name="update" id="update" disabled>Manage</button>
							<input type="hidden" name="otherUser"
								value="${otherUser.username}">
						</c:when>
						<c:otherwise>
							<button class="btn btn-lg btn-primary btn-block disabled submit"
								type="submit" name="signup" id="signup" disabled>Signup</button>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- <button class="" type="submit" name="upload" id="upload">Upload</button> -->
				
				<br>

				<c:choose>
					<c:when test="${action == 'EDIT_ADMIN'}">
						<a href="Profile" class="btn btn-link btn-block">Profile</a>
					</c:when>
					<c:when test="${action == 'EDIT_USER'}">
						<a href="Users" class="btn btn-link btn-block">Users</a>
					</c:when>
					<c:otherwise>
						<a href="Login" class="btn btn-link btn-block">Login</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		
		$(document).ready(function() {
			$('.progress').hide();
			$('.password-verdict').hide();
		});
			
	</script>

</body>

</html>