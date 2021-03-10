<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHAT ROOM</title>

<script type="text/javascript">
	$(document).ready(function(){
		console.log('자바스크립트가 작동하나요?');
		
		// WEBSOCKET ---------------------------------------------------------
		var sock = new WebSocket('ws://' + window.location.host + '/songtalk/chat/all');
		
		sock.open = function() {
			console.log('websocket opened');
		};
		
		sock.onmessage = function (event) {
			// chat
			if (event.data.split(',')[0] === 'allCHAT') {
	  			aaa();
	  			function aaa() {
			  		$('#chat').css({
				  		'position' : 'fixed',
				  		'bottom':0,
						'right':'15px',
						'padding':'10px',
						'font-size':'12px',
						'width':'300px',
						'height':'250px',
						'border-width':'1px 1px 0 1px',
						'border-color':'#aaaaaa',
						'border-style':'solid',
						'background-color': '#fafafa'
				  	}); // end #(chat) css
				  	
				  	$('#chatBlock').css({
				  		'position' : 'fixed',
				  		'bottom': '40px',
				  		'width' : '280px',
				  		'height' : '155px',
				  		'right' : '25px',
				  		'border-width':'1px 1px 0 1px',
				  		'border-color':'#aaaaab',
						'background-color': '#fafafa',
						'overflow-x' : 'hidden'
				  	}); // end #(chatBlock) css
				  	
				  	$('#chatBlock').scrollTop = $('#chatBlock').scrollHeight;
				  	
				  	$('#chat').show();
					$('#chatClose').show();
					$('#chatTitle').show();
					
					if ('${loginId}' === null){
						$('#chatButton').hide();
					} else {
						$('#chatButton').show();
					}
					
					// 스크롤바 자동으로 내리기
				  	$('#chatBlock').scrollTop($('#chatBlock')[0].scrollHeight);
				};
	  			
	  			msgSender = event.data.split(',')[1].split(' ')[0];
	  			userid = '${loginId}';
	  			
	  			console.log('received chat : ' + event.data);
	  			console.log('userid : ' + userid);
	  			console.log('msgSender : ' + msgSender);
	  			const chat = document.getElementById('chatBlock');
	  			
	  			var sentMsg = event.data.split(',')[1].split('^')[1];
	  			var msgForSave = event.data.split(',')[1];
	  			EnterMsg = msgForSave;
				
	  			console.log('>>>>>>>>>>>msgForSave : ' + msgForSave);
	  			
	  			// 내 메세지인지 확인
	  			if (msgSender === '${ loginId}') {
		  			chat.innerHTML += '<p id="sentMsg" style="background:lightGrey; text-color:white; text-align:right;">' + sentMsg + '</p>';
		  			console.log('sent message');
		  			
		  			// ajax로 데이터 저장!
	  				// saveChat(msgForSave);
	  				// console.log('내메시지 saveChat() - after 호출');
		  			// setAllchat(msgForSave);
		  			
	  				// ajax 데이터 수정 -> 보이기
	  				setAllchat(msgForSave);
	  				
		  			// 스크롤바 자동으로 내리기
				  	$('#chatBlock').scrollTop($('#chatBlock')[0].scrollHeight);
	  			} else if (msgSender !== '${ loginId}') {
	  				chat.innerHTML += '<p id="receivedMsg" style="text-align:left">' + event.data.split(',')[1].replace('^',':') + '</p>';
	  				console.log('received message');
	  				
	  				// ajax로 데이터 저장!
	  				// saveChat(msgForSave);
	  				// console.log('남 메시지 saveChat() - after 호출');
	  				
	  				// ajax 데이터 수정 -> 보이기
	  				setAllchat(msgForSave);
	  				
		  			// 스크롤바 자동으로 내리기
				  	$('#chatBlock').scrollTop($('#chatBlock')[0].scrollHeight);
	  			}
	  			
	  			// chat이 보내지면 바로 저장시킨다.
	  			$('#msgContent').val('');
				
	  		}
		}
	})
</script>

</head>
<body>
	
	<!-- ======================= chat ====================== -->
  	<!-- chat button -->
	<c:if test="${loginId ne null }">
  	<div id="chatButton" style="position: fixed; right:20px; bottom:0px;">
	  	<input  type="button" class="btn btn-dark" onclick="chat()" value="&nbsp;&nbsp;&nbsp;&nbsp;chat&nbsp;&nbsp;&nbsp;&nbsp;">
	  	<!-- chat 오른쪽에 채팅 이미지를 넣으면 좋겠다 -->
  	</div>
	</c:if>

	<!-- chat -->
	<div id="chat">
		<!-- 닫기 버튼 -->
		<div style="text-align:right;">
			<p id="chatTitle">자유 채팅방&nbsp;&nbsp;<input id="chatClose" type="button" onclick="frameclose()" class="btn btn-dark" value="X"></p>
		</div>
		
		<!-- 채팅 내역 -->
		<div id="chatBlock"></div>
		
		<!-- 입력 창 -->
		<div>
			<input type="hidden" id="msgUserid" value="${loginId }"/>
		</div>
		
		<div style="position:absolute; bottom:2px; text-align:center; background-color:white;">
			<input type="text" id="msgContent" value="" autofocus/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="btn btn-dark" type="button" value="보내기" id="msg_send"/>
		</div>
	</div>
	<!-- end chat -->
	
	
</body>
</html>