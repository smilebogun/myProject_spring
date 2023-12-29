<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Board</title>
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  										<!-- Ajax -->
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
  										<!-- 폰트어썸 -->
  	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
  	<!-- bootstrap -->       
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet"/>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- css폴더에서 main.css 색상정하기 : css customize를 하려면 가장 밑에 bootstrap 밑에 적기 -->
	<link href="<c:url value="resources/css/main.css"/>" rel="stylesheet"/>
</head>
<body>
<!-- <header> -->

		<div class="container mt-5 mb-3">
			<h3>ACADEMY</h3>
		</div>
									<!-- sticky-top : 스티키 옵션, <body> 안에 <header>를 빼줘야함 -->
		<!-- <nav class="navbar navbar-expand-sm bg-dark navbar-dark sticky-top"> -->
		<nav class="navbar navbar-expand-sm sticky-top">  <!-- css폴더에서 main.css 색상정하기 <head>에 link 넣어주기 -->
		  <div class="container">
		    <ul class="navbar-nav w-100"><!--  -->
		      <li class="nav-item">
		        <a class="nav-link" href="<c:url value="/"/>">Home</a> <!-- "nav-link active" 삭제 -->
		      </li>
		     <li class="nav-item">
		        <a class="nav-link" href="<c:url value="memberRegister.do"/>">회원등록</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="<c:url value="memberList.do"/>">회원리스트</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="<c:url value="fileUpload.do"/>">파일업로드</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="<c:url value="boardList.do"/>">Board</a>
		      </li>
		      
		      <li class="nav-item ms-auto d-flex"><!-- 부모 li의 w-100을 줘야지 ms-auto가 먹음 -->
			      <c:if test="${sessionScope.loginDTO.id == null}">
				      <a class="nav-link btn btn-sm btn-outline-light login" href="<c:url value="/memberLogin.do"/>">로그인</a>&nbsp;&nbsp;
				      <a class="nav-link btn btn-sm btn-outline-light register" href="<c:url value="/memberRegister.do"/>">회원가입</a>
			      </c:if>
		      </li>
		      
		      <c:if test="${sessionScope.loginDTO.id != null}">
			      <li class="nav-item ms-auto d-flex"><!-- 부모 li의 w-100을 줘야지 ms-auto가 먹음 -->
			      	<a class="me-3 myProfile" type="button" href="<c:url value="/myProfile.do"/>"><i class="fa fa-user-circle"></i> ${sessionScope.loginDTO.id} 님</a>
			        <a class="nav-link btn btn-sm btn-outline-light login" href="<c:url value="javascript:logout()"/>">로그아웃</a>
			      </li>
		      </c:if>     
		      
		    </ul>
		  </div>
		</nav>
		
		<script>
		
			function logout(){
				location.href="<c:url value="memberLogout.do"/>";
			}
		
		</script>
		
<!-- </header> -->