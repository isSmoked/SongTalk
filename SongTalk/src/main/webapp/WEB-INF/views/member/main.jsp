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
		  
	  
	</div>
	
	<!-- 비로그인! -->
	<!-- 로그인 / 등록 -->
	<c:if test="${loginId eq null }">
		<div>
		<!-- 로그인 -->
		  	<a href="member/login">
		  		<button class="btn btn-danger" style="float: left; width:20%; height:350px; font-size:50px;">
		  			<span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;" class="glyphicon glyphicon-user" aria-hidden="true"></span>
		  			<div>&nbsp;</div>
		  			<div><span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;">LOGIN</span></div>
		  		</button>
		  	</a>
		
		<div style="float: left; width:5%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
		<!-- 회원가입 -->
			<a href="member/register">
				<button class="btn btn-white text-danger" style=" float: left; width:20%; height:350px; font-size:50px; border-style:solid; border-color:red;">
					<span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;" class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					<div>&nbsp;</div>
					<div><span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;">REGISTER</span></div>
				</button>
			</a>
			
			<!-- 지울것! -->
		<div style="float: left; width:5%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
		
			<a href="chat/HOME">
				<button class="btn btn-danger text-white" style=" float: left; width:20%; height:350px; font-size:50px; border-style:solid; border-color:red;">
					<span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;" class="glyphicon glyphicon-home" aria-hidden="true"></span>
					<div>&nbsp;</div>
					<div><span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;">ENTER</span></div>
				</button>
			</a>
		
		</div>
	</c:if>
	
	<!-- 로그인! -->
	<!-- 수정 / 채팅방 입장 -->
	<c:if test="${loginId ne null }">
		<div>
		<!-- 수정 -->
		  	<a href="member/update">
		  		<button class="btn btn-danger" style="float: left; width:20%; height:350px; font-size:50px;">
		  			<span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;" class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
		  			<div>&nbsp;</div>
		  			<div><span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;">UPDATE</span></div>
		  		</button>
		  	</a>
		
		<div style="float: left; width:5%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
		<!-- 채팅방 입장 -->
			<a href="chat/HOME">
				<button class="btn btn-white text-danger" style=" float: left; width:20%; height:350px; font-size:50px; border-style:solid; border-color:red;">
					<span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;" class="glyphicon glyphicon-home" aria-hidden="true"></span>
					<div>&nbsp;</div>
					<div><span style="width:20%; height:350px; font-size:50px; height:40px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;">ENTER</span></div>
				</button>
			</a>
		
		</div>
	</c:if>
	
</body>
</html>