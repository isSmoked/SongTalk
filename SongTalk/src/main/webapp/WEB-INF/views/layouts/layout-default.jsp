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
				var printMSG = '';
				
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
				
				// *******************************************************************************
				// ajax로 message 저장 (msg)
				$('#btn_aaa').click(function() {
					var content = $('#aaaContent').val();
					// 게시판 번호를 받아온다!
					var roomBno = '${vo.roomBno}';
					
					var obj = {
							'msgSender' : '${loginId}',
							'msgReceiver' : ' ',
							'msgContent' : content,
							'msgRoom' : roomBno
						};
					console.log(obj);
					$.ajax({
						type : 'post',
						url : 'chat',
						headers : {
							'Content-Type' : 'application/json',
							'H-HTTP-Method-Override' : 'POST'
						},
						data : JSON.stringify(obj),
						success : function(result, status) {
							console.log(result);
							console.log(status);
							if (result === 1) {
								console.log('Websocket msg 저장성공!');
							}
						}, // end success
						error : function(result, status) {
							console.log('result : ' + result);
							console.log('status : ' + status);
						} // end error()
					}); // end ajax send
				}); // end saveMsg()
				
				// ***************************************************************
				// ajax로 채팅내역 가져오기 (msg)
				function getmsg(bno) {
					console.log('getmsg() 호출');
					var msgBno = bno;
					var url = 'chat/msgall' + msgBno;
					console.log('getmsg() url : ' + url);
					$.getJSON (
							url, function(jsonData){
								console.log('받아온 json데이터 : ' + jsonData);
								var content = jsonData['msgContent'];
								var sender = jsonData['msgSender'];
								
								// msg 가공하기!
								console.log('msgSender : ' + sender + ', msgContent : ' + content);
								
								printMsg += sender + " : " + content
								
								// 채팅내역 출력
								printAllchat(printMsg);
							}); // end callback(), getJSON()
				} // end getAllchat()
				
				// *******************************************************************************
				// ajax로 채팅내역 가져오기 (room)
				function getroom() {
					console.log('getroom() 호출');
					var roomBno = '${vo.roomBno}';
					var url = 'chat/roomall' + roomBno;
					console.log('getroomt() url : ' + url);
					$.getJSON (
							url, function(jsonData){
								console.log('받아온 json데이터 : ' + jsonData);
								var msg = jsonData['roomContent'];
								
								// msg 가공하기!
								console.log('roomContent : ' + msg);
								
								// roomContent는 메시지bno들이 넘어올예정 > msg
								// TODO : msgBno로 msgContent를 가져올수 있는 메소드를 작성!
								var msgBnos[] = msg.split(',');
								for (var i = 0; i < msgBnos.length; i++){
									getmsg(msgBnos[i]);
								}
								
								// 채팅내역 출력
								printAllchat(savedMsg);
							}); // end callback(), getJSON()
				} // end getroom()
				
				// *******************************************************************************
				// ajax로 채팅내역 추가
				function setRoom() {
					console.log('setRoom() 호출');
					var roomBno = '${vo.roomBno}';
					var msg = '${msgBno}';
					
					console.log('savedMsg' + roomBno);
					
					$.ajax({
						type : 'put',
						url : 'chat/' + roomBno,
						headers : {
							'Content-Type' : 'application/json',
							'X-HTTP-Medhod-Override' : 'PUT'
						},
						data : JSON.stringify({
							'roomContent' : msg
						}),
					})
				}
				// ***********************************************
				// TODO : 새로 작성해보자!
				
				
			}); // end document.ready()
	</script>
</body>
</html>