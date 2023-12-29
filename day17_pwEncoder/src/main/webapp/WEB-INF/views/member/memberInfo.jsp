<%@page import="kr.ezen.pwEncoder.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>	

<%
	MemberDTO dto 
	  = (MemberDTO)request.getAttribute("dto");
%>    
                                         
<div class="container w-50 mt-5 p-5 shadow border">
	<form action="memberUpdate.do" method="post">                                               
		<h3 class="text-center">회원 정보</h3>         
	 	<input type='hidden' name='no' value='${dto.getNo()}'>                                               
			<div class="mt-5 mb-3 text-end">                                        
					<b>${dto.getName()} 님의 회원정보</b>                                                        
			</div>
			<div class="mb-3">
		         <lable for="no">회원번호 (수정불가)</lable>
		         <input type="text" class="form-control" id="no" name="no" value="${dto.no}" readonly/>
	      	</div>                                                                            
			<div class="mb-3">
		         <lable for="id">아이디 (수정불가)</lable>
		         <input type="text" class="form-control" id="id" name="id" value="${dto.id}" readonly/>
	      	</div>
	      	<div class="mb-3">
		         <lable for="pw">비밀번호</lable>
		         <input type="password" class="form-control" id="pw" name="pw" value="${dto.pw}"/>
	      	</div>
<%-- 	      	<div class="mb-3">
		         <lable for="pwConfirm">비밀번호 확인</lable>
		         <input type="password" class="form-control" id="pwConfirm" name="pwConfirm" value="${dto.pw}"/>
	      	</div> --%>
	      	<div class="mb-3">
		         <lable for="name">이름</lable>
		         <input type="text" class="form-control" id="name" name="name" value="${dto.name}"/>
	      	</div>
	      	<div class="mb-3">
		         <lable for="age">이름</lable>
		         <input type="text" class="form-control" id="age" name="age" value="${dto.age}"/>
	      	</div>
	      	<div class="mb-3">
		         <lable for="tel">전화번호</lable>
		         <input type="text" class="form-control" id="tel" name="tel" value="${dto.tel}"/>
	      	</div>
	      	<div class="mb-3">
		         <lable for="email">이메일 (수정불가)</lable>
		         <input type="text" class="form-control" id="email" name="email" value="${dto.email}" readonly/>
	      	</div>
	      	
	   	<div class="text-center mt-3"><br>
			<input type='submit' value='수정하기' class='btn btn-primary'> 
			<input type='reset' value='취소' class='btn btn-warning'>      
			<a href='memberList.do' class='btn btn-info'>리스트</a>
      	</div>                                                             
	</form>                                                 
</div>    
                                                    
<%@ include file="../include/footer.jsp" %>