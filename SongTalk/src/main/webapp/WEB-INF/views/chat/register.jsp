<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>


	<div class="jumbotron bg-danger" style="right:0; width:50%;">
		  <h1 style="text-color:white;">Room Register</h1>
		  <h3>&nbsp;</h3>
		  <h4 style="text-color:white;">&nbsp;&nbsp;&nbsp;Register your new chat-room!</h4>
		  <h3>&nbsp;</h3>
		  <h3>&nbsp;</h3>
		  <form action="register" method="post">
		  		<input type="hidden" name="roomUser" value="${loginId }">
		  		<input type="hidden" name="roomContent" value=" ">
		        <input style="width:300px; font-size:15px; height:30px;" type="text" name="roomTitle" placeholder="write your roomTitle!"/>
		        <button type="submit" class="btn btn-white btn-lg" style="height:30px;">make</button>
		  </form>
	</div>
	
</body>
</html>