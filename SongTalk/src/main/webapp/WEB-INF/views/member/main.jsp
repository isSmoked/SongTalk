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
	<div class="jumbotron bg-danger">
		  <h1 class="text-light">Song Talk</h1>
		  <h1>&nbsp;</h1>
		  <h4 class="text-light">chat with unknown!</h4>
		  <h1>&nbsp;</h1>
		  <h1>&nbsp;</h1>
	  <p><a class="btn btn-lg btn-light text-danger" href="member/login" role="button">LOGIN</a>
	     <a class="btn btn-lg btn-light text-danger" href="chat/HOME" role="button">HOME</a>
	     
	     <c:if test="${loginId ne null }">
			<a class="btn btn-lg btn-light text-danger" href="chat/HOME" role="button">HOME</a>
		 </c:if></p>
	</div>
	
	
</body>
</html>