<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<title><decorator:title /></title>
<decorator:head />
</head>
<body>
	<header>
		<page:applyDecorator name="header"></page:applyDecorator>
	</header>

	<section>
		<div>
			<div style="float: left; width: 20%;">
				<page:apply-decorator name="menu"></page:apply-decorator>
			</div>

			<div style="border: 1px; float: right; width: 75%;">
				<decorator:body />
				
				
			</div>
		</div>
	</section>

 	<footer>
		<div>
			<page:apply-decorator name="footer"></page:apply-decorator>
		</div>
	</footer>
	
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
			
			$(document).ready(function(){
				console.log('layout - 자바스크립트가 작동하나요?');
				
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
					
					
					
					if (cmd === 'roomCHAT'){ // 대화방 채팅
						if (title === '${vo.roomTitle}') {	// 해당 대화방에만 메시지 출력
							const chat = document.getElementById('roomchatBlock');
							// caller + content
							if (caller === '${loginId}') { 		  // 내 메시지
								chat.innerHTML += '<p id="sentMsg" style="background:lightGrey; text-color:white; text-align:right;">' + content + '</p>';
					  			console.log('sent message');
							} else if (caller !== '${loginId}') { // 내 메시지가 아닐때
								chat.innerHTML += '<p id="receivedMsg" style="text-align:left">' + caller + ' : ' + content + '</p>';
				  				console.log('received message');
							}
							$('#roomchatBlock').scrollTop = $('#roomchatBlock').scrollHeight;
							$('#roommsgContent').val('');
						}
					} else if (cmd === 'allCHAT') { // 전체 채팅
							const chat = document.getElementById('allchatBlock');
							// caller + content
							if (caller === '${loginId}') { 		  // 내 메시지
								chat.innerHTML += '<p id="sentMsg" style="background:lightGrey; text-color:white; text-align:right;">' + content + '</p>';
					  			console.log('sent message');
							} else if (caller !== '${loginId}') { // 내 메시지가 아닐때
								chat.innerHTML += '<p id="receivedMsg" style="text-align:left">' + caller + ' : ' + content + '</p>';
				  				console.log('received message');
							}	
							$('#allchatBlock').scrollTop = $('#allchatBlock').scrollHeight;
							$('#allmsgContent').val('');
					}
					
				}
				
				sock.onclose = function (event) {
					console.log('websocket closed : ' + event);
				}
				
				
				// room chat function
				if ($('roommsgContent').val() !== ""){
					// 보내기버튼 활용
					$('#roommsg_send').click(function chatMessage(msgForSave) {
				  		if ($('#msgContent').val() !== ""){
				  			// 메시지 데이터 
				  			// cmd, caller, receiver, title, content
				  			var cmd = 'roomCHAT';
				  			var caller = '${loginId}';
				  			var receiver = '${vo.roomReceiver}'; // TODO : 채팅방유저 split 구현하고 오기
				  			var title = '${vo.roomTitle}';
				  			var content = $('#roommsgContent').val();
				  			
				  			var message = cmd + '*' + caller + '*' + receiver + '*' + title + '*' + content; 
				  			console.log('보내는 메세지 : ' + message);
				  			
							sock.send(message);	
				  		} else {
				  			console.log('채팅내용 없음');
				  		}
			    	});
					
					 // 엔터키 활용
					 $('#roommsgContent').keydown(function(key, msgForSave){
						if (key.keyCode == 13) {
							console.log('엔터키 눌림');
							chatMessage(EnterMsg);
							console.log('엔터로 chatMessage() 작동');
						} 
					 });
				}
				
				// all chat function
				if ($('allmsgContent').val() !== "") {
					$('#allmsg_send').click(function chatMessage(msgForSave) {
						if ($('#allmsgContent').val() !== ""){
				  			// 메시지 데이터 
				  			// cmd, caller, receiver, title, content
				  			var cmd = 'allCHAT';
				  			var caller = '${loginId}';
				  			var receiver = ' '; // TODO : 채팅방유저 split 구현하고 오기
				  			var title = ' ';
				  			var content = $('#allmsgContent').val();
				  			
				  			var message = cmd + '*' + caller + '*' + receiver + '*' + title + '*' + content; 
				  			console.log('보내는 메세지 : ' + message);
				  			
							sock.send(message);	
				  		} else {
				  			console.log('채팅내용 없음');
				  		}
					});
					
					// 엔터키 활용
					$('#allmsgContent').keydown(function(key, msgForSave){
						if (key.keyCode == 13) {
							console.log('엔터키 눌림');
							chatMessage(EnterMsg);
							console.log('엔터로 chatMessage() 작동');
						} 
					});
				}
				
				
				
			})
	</script>
</body>
</html>