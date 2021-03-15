<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 채팅방</title>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	
</script>

</head>
<body>

	<h2>전체 채팅방</h2>
	
	<!-- chat -->
	<div id="chat">
		<!-- 채팅 내역 -->
		<div id="allchatBlock"></div>
		
		<!-- 입력 창 -->
		<div>
			<input type="hidden" id="msgUserid" value="${loginId }"/>
		</div>
		
		<div>
			<input type="text" id="allmsgContent" value="" autofocus/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="btn btn-dark" type="button" value="보내기" id="allmsg_send"/>
		</div>
	</div>
</body>
</html>