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

	<form action="login" method="POST">
		아이디 : <input type="text" name="memberUserid">
		비밀번호 : <input type="text" name="memberPassword">
		<input type="button" value="LOGIN">
	</form>

	<!-- 회원가입 -->
	<a href="register"><input type="button" value="REGISTER"></a>

</body>
</html>