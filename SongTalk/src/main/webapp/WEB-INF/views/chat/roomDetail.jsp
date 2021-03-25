<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHAT ROOM</title>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	
</script>

</head>
<body>

	<div class="page-header">
  		<h1>${roomVO.roomTitle } 대화방 &nbsp;&nbsp;&nbsp;&nbsp;<small>start chat with everyone!</small></h1>
	</div>
	
	<!-- chat -->
	<div id="chat">
		<!-- 채팅 내역 -->
		<div id="roomchatBlock"></div>
		
		<!-- 입력 창 -->
		<div>
			<input type="hidden" id="msgUserid" value="${loginId }"/>
		</div>
		
		<div style="position: fixed; bottom: 30px; width:500px; height:40px;">
			<input type="text" id="roommsgContent" value="" style="width:70%; height:100%; font-size:25px;" autofocus/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="width:20%; height:100%;" class="btn btn-danger btn-lg" type="button" value="Send" id="roommsg_send"/>
		</div>
	</div>
	
</body>
</html>