<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REGISTER</title>
</head>
<body>
	<h2>회원가입</h2>
	
	<form action="register" method="POST">
		 아이디 : <input type="text" name="memberUserid">
		 비밀번호 : <input type="password" name="memberPassword">
		 이메일 : <input type="email" name="memberEmail">
		 
		 <!-- TODO : AJAX 구현하기 -->
		 <!-- TODO : 널 예외처리하기 -->
		 <input type="submit" value="가입하기">
	</form>
</body>
</html>