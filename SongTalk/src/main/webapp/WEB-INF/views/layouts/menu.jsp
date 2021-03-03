<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Toastr -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
	
<style type="text/css">
.menu {
color: black; 
text-decoration: none;
text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);
}
</style>
	
	
	<%-- 로그인&회원가입 --%>
	<c:if test="${empty loginId}">
	<button class="btn btn-dark" type="button" id="btn_join">회원가입</button><br><br>
	<button class="btn btn-dark" type="button" id="btn_login">로그인</button><br>
	</c:if>
	
	<c:if test="${not empty loginId}">
		<h5>${loginId}님 환영합니다.</h5>
		<h6>
			<c:if test="${part eq 'personal' }">개인회원</c:if>
			<c:if test="${part eq 'company' }">기업회원</c:if>
			<c:if test="${part eq 'manager' }">관리자</c:if>
		</h6>
		<br>
			<button class="btn btn-dark" type="button" id="btn_logout">로그아웃</button>
		<br>
		<br>
		<br>
	</c:if>
	
	<%-- 게시판 --%>
	<c:if test="${part eq 'personal' }">
	<p>
		<a href="/prj/RecBoard/recruits" class="menu">구인게시판</a>
	</p>
	<p>
		<a href="/prj/EmpBoard/employees" class="menu">구직게시판</a>
	</p>
	<p>
		<a href="/prj/studyBoard/list" class="menu">스터디게시판</a>
	</p>
	<P>
		<a href="/../prj/freeboard/list" class="menu">자유게시판</a>
	</P>
	<P>
		<a href="/../prj/qaboard/list" class="menu">질문게시판</a>
	</P>
	<P>
		<a href="/../prj/shareboard/list" class="menu">공유게시판</a>
	</P>
	<br>
	<p>
		<a href="/../prj/bookmark/list" class="menu">찜 목록</a>
	</p>
	</c:if>

	<%-- 회원정보 --%>
	<c:choose>
		<c:when test="${part eq 'personal' }">
			<p>
				<a href="/../prj/member/detail-personal" class="menu">개인회원정보</a>
			</p>
		</c:when>
		<c:when test="${part eq 'company' }">
			<p>
				<a href="/../prj/member/detail-company" class="menu">기업회원정보</a>
			</p>
		</c:when>
		<c:when test="${part eq 'admin' }">
			<p>
				<a href="/../prj/manager/member-list" class="menu">관리자정보</a>
			</p>
		</c:when>
	</c:choose>
	
	<input type="hidden" id="loginId" value="${loginId }">
	<input type="hidden" id="login" value="${loginResult }">
		
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
					
	/* 로그인&로그아웃 성공시 알람 */					
	result();		
	function result(){
		var loginResult = $('#login').val();
		if (loginResult === 'success'){
			toastr["success"]("로그인 되었습니다.");
			// 세션 loginResult 복구
			<%session.removeAttribute("loginResult"); %>
		} else if (loginResult === 'logout'){
			toastr["info"]("로그아웃 되었습니다.");
			// 세션 loginResult 복구
			<%session.removeAttribute("loginResult"); %>
		}
	} // resultAlert()
	
	$(document).ready(function() {
		/* 로그인 버튼 */
		$('#btn_login').click(function() {
			var target = encodeURI('/prj/member/login?url=' + location.href);
			location = target;
		});
		
		/* 로그아웃 버튼 */
		$('#btn_logout').click(function() {
			var id = $('#loginId').val();
			if (id != ""){
				if (confirm("로그아웃 하시겠습니까?")){
					var target = encodeURI('/../prj/member/logout');
					location = target;
				}
			}
		});
		
		/* 회원가입 버튼 */
		$('#btn_join').click(function() {
			var target = encodeURI('/../prj/member/register');
			location = target;
			});
		});

	</script>