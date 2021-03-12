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
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>main</title>

<script type="text/javascript">
	// toastr
	toastr.options = {
		  "closeButton": false,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": false,
		  "positionClass": "toast-bottom-center",
		  "preventDuplicates": true,
		  "onclick": null,
		  "showDuration": "300",
		  "hideDuration": "1000",
		  "timeOut": "5000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
	} // toastr
</script>

</head>
<body>
	<!-- 로그인버튼(작게), 채팅방검색, 챗봇, 내정보 -->
	<h1>메인 페이지</h1>
	
	<!-- 로그인 -->
	<a href="member/login"><input type="button" value="login"></a>
	
	<c:if test="${loginId ne null }">
		<a href="chat/HOME"><input type="button" value="채팅방 홈"></a>
	</c:if>
	
	<!-- 지울 것 test 용 -->
	<a href="chat/HOME"><input type="button" value="채팅방 홈"></a>
	
</body>
</html>