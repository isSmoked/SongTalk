<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<meta charset="UTF-8">
<title>채팅 홈</title>

<script type="text/javascript">
$(document).ready(function(){
	console.log('자바스크립트가 작동하나요?');
	
	// WEBSOCKET ---------------------------------------------------------
	var sock = new WebSocket('ws://' + window.location.host + '/songtalk/chat/websocket');
	
	sock.open = function() {
		console.log('websocket opened');
	};
	
	sock.onmessage = function (event) {
		var message = event.data.split('[*]');
		var cmd = message[0];
		var caller = message[1];
		var roomReceiver = message[2];	// 메시지를 받을 사람인데 필요가 없다
		var title = message[3];
		var content = message[4];
		
		const chat = document.getElementById('chatBlock');
		
		if (title === '${vo.roomTitle}'){ // 해당 대화방에만 메시지 출력
			if (cmd === 'roomCHAT') {	// 대화방 채팅
				// caller + content
				if (caller === '${loginId}') { 		  // 내 메시지
					chat.innerHTML += '<p id="sentMsg" style="background:lightGrey; text-color:white; text-align:right;">' + content + '</p>';
		  			console.log('sent message');
				} else if (caller !== '${loginId}') { // 내 메시지가 아닐때
					chat.innerHTML += '<p id="receivedMsg" style="text-align:left">' + caller + ' : ' + content + '</p>';
	  				console.log('received message');
				}	
			}
		}
		
	}
	
	sock.onclose = function (event) {
		console.log('websocket closed : ' + event);
	}
	
	
})
</script>

</head>
<body>

	<div class="jumbotron bg-white">
		  <h1>Song Talk</h1>
		  <h1>&nbsp;</h1>
		  <h4>chat with unknown!</h4>
	</div>
	
	
	
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>