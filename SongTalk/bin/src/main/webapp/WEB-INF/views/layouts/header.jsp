<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- Jquery 3.5.1 버전 -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS 4.5 버전 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
<!-- JS와 번들 -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js"></script>
<style type="text/css">
body {padding-top: 100px;}
</style>
<title>메인 화면</title>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <a class="navbar-brand" href="/prj/RecBoard/main">Main</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Recruits&Emploies
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="/prj/RecBoard/recruits">Recruits</a>
          <a class="dropdown-item" href="/prj/EmpBoard/employees">Emploies</a>
          </div>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="/prj/studyBoard/list">Study</a>
      </li>
      
      <li class="nav-item">
      	<a class="nav-link" href="/prj/freeboard/list">Community</a>
      </li>
      <li class="nav-item">
      	<a class="nav-link" href="/prj/qaboard/list">Q&A</a>
      </li>
      <li class="nav-item">
      	<a class="nav-link" href="/prj/shareboard/list">Share</a>
      </li>
      <%-- <c:choose>
      <c:when test="${sessionScope.userid == null }">
      <li class="nav-item">
        <a class="nav-link mr-sm-4" href="login.do">login</a>
      </li>
      </c:when>
      <c:otherwise> --%>
      
      <c:if test="${not empty loginId }">
	      <li class="nav-item dropdown">
	        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          MyPage
	        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		        <c:if test="${part eq 'personal' }">
		          <a class="dropdown-item" href="/prj/member/detail-personal">Mypage</a>
		        </c:if>
		        
		        <c:if test="${part eq 'company' }">
		          <a class="dropdown-item" href="/prj/member/detail-company">Mypage</a>
		        </c:if>
		        
		        <c:if test="${part eq 'manager' }">
		          <a class="dropdown-item" href="/prj/member/detail-manager">Mypage</a>
		        </c:if>
		        
		          <a class="dropdown-item" href="/prj/bookmark/list">Bookmark</a>
		          
		        <c:if test="${part eq 'manager' }">
		          <a class="dropdown-item" href="/prj/manager/member-list">Member</a>
		        </c:if>
	        </div>
	      </li>
      </c:if>
      
      <%-- </c:otherwise>
      </c:choose> --%>
      
     
    <!-- Search Form -->
    </ul>
    
     
    <!-- <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form> -->
  </div>
</nav>
  
  
  </body>
  
</html>
