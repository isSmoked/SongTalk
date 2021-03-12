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
		<a href="/songtalk/chat/allDetail" class="list-group-item" style="background-color:grey; border-color:grey; color:black; ">
			전체채팅&nbsp;&nbsp;&nbsp;	
			<span class="badge" style="background-color:black; color:white;">14</span>
		</a>
		
		<!-- 대화방채팅 -->
		<c:forEach items="${roomList }" var="vo">
			<a href="/songtalk/chat/detail?bno=${vo.roomBno }" class="list-group-item">
				${vo.roomTitle }
				<c:set var="attendant" value="${fn:split(vo.roomUser, ',') }"></c:set>
				<c:forEach var="users" items="${attendant }">
					${users }&nbsp;&nbsp;&nbsp;<span class="badge" style="background-color:black;">14</span>
				</c:forEach>
			</a>
		</c:forEach>
	</div>
	
	</c:if>
	

</body>
</html>	