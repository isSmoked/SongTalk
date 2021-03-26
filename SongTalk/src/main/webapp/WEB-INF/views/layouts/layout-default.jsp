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
				var bno = $('#bno').val(); // 번호
				var beforeMsg = "";			// 이전 저장되어 있던 msgbno에 추가해서 저장할 것이다.
											// saveMsg에서 저장된 msg의 bno를 따와서 
				
											
				getroom(); // 처음 실행시 채팅방의 내역을 보내준다.
				getall();  // 처음 실행시 전체채팅의 내역을 보내준다.
				var title = '${roomVO.roomTitle}';
				
				console.log('layout - 자바스크립트가 작동하나요?');
				var printMSG = '';
				
				// WEBSOCKET ---------------------------------------------------------
				var sock = new WebSocket('ws://' + window.location.host + '/songtalk/chat/websocket');
				
				sock.onopen = function() {
					console.log('websocket opened');
				}
				
				// 수신
				sock.onmessage = function (event) {
					var message = event.data.split('[*]');
					var cmd = message[0];
					var caller = message[1];
					var receiver = message[2];	// 메시지를 받을 사람인데 필요가 없다
					var title = message[3];
					var content = message[4];
					
					if (cmd === 'roomCHAT'){ // 대화방채팅
						getRoom();
					} else if (cmd === 'allCHAT') { // 전체채팅
						
					}
					
				}
				
				sock.onclose = function (event) {
					console.log('websocket closed : ' + event);
				}
				
				// 발신 
				
				// room chat function
				if ($('roommsgContent').val() !== ""){
					// 보내기버튼 활용
					$('#roommsg_send').click(function chatMessage(msgForSave) {
				  		
			  			// 메시지 데이터 
			  			// cmd, caller, receiver, title, content
			  			var cmd = 'roomCHAT';
			  			var caller = '${loginId}';
			  			var receiver = '${roomVO.roomUser}'; // TODO : 채팅방유저 split 구현하고 오기
			  			var title = '${roomVO.roomTitle}';
			  			var content = $('#roommsgContent').val();
			  			
			  			var message = cmd + '*' + caller + '*' + receiver + '*' + title + '*' + content; 
			  			console.log('보내는 메세지 : ' + message);
			  			
						saveMsg(message); // 메세지 저장
			    	});
					
				}
				
				// all chat function
				if ($('allmsgContent').val() !== "") {
					$('#allmsg_send').click(function chatMessage(msgForSave) {
						
			  			// 메시지 데이터 
			  			// cmd, caller, receiver, title, content
			  			var cmd = 'allCHAT';
			  			var caller = '${loginId}';
			  			var receiver = ' '; // TODO : 채팅방유저 split 구현하고 오기
			  			var title = ' ';
			  			var content = $('#allmsgContent').val();
			  			
			  			var message = cmd + '*' + caller + '*' + receiver + '*' + title + '*' + content; 
			  			console.log('보내는 메세지 : ' + message);
			  			
						saveAllMsg(message); // 메세지 저장
					});
					
				}
				// ******************************************************************************
				// 전체채팅 저장
				function saveAllMsg(message) {
					var content = $('#allmsgContent').val();
					
					var obj = {
							'allContent' : content,
							'allSender' : '${loginId}'
					}
					console.log(obj);
					
					$.ajax({
						type : 'post',
						url : '/songtalk/chat/achat',
						headers : {
							'Content-Type' : 'application/json',
							'H-HTTP-Method-Override' : 'POST'
						},
						data : JSON.stringify(obj),
						success : function(result, status) {
							console.log(result);
							console.log(status);
							if (result == 1) {
								sock.send(message);
								console.log('Websocket all msg 저장성공!');
							}
						}, // end success
						error : function(result, status) {
							console.log('result : ' + result);
							console.log('status : ' + status);
						} // end error()
					}); // end ajax send
					
					getall();
				} // end saveAllMsg()
				
				// *******************************************************************************
				// ajax로 전체채팅내역 가져오기 (all)
				function getall() {
					var url = 'achat/all/' + bno;
					console.log('url : ' + url);
					$.getJSON (
							url, 
							function(jsonData){
								console.log('받아온 json데이터 : ' + jsonData);
								var list = '';
								const chat = document.getElementById('allchatBlock');
								chat.innerHTML = '';
									
								$(jsonData).each(function() {
									var content = this.allContent;
									var sender = this.allSender;
									
									if (sender === '${loginId}') { // 내 메시지
										chat.innerHTML += '<p id="sentMsg" style="background:lightGrey; text-color:white; text-align:right; font-size:15px;">' + content + '&nbsp;&nbsp;&nbsp;' + '</p>';
							  			console.log('sent message');
							  			
									} else if (sender !== '${loginId}') { // 내 메시지가 아닐때
										chat.innerHTML += '<p id="receivedMsg" style="text-align:left; font-size:15px;">' + sender + ' : ' + content + '</p>';
						  				console.log('received message');
									}	
									
									$('#allchatBlock').scrollTop = $('#allchatBlock').scrollHeight;
									$('#allmsgContent').val('');
								});
								
							}); // end callback(), getJSON()
				} // end getroom()
				
				
				// *******************************************************************************
				// ajax로 message 저장 (msg) .1
				function saveMsg(message) {
					console.log('1. message save!')
					var content = $('#roommsgContent').val();
					// 게시판 번호를 받아온다!
					var roomBno = '${roomVO.roomBno}';
					
					var obj = {
							'msgSender' : '${loginId}',
							'msgContent' : content,
							'msgRoom' : roomBno
						};
					
					console.log(obj);
					$.ajax({
						type : 'post',
						url : '/songtalk/chat/tchat',
						async : false,
						headers : {
							'Content-Type' : 'application/json',
							'H-HTTP-Method-Override' : 'POST'
						},
						data : JSON.stringify(obj),
						success : function(result, status) {
							console.log(result);
							console.log(status);
							
							// result == 1 삭제
							sock.send(message);	
							console.log('Websocket msg 저장성공!');
							setRoom();
							
							
						}, // end success
						error : function(result, status) {
							console.log('result : ' + result);
							console.log('status : ' + status);
						} // end error()
					}); // end ajax send
				} // end saveMsg()
				
				
				// *******************************************************************************
				// ajax로 채팅내역 추가 .2
				function setRoom() {
					console.log('2. room save!');
					var roomBno = '${roomVO.roomBno}';
					var msg = '${msgBno}';
					
					console.log('savedMsg 저장될 채팅방 : ' + roomBno);
					console.log('저장된 메시지 : ' + msg);
					
					
					var url = '/songtalk/chat/tchat/roomall/' + roomBno;
					console.log('getroom() url : ' + url);
					$.getJSON (
							url, function(jsonData){
								console.log('받아온 json데이터 : ' + jsonData);
								var msg = jsonData['roomContent'];
								
								console.log('roomContent : ' + msg); // 가져온 채팅내역
								
								$.ajax({
									type : 'put',
									url : '/songtalk/chat/tchat/' + roomBno,
									headers : {
										'Content-Type' : 'application/json',
										'X-HTTP-Medhod-Override' : 'PUT'
									},
									data : JSON.stringify({
										'roomContent' : msg
									}),
									success : function(result) {
										console.log("2. result success : " + result);
										
										// 3. getroom 호출
										getroom();
									},
									error : function (result) {
										console.log("2. result error : " + result);
									}
								})
								
							}); // end callback(), getJSON()
							
					
				}
				
				// *******************************************************************************
				// ajax로 채팅내역 가져오기 (room) .3
				function getroom() {
					console.log('3. room get!')
					var roomBno = '${roomVO.roomBno}';
					var url = '/songtalk/chat/tchat/roomall/' + roomBno;
					console.log('getroom() url : ' + url);
					$.getJSON (
							url, function(jsonData){
								console.log('받아온 json데이터 : ' + jsonData);
								var msg = jsonData['roomContent'];
								
								// msg 가공하기!
								console.log('roomContent : ' + msg);
								
								// roomContent는 메시지bno들이 넘어올예정 > msg
								// TODO : msgBno로 msgContent를 가져올수 있는 메소드를 작성!
								var msgBnos = msg.split(',');
								for (var i = 0; i < msgBnos.length; i++){
									getmsg(msgBnos[i]);
									console.log('getmsg : ' + msgBnos[i]);
								}
								
								// 채팅내역 출력
								
								
							}); // end callback(), getJSON()
				} // end getroom()

				// ***************************************************************
				// ajax로 채팅내역 가져오기 (msg) .4
				function getmsg(bno) {
					console.log('4. message get!')
					var msgBno = bno;
					var url = 'tchat/msgall/' + msgBno;
					
					const chat = document.getElementById('roomchatBlock');
					chat.innerHTML = "";
					
					console.log('getmsg() url : ' + url);
					$.getJSON (
							url, function(jsonData){
								console.log('받아온 json데이터 : ' + jsonData);
								var content = jsonData['msgContent'];
								var sender = jsonData['msgSender'];
								
								// msg 가공하기!
								console.log('msgSender : ' + sender + ', msgContent : ' + content);
								
								printMSG += sender + " : " + content;
								
								// cmd = roomCHAT 지움
								if (title === '${roomVO.roomTitle}') {	// 해당 대화방에만 메시지 출력
									
									// caller + content
									if (sender === '${loginId}') { // 내 메시지
										chat.innerHTML += '<p id="sentMsg" style="background:lightGrey; text-color:white; text-align:right; font-size:15px;">' + content + '&nbsp;&nbsp;&nbsp;' + '</p>';
							  			console.log('sent message');
							  			
									} else if (sender !== '${loginId}') { // 내 메시지가 아닐때
										chat.innerHTML += '<p id="receivedMsg" style="text-align:left; font-size:15px;">' + sender + ' : ' + content + '</p>';
						  				console.log('received message');
									}	
									$('#roomchatBlock').scrollTop = $('#roomchatBlock').scrollHeight;
									$('#roommsgContent').val('');
								}
								
								// 채팅내역 출력
								/*printAllchat(printMSG);*/
								
							}); // end callback(), getJSON()
				} // end getAllchat()
				
				// *************************************************************
				
				// ***********************************************
				/*function printAllchat(printMSG) {
					printMSG = '';
					if (cmd === 'roomCHAT'){ // 대화방 채팅
						if (title === '${vo.roomTitle}') {	// 해당 대화방에만 메시지 출력
							const chat = document.getElementById('roomchatBlock');
							// caller + content
							if (caller === '${loginId}') { 		  // 내 메시지
								chat.innerHTML += '<p id="sentMsg" style="background:lightGrey; text-color:white; text-align:right; font-size:20px;">' + content + '</p>';
					  			console.log('sent message');
							} else if (caller !== '${loginId}') { // 내 메시지가 아닐때
								chat.innerHTML += '<p id="receivedMsg" style="text-align:left; font-size:20px;">' + caller + ' : ' + content + '</p>';
				  				console.log('received message');
							}
							$('#roomchatBlock').scrollTop = $('#roomchatBlock').scrollHeight;
							$('#roommsgContent').val('');
						}
					} 
				} // end printAllchat()*/


				
			}); // end document.ready()
	</script>
</body>
</html>