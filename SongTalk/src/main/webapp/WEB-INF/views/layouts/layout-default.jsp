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
			<div style="float: left; width: 15%;">
				<page:apply-decorator name="menu"></page:apply-decorator>
			</div>

			<div style="border: 1px; float: right; width: 80%;">
				<decorator:body />
				
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
				</div> <!-- end chat -->
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
			getAllChat();
			
			console.log('자바스크립트가 작동하나요?');
			var savedMsg = '';
			var EnterMsg = '';
			
		  	// WebSocket
		  	var URL = window.location.host + window.location.pathname;
		  	var serverURL = URL.split("/")[0];
		  	console.log('url : ' + URL);
		  	console.log('host : ' + window.location.host);
		  	
		  	var sock = new WebSocket('ws://' + window.location.host + '/prj/studyBoard/websocket');
		  	
		  	sock.onopen = function() {
		  		console.log('websocket opened');
		  	};
		  	
		  	sock.onmessage = function (event) {
		  		// alarm
		  		if (event.data.split(',')[0] !== 'chatMsg') {
		  			console.log('알람 받음! - ' + event.data);
		  			toastr["info"](event.data);
		  		}
			  	
		  		// chat
		  		if (event.data.split(',')[0] === 'chatMsg') {
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
		  	};
		  	
			// chat function
			if ($('msgContent').val() !== ""){
				// 보내기버튼 활용
				$('#msg_send').click(function chatMessage(msgForSave) {
			  		if ($('#msgContent').val() !== ""){
			  			// 메시지 데이터
			    		// sender, content(receiver)
			    		msgSender = '${loginId}';
			    		console.log('message sending!');
			    		cmd = 'chatMsg';
						msgReceiver = $('#msgContent').val();	// msgReceiver > 내용
						message = cmd + '*' + msgReceiver + '*' + msgSender + '*aa*aa';
						console.log('message = ' + message.data);
						sock.send(message);	
			  		} else {
			  			console.log('채팅내용 없음');
			  		}
		    	});
				
				 // 엔터키 활용
				 $('#msgContent').keydown(function(key, msgForSave){
					if (key.keyCode == 13) {
						console.log('엔터키 눌림');
						chatMessage(EnterMsg);
						console.log('엔터로 chatMessage() 작동');
					} 
				 });
			}
		  	
			function chatMessage(msgForSave) {
		  		if ($('#msgContent').val() !== ""){
		  			// 메시지 데이터
		    		// sender, content(receiver)
		    		msgSender = '${loginId}';
		    		console.log('message sending!');
		    		cmd = 'chatMsg';
					msgReceiver = $('#msgContent').val();	// msgReceiver > 내용
					message = cmd + '*' + msgReceiver + '*' + msgSender + '*aa*aa';
					console.log('message = ' + message.data);
					sock.send(message);	
		  		} else {
		  			console.log('채팅내용 없음');
		  		}
	    	}
		  	
		  	sock.onclose = function (event) {
		  		console.log('websocket closed : ' + event);
		  	};
			
		  	
		  	// ***************************************************************************
		  	
			$('#chat').hide();
			$('#chatClose').hide();
			$('#chatTitle').hide();
		  	
		  	// ***************************************************************************
		  	
		  	// ajax로 채팅내역을 저장시키자
		  	/*function saveChat(msgForSave) {
		  		console.log('saveChat() 호출');
		  		// chatBno / chatContent / chatSender
		  		// msgForSave - 보내는사람 : 메시지
		  		console.log('aaaaaaaaaa 받아온 메시지! : ' + msgForSave);
		  		
		  		savedMsg += msgForSave + '*';
		  		var chatContent = savedMsg;
		  		var chatSender = '${loginId}';
		  		
		  		console.log('chat content : ' + chatContent);
		  		
		  		var chatObj = {
		  				'chatContent' : chatContent,
		  				'chatSender' : chatSender
		  		};
		  		console.log(JSON.stringify(chatObj));
		  		
		  		// ajax데이터 보내기
		  		$.ajax({
		  			type : 'post',
		  			url : 'chat',
		  			headers : {
		  				'Content-Type' : 'application/json',
		  				'X-HTTP-Method-Override' : 'POST'
		  			},
		  			data : JSON.stringify(chatObj),
		  			success : function(result, status) {
		  				console.log(result);
		  				console.log('status : ' + status);
		  				if (result == 1) {
		  					console.log('WebSocket Msg 저장 성공!');
		  					
		  				}
		  			}, // end success
		  			error : function(result, status) {
		  				console.log('result : ');
		  				console.log(result);
		  				console.log('status : ' + status);
		  			} // end error()
		  		}); // end ajax send
		  	} // end saveChat() */
		  	
		  	// ajax로 채팅내역을 가져오자!
		  	function getAllChat() {
		  		console.log('getAllchat() 호출');
		  		var chatBno = '${chatBno}';		// TODO : session으로 chatBno 받아오기
		  		var url = 'chat/all/' + chatBno;
		  		console.log('getAllchat() url : ' + url);
		  		$.getJSON(
		  				url,
		  				function(jsonData) {
		  					console.log('받아온 json데이터 : ' + jsonData);
			  				var msg =  jsonData['chat_content'];
			  				// msg 가공하기!
			  				console.log('>>>>>>>>>> msg : ' + JSON.stringify(jsonData));
			  				console.log('chatContent : ' + jsonData['chat_content']);
			  				console.log('chatContent*** : ' + msg);
			  				
			  				savedMsg = msg.split(':');
			  				
			  				// 채팅내역 출력!
			  				printAllChat(savedMsg);
			  				
		  				}); // end callback(), getJSON()
		  	} // end getAllChat()
		  	
		  	// ajax로 채팅내역 추가!
		  	function setAllchat(msgForSave) {
		  		console.log('setAllChat() 호출');
		  		var chatBno = '${chatBno}';
		  		savedMsg += msgForSave + ":";
		  		console.log('xxxxxxxxxxxxx ' + savedMsg);
		  		
		  		$.ajax({
		  			type : 'put',
		  			url : 'chat/' + chatBno,
		  			headers : {
		  				'Content-Type' : 'application/json',
		  				'X-HTTP-Method-Override' : 'PUT'
		  			},
		  			data : JSON.stringify({
		  				'chat_content' : savedMsg,
		  				'chat_userid' : '${loginId}'
		  			}),
		  			success : function(result) {
		  				if (result === 'success') {
		  					console.log('socketMessage 수정 성공!');
		  				}
		  			} // end success()
		  		}) // end ajax()
		  	} // end setAllchat()
		  	
		  	// 채팅내역 출력하는 메소드!
		  	function printAllChat(savedMsg) {
		  		console.log('printAllChat() 호출');

		  		console.log('savedMsg[0] : ' + savedMsg[0]);
		  		console.log('savedMsg length : ' + savedMsg.length);
	  			const chat = document.getElementById('chatBlock');
		  		
		  		for (var i = 0; i < savedMsg.length - 1; i++) {
  					console.log('test[' + i + '] = ' + savedMsg[i]);
  					var chatRSender = savedMsg[i].split(' ^ ')[0];
  					var chatRContent = savedMsg[i].split(' ^ ')[1];
  					
  					if (i == 0) {
  						var msg = savedMsg[0].split(',');
  						for (var j = 0; j < msg.length; j++) {
  							var chatSSender = msg[j].split(' ^ ')[0];
  							console.log('chatSSender : ' + chatSSender);
  							var chatSContent = msg[j].split(' ^ ')[1];
  							console.log('chatSContent : ' + chatSContent);
  							
  							if (msg[i] !== null){
  	  							if (chatSSender === ' ' + '${loginId}' || chatSSender === '${loginId}') { // 
  	  								console.log('내가 보낸 메시지 : ' + chatSContent);
  	  								chat.innerHTML += '<p id="sentMsg" style="background:lightGrey; text-color:white; text-align:right;">' + chatSContent + '</p>';
  	  								
  	  								// 스크롤바 자동으로 내리기
  	  							  	$('#chatBlock').scrollTop($('#chatBlock')[0].scrollHeight);
  	  							} else {
  	  								console.log('남이 보낸 메세지 : ' + chatSContent);
  	  								chat.innerHTML += '<p id="receivedMsg" style="text-align:left">' + chatSSender + ' : ' + chatSContent + '</p>';
  	  								
  	  								// 스크롤바 자동으로 내리기
  	  							  	$('#chatBlock').scrollTop($('#chatBlock')[0].scrollHeight);
  	  							}
  	  							
  	  							console.log('sender : ' + chatSSender + ' , content : ' + chatSContent);
  	  						}
  						}
  						
  					} else {
  						if (savedMsg[i] !== null){
  							if (chatRSender === '${loginId}') { // 
  								console.log('내가 보낸 메시지 : ' + chatRContent);
  								chat.innerHTML += '<p id="sentMsg" style="background:lightGrey; text-color:white; text-align:right;">' + chatRContent + '</p>';
  								
  								// 스크롤바 자동으로 내리기
  							  	$('#chatBlock').scrollTop($('#chatBlock')[0].scrollHeight);
  							} else {
  								console.log('남이 보낸 메세지 : ' + chatRContent);
  								chat.innerHTML += '<p id="receivedMsg" style="text-align:left">' + chatRSender + ' : ' + chatRContent + '</p>';
  								
  								// 스크롤바 자동으로 내리기
  							  	$('#chatBlock').scrollTop($('#chatBlock')[0].scrollHeight);
  							}
  							
  							console.log('sender : ' + chatRSender + ' , content : ' + chatRContent);
  						}
  	  				}
  	  				
  				} // end for
  					
		  	} // end printAllChat()
		  	
		  	// **************************************************************

			printAllChat(savedMsg);
		  	

	    	var msgSender = '${loginId}';
	    	var msgBnoSeq = '${studyVO.study_bno}';
	    	var msgPageSeq = '${page}';
		  	
		  	
			
		  	
		  	
	  	}); // end document
	  	
		  	// 채팅창 popup 실행
		  	function chat(){
				
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
			
			// frameset 닫기 버튼
			function frameclose() {
				$('#chat').hide();
				$('#chatClose').hide();
				$('#chatTitle').hide();
			}
			/*
			function messagingOK() {
	    		console.log('btn_crew_attend pushed!');
	    		cmd = 'attendOK';
	    		msgReceiver = $('#crewUser').val();
	    		message = cmd + '*' + msgReceiver + '*' + msgSender + '*' + msgBnoSeq + '*' + msgPageSeq;
	    		sock.send(message);
	    	};
	    	*/
	    	function messagingNO() {
	    		console.log('btn_crew_reject pushed!');
	    		var reason = $('#reason').val();
	    		cmd = 'attendNO';
	    		msgReceiver = $('#crewUser').val();
	    		message = cmd + '*' + msgReceiver + '*' + msgSender + '*' + msgBnoSeq + '*' + msgPageSeq + '*' + reason;
	    		sock.send(message);
	    	};
	    	
	    	function messageSend() {
				console.log('btn_crew_attend to wait pushed!');
				cmd = 'attend';
				msgReceiver = '${studyVO.study_userid}';
				msgSender = '${loginId}';
		    	msgBnoSeq = '${studyVO.study_bno}';
		    	msgPageSeq = '${page}';
		    	
		    	message = cmd + '*' + msgReceiver + '*' + msgSender + '*' + msgBnoSeq + '*' + msgPageSeq;
	    		sock.send(message);
			};
	    	
	    	
	    	$('#ask-reject').click(function() {
	    		// 거절 버튼이 눌리면 사유를 선택할수 있게 보여준다.
	    		var added = '<label><input type="text" id="reason" placeholder="사유를 입력하세요" value="" />';
	    		const reasonPart = document.getElementById('reasonPartion');
	    		reasonPart.innerHTML = added;
	    		$('#btn_crew_delete').show();
	    		$('#ask-reject').hide();
	    	});
			
	</script>
</body>
</html>