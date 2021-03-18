<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<!-- 합쳐지고 최소화된 최신 CSS 4.5 버전 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
	<!-- JS와 번들 -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
	<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js"></script>
	<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js"></script>
</head>

	
<style type="text/css">
.menu {
color: black; 
text-decoration: none;
text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);
}
</style>
<body>

	<c:set var="wer" value="${pageContext.request.requestURL}" />
		<label>${wer }</label>
	<c:set var="target" value="${fn:split(wer, '[/]')}" />
		
	<c:if test="${target[3] eq 'chat' }">
	<!-- TODO : member/HOME과 chat/... 에서 보이도록 설정하기 -->
	<h2>&nbsp;&nbsp;&nbsp;채팅방 목록</h2>
	<h2>&nbsp;</h2>
	<!-- TODO : DB 추가해서 test해보기 -->
	
	<!-- 글 작성 버튼 추가하기! -->
	
	
	<!-- test -->
	<div class="list-group">
		<!-- 전체채팅 -->
		<a href="/songtalk/chat/allDetail" class="list-group-item bg-danger text-light" style="height:50px; font-size:20px;">
			전체채팅&nbsp;&nbsp;&nbsp;	
			<span class="badge text-danger" style="background-color:white;">14</span>
		</a>
		
		<!-- 대화방채팅 -->
		<div id="roomList">
			
		</div>
		
		<!-- 대화방 추가 -->
		<c:if test="${target[4] ne 'register' }">
			<a href="/songtalk/chat/register" class="list-group-item bg-white text-danger" style="height:50px; font-size:20px;">
				<span class="glyphicon glyphicon-plus" aria-hidden="true">   대화방생성 </span>
			</a>
		</c:if>
	</div>
	
	</c:if>
	
	<script type="text/javascript">
		$(document).ready(function() {
			getRoomList();
			function getRoomList() {
				var userid = '${loginId}';
				var url = 'list/all/' + userid;
				console.log('url : ' + url);
				$.getJSON(url, function(jsonData){
					const list = document.getElementById('roomList');
					list.innerHTML = '';
					
					console.log(jsonData);
					$(jsonData).each(function(){
						// title, userid
						var title = this.roomTitle;
						var user = this.roomUser;
						var content = this.roomContent;
						var bno = this.roomBno;
						console.log('title : ' + title + ', user : ' + user);
						
						list.innerHTML += '<a href="roomDetail?bno=' + bno + '" class="list-group-item bg-light text-danger" style="height:100px; font-size:20px; font-weight:bold;">'
										+ title + '<p style="font-size:5px;">&nbsp;</p><input type="hidden" name="roomBno" value="'+ bno + '"><p style="font-size:18px; font-weight:normal; color:grey;">' + user + '</p></a>';
						console.log('roomList!');
					}) // end json.each()
				}); // end getJSON
			}
		}); // end document.ready()
	</script>

</body>
</html>	