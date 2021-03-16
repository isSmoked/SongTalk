<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- Jquery 3.5.1 버전 -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS 4.5 버전 -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">-->
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
<nav class="navbar navbar-expand-lg navbar-dark bg-danger fixed-top">
  <a class="navbar-brand" href="/songtalk/" style="font-size:25px;">Song Talk</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <c:if test="${loginId eq null }">
	    <li class="nav-item">
	      <a class="nav-link">로그인하세요!</a>
	    </li>
      </c:if>
      <c:if test="${loginId ne null }">
        <li class="nav-item">
	      <a class="nav-link">${loginId }님 환영합니다!</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="member/logout"><button class="btn btn-danger">로그아웃</button></a>
	    </li>
      </c:if>
      
      
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
