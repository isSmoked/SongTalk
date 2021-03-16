<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REGISTER</title>

<script type="text/javascript">
	
</script>

</head>
<body>
	
	<div class="jumbotron bg-white" style="right:0; width:50%;">
		  <h1>Register</h1>
		  <h3>&nbsp;</h3>
		  <h4>&nbsp;&nbsp;&nbsp;Join our Service!</h4>
	</div>
	
	<form action="register" method="POST">
		<div style="font-size:25px; position:absolute; left:30%;">아이디&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="left:80%" type="text" name="memberUserid"></div>
		<div style="font-size:25px; position:absolute; left:30%; top:46%">닉네임&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="left:80%" type="text" name="memberNickname"></div>
		<div style="font-size:25px; position:absolute; left:30%; top:56%;">비밀번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="memberPassword" style="left:50%;"></div>
		<div style="font-size:25px; position:absolute; left:30%; top:66%;">비밀번호 확인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="memberPassword" style="left:50%;"></div>
		<div style="font-size:25px; position:absolute; left:30%; top:76%;">이메일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="email" name="memberEmail" style="left:50%;"></div>
		<p>&nbsp;</p>
		<div style="font-size:25px; position:absolute; left:60%; top:86%; "><input style="width:80px; height:40px;" class="btn btn-lg btn-danger" type="submit" value="REGISTER"></div>
		 <!-- TODO : AJAX 구현하기 -->
		 <!-- TODO : 널 예외처리하기 -->
	</form>
</body>
</html>