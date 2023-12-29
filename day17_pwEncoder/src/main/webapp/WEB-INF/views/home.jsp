<%-- <%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="include/header.jsp" %>

<div class="container mt-5">
		
		<!-- Carousel -->
	<div id="demo" class="carousel slide" data-bs-ride="carousel">
	
	  <!-- Indicators/dots -->
	  <div class="carousel-indicators">
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="4"></button>
	    
	  </div>
	
	  <!-- The slideshow/carousel -->
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="resources/imgs/1.jpg" alt="Los Angeles" class="d-block w-100">
			  <div class="carousel-caption">
			    		<h3>Los Angeles</h3>
			    	<p>We had such a great time in LA!</p>
			  </div>
	    </div>
	    <div class="carousel-item">
	      <img src="resources/imgs/2.jpg" alt="Chicago" class="d-block w-100">
			  <div class="carousel-caption">
			    		<h3>Los Angeles</h3>
			    	<p>We had such a great time in LA!</p>
			  </div>
	    </div>
	    <div class="carousel-item">
	      <img src="resources/imgs/3.jpg" alt="New York" class="d-block w-100">
			  <div class="carousel-caption">
			    		<h3>Los Angeles</h3>
			    	<p>We had such a great time in LA!</p>
			  </div>
	    </div>
	    <div class="carousel-item">
	      <img src="resources/imgs/4.jpg" alt="Seoul" class="d-block w-100">
			  <div class="carousel-caption">
			   		 	<h3>Los Angeles</h3>
			    	<p>We had such a great time in LA!</p>
			  </div>
	    </div>
	    <div class="carousel-item">
	      <img src="resources/imgs/5.jpg" alt="Busan" class="d-block w-100">
		      <div class="carousel-caption">
		    		<h3>Los Angeles</h3>
		    	<p>We had such a great time in LA!</p>
		 	 </div>
	    </div>
	  </div>
	
	  <!-- Left and right controls/icons -->
	  <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </button>
	</div>
	
</div>

<%@ include file="include/footer.jsp" %>