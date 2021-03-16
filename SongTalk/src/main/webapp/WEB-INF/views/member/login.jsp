<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

	<div class="jumbotron bg-white" style="right:0; width:50%;">
		  <h1>Login</h1>
		  <h3>&nbsp;</h3>
		  <h4>&nbsp;&nbsp;&nbsp;Login with your Account!</h4>
		 
	</div>

	<form action="login-post" method="POST">
		<div style="font-size:25px; position:absolute; left:35%;">아이디&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  type="text" name="memberUserid"></div>
		<div style="font-size:25px; position:absolute; left:35%; top:45%;">비밀번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="memberPassword" style="left:50%;"></div>
		<p>&nbsp;</p>
		<input type="hidden" value="${targetUrl }" name="targetUrl" id="targetUrl">
		<div style="font-size:25px; position:absolute; left:60%; top:60%; "><input style="width:80px; height:40px;" class="btn btn-lg btn-danger" type="submit" value="LOGIN"></div>
	</form>
	
	
	<div class="alert alert-danger" role="alert" style="position:absolute; left:28%; top:75%; width:50%; height:55px; font-size:20px;">
		&nbsp;&nbsp;&nbsp; Si vouz avez pas d'account, Registrez-vous a ici.
		<a href="register">
			<button class="btn btn-lg btn-danger" style="position:absolute; right:5%; width:80px; height:40px;">Register</button>
		</a>
	</div>
	
	
</body>
</html>