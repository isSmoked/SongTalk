<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	
<style type="text/css">
.menu {
color: black; 
text-decoration: none;
text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);
}
</style>
	<c:set var="URL" value="${pageContext.request.requestURL}" />
	<c:if test="${URL eq 'http://localhost:8082/songtalk/member/HOME' }">
	<!-- TODO : member/HOME과 chat/... 에서 보이도록 설정하기 -->
	<h2>보이나용</h2>
	
	<!-- 글 작성 버튼 추가하기! -->
	
	<table id="List">
		<tbody>
			<c:forEach items="${roomList }" var="vo">
			<tr>
				<td>
					<a href="/.../songtalk/chat/detail?bno=${vo.roomBno }">
						${vo.roomTitle }
						<c:set var="attendant" value="${fn:split(vo.roomUser, ',') }"></c:set>
						<c:forEach var="users" items="${attendant }">
							${users }&nbsp;&nbsp;&nbsp;
						</c:forEach>
					</a>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	</c:if>
	