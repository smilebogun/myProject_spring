<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<%@ include file="../include/header.jsp" %> <!-- 한번더 밖으로 나가서 header를 불러와야함 -->

<div class="container w-50 mt-5 p-5 shadow">
	<form action="<c:url value='modifyBoard.do'/>" method="post">
		<input type="hidden" name="viewPage" value="${pDto.viewPage}"/>	<!-- Post방식으로 Get값 ${pDto.viewPage} 넘기기 -->
		<input type="hidden" name="searchType" value="${pDto.searchType}"/>
		<input type="hidden" name="keyword" value="${pDto.keyword}"/>
		<input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}"/>
      <h4 class="text-center">글 수정하기</h4><br>
      		<div class="form-group">       
      			<label for="bid">번호</label>    						<!-- disabled는 데이터가 안넘어감 // readonly 변경 -->
		 		 	<input class="form-control" type="text" id="bid" name="bid" value="${dto.bid}" readonly>
			</div><br> 
		
		    <div class="form-group">       
      			<label for="bid">제목</label>       
		  			<input class="form-control" type="text" id="subject" name="subject" value="${dto.subject}">      
	      	</div><br> 
	      	
	        <div class="form-group">       
      			<label for="bid">내용</label> 
	     			 <textarea class="form-control mt-2" name="contents" id="contents"><c:out value="${dto.contents}"/></textarea>
	      	</div><br> 
	      	
	   	  	<div class="form-group">       
      			<label for="bid">작성자</label> 
	      			<input class="form-control mt-2" type="text" id="writer" name="writer" value="${dto.writer}" disabled><br>
	      	</div><br> 
	     	
	      <div class="text-center mt-3"> 
	<!-- form 태그 안에 button은 자동으로 type="submit" 됌(생략) // id="btn-modify" 자바스크립트보다 form태그가 우선순위가 높음 -->
	         <button id="btn-modify" type="submit" class="btn btn-primary me-2">수정</button>
	         
	        			<!-- 타입을 버튼으로 해야 밑에 Script로 감 -->
	         <button id="btn-remove" type="button" class="btn btn-danger me-2">삭제</button>   
	         <button id="btn-list" type="button" class="btn btn-primary">리스트</button>    
	      </div> 
	</form>
</div>

<script>
	// JQuery 문
	
	//$("#btn-list").click(function ㅇㅇㅇ(){} ) // 이름없는 함수는 람다식으로 아래처럼 표현이 가능
	//$("#btn-list").click( () => {} ) // 람다식(=화살표 연산자) -> 아래 실제 사용법
					// (파라미터) => {리턴값, 명령코드}
					
	// id="#btn-list".click 클릭할때
	$("#btn-list").click( () => {
		location.href="<c:url value='/boardList.do?viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
	} )
	
/*  	// 수정하기
	$("#btn-modify").click( () => {
		location.href="<c:url value='/modifyBoard.do?bid=${dto.bid}'/>";
	} ) */
	
 	// 삭제하기
 	$("#btn-remove").click( () => {
		location.href="<c:url value='/removeBoard.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
	} )

</script>


<%@ include file="../include/footer.jsp" %>