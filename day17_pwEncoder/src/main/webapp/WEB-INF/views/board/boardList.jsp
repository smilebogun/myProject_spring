<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<%@ include file="../include/header.jsp" %> <!-- 한번더 밖으로 나가서 header를 불러와야함 -->

<!-- <div class="container w-75 mt-5 p-5 shadow"> -->
<div class="container mt-5">
      <h3 class="text-center">Spring Board</h3><br>   
              
                <!-- 검색 -->
              	<div>
              		<form action="boardList.do" id="searchForm" method="post">
              			<input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}"/>
	              			<div class="d-flex justify-content-center"> <!-- end 는 맨 왼쪽 -->
	              				<!-- 선택박스 -->							<!-- me-2 사이 띄기 -->
		              			<select class="form-select form-select-sm me-2" name="searchType" style="width:120px">
									 <option value="">선택</option>  
									 <option value="S" ${pDto.searchType == 'S' ? 'selected' : ''}>제목</option>  
									 <option value="C" ${pDto.searchType == 'C' ? 'selected' : ''}>내용</option>  
									 <option value="W" ${pDto.searchType == 'W' ? 'selected' : ''}>작성자</option>
									 <option value="SC" ${pDto.searchType == 'SC' ? 'selected' : ''}>제목 + 내용</option>  
									 <option value="SW" ${pDto.searchType == 'SW' ? 'selected' : ''}>제목 + 작성자</option>  
									 <option value="CW" ${pDto.searchType == 'CW' ? 'selected' : ''}>작성자 + 내용</option>  
									 <option value="SCW" ${pDto.searchType == 'SCW' ? 'selected' : ''}>제목 + 내용 + 작성자</option>  
		              			</select>
		              			<!-- 검색창 -->
		              			<input type="text" id="keword" name="keyword" placeholder="검색어 입력"
		              					style="width:300px" class="form-control rounded-0 rounded-start" value="${pDto.keyword}">
		              			<!-- 검색OK 버튼 -->
		              			<button class="btn rounded-0 rounded-end" style="background:#138499; color:white">
		              				<c:if test="${pDto.searchType == null || pDto.searchType == '' }">
		              				</c:if>
		              				<i class="fa fa-search"></i>
		              			</button>
	              			</div>
              		</form>
              	</div>
              
              <!-- 현재 페이지 / 총페이지 확인 -->
              <div class="my-3 d-flex justify-content-between">
              	<div class="ms-1">&nbsp;<b>${pDto.viewPage}</b> / ${pDto.totalPage} Pages</div>
              	
      				<!-- 게시글수 선택-->
      				<!-- 검색이 없는 경우 -->
      			<c:if test="${pDto.searchType == null || pDto.searchType == '' }">
	              	<div class="me-3">
	              		<select class="form-select form-select-sm" id="cntPerPage">
	              			<option value="5" ${pDto.cntPerPage == 5 ? 'selected' : '' }>게시글 5개</option>
	              			<option value="10" ${pDto.cntPerPage == 10 ? 'selected' : '' }>게시글 10개</option>
	              			<option value="20" ${pDto.cntPerPage == 20 ? 'selected' : '' }>게시글 20개</option>
	              			<option value="30" ${pDto.cntPerPage == 30 ? 'selected' : '' }>게시글 30개</option>
	              			<option value="50" ${pDto.cntPerPage == 50 ? 'selected' : '' }>게시글 50개</option>
	              		</select>
	              	</div>
              	</c:if>
              	      				<!-- 검색이 있는 경우 -->
              	<c:if test="${pDto.searchType != null && pDto.searchType != '' }">
	              	<div class="me-3">
						<select class="form-select form-select-sm" id="cntPerPage">
		              		<c:choose>
		              			<c:when test="${pDto.totalCnt <= 5}">
                    				<option value="5" ${pDto.cntPerPage == 5 ? 'selected': '' }>선택없음</option>
                  				</c:when>
			              		<c:when test="${pDto.totalCnt > 5 && pDto.totalCnt < 10}">
			              			<option value="5" ${pDto.cntPerPage == 5 ? 'selected' : '' }>게시글 5개</option>
			              		</c:when>
			              		<c:when test="${pDto.totalCnt > 5 && pDto.totalCnt < 20}">
			              			<option value="5" ${pDto.cntPerPage == 5 ? 'selected' : '' }>게시글 5개</option>
			              			<option value="10" ${pDto.cntPerPage == 10 ? 'selected' : '' }>게시글 10개</option>
			              		</c:when>
			              		<c:when test="${pDto.totalCnt >= 10 && pDto.totalCnt < 30}">
			              			<option value="5" ${pDto.cntPerPage == 5 ? 'selected' : '' }>게시글 5개</option>
			              			<option value="10" ${pDto.cntPerPage == 10 ? 'selected' : '' }>게시글 10개</option>
			              			<option value="20" ${pDto.cntPerPage == 20 ? 'selected' : '' }>게시글 20개</option>
			              		</c:when>
			              		<c:when test="${pDto.totalCnt >= 10 && pDto.totalCnt < 50}">
			              			<option value="5" ${pDto.cntPerPage == 5 ? 'selected' : '' }>게시글 5개</option>
			              			<option value="10" ${pDto.cntPerPage == 10 ? 'selected' : '' }>게시글 10개</option>
			              			<option value="20" ${pDto.cntPerPage == 20 ? 'selected' : '' }>게시글 20개</option>
			              			<option value="30" ${pDto.cntPerPage == 30 ? 'selected' : '' }>게시글 30개</option>
			              		</c:when>
			              		<c:otherwise>
			              			<option value="5" ${pDto.cntPerPage == 5 ? 'selected' : '' }>게시글 5개</option>
			              			<option value="10" ${pDto.cntPerPage == 10 ? 'selected' : '' }>게시글 10개</option>
			              			<option value="20" ${pDto.cntPerPage == 20 ? 'selected' : '' }>게시글 20개</option>
			              			<option value="30" ${pDto.cntPerPage == 30 ? 'selected' : '' }>게시글 30개</option>
			              			<option value="50" ${pDto.cntPerPage == 50 ? 'selected' : '' }>게시글 50개</option>
			              		</c:otherwise>
		              		</c:choose>
	              		</select>
	              		
	              	</div>
              	</c:if>
              </div>
              
        <!-- 실제 게시판 -->
		<table class="table">
		   <thead class="table-dark">
		      <tr>
		         <th>번호</th>
		         <th>제목</th>
		         <th>글쓴이</th>
		         <th>등록일</th>
		         <th>조회수</th>
		         <th>삭제</th>
		      </tr>
		   </thead>
		   <!-- 
		   		XSS(cross-site Scripting 공격: 웹사이트에 스크립트 코드를 주입시켜서 공격하는 해킹 기법)
		   		JSP에서 XSS 공격 차단하는 방법
		   		<%-- <c:out /> --%>를 사용하여 입력된 테그를 브라우저가 인식하지 못하도록 문자열로 변환시켜서 방어를 함
		    -->
		   <tbody>
				<c:forEach var="dto" items="${requestScope.list}">
					<tr>
						<td>${dto.bid}</td>
						<td>	<!-- a href= 는 Get방식 --> <!-- 페이징처리 현재페이지로 이동값 viewPage를 pDto.viewPage로 설정 -->
							<a href="<c:url value='viewBoard.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>"><c:out value="${dto.subject}"/>
								<b>[댓글 : ${dto.replyCnt}]</b>
							</a>
						</td>
						<%-- <td>
							<c:forEach begin="1" end="${dto.bindent}">ㄴ</c:forEach>
							<a href="boardView.do?bid=${dto.bid}">${dto.title}
						</td> --%>
						<td><c:out value="${dto.writer}"/></td>
						<td>${dto.reg_date}</td>
						<td>${dto.hit}</td>
						<td>			<!-- 넘어갈때 숫자는 상관없지만 문자열로 넘어갈땐 ''를 감싸줘야 한다 '${pDto.searchType}' -->
							<input type ="button" class='btn btn-danger btn-sm' value="삭제" 
								onclick="delBoard(${dto.bid}, ${pDto.viewPage}, '${pDto.searchType}', '${pDto.keyword}', ${pDto.cntPerPage})">
						</td>
					</tr>
				</c:forEach>
				<tr>
		         <td colspan="6" class="text-center">
		            <button class="btn btn-primary my-3" id="btn-write">글쓰기</button>
		         </td>
		      	</tr>
			</tbody>
		</table><br>
		
		<!-- 페이지네이션, 페이징 처리 -->
				<ul class="pagination d-flex justify-content-center">
										<!-- 여백 mt-상 mb-하 my-상하 / ms-좌 me-우 mx-좌우 -->
					<li class="page-item ${pDto.viewPage > 1 ? '' : 'disabled'} mx-4">  <!-- viewPage를 pDto.viewPage 1 로 하면 안됌, 고정값으로 잡힘  -->
	    				<a class="page-link rounded-end" href="boardList.do?viewPage=1&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">첫 페이지</a>
	    			</li>
	    				    			
	    			<li class="page-item ${pDto.prevPage > 0 ? '' : 'disabled'} mx-4">
	    				<a class="page-link rounded" href="boardList.do?viewPage=${pDto.prevPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">이전 페이지</a>
	    			</li>

	    			<li class="page-item ${pDto.viewPage > 1 ? '' : 'disabled'}">
	    				<a class="page-link rounded-start" href="boardList.do?viewPage=${pDto.viewPage-1}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}"><</a>
	    			</li>
	    			
	    			<c:forEach var="i" begin="${pDto.blockStart}" end="${pDto.blockEnd}">
	    				<li class="page-item ${pDto.viewPage == i ? 'active':''}">		<!-- 삼항연산자 사용 -->
	    					<a class="page-link" href="boardList.do?viewPage=${i}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">${i}</a>
	    				</li>
	    			</c:forEach>
	    			
	    			<li class="page-item ${pDto.viewPage < pDto.totalPage ? '' : 'disabled'}">
	    				<a class="page-link rounded-end" href="boardList.do?viewPage=${pDto.viewPage+1}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">></a>
	    			</li>

	    			<li class="page-item ${pDto.nextPage <= pDto.totalPage ? '' : 'disabled'} mx-4">
	    				<a class="page-link rounded" href="boardList.do?viewPage=${pDto.nextPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">다음 페이지</a>
	    			</li>

	    			<li class="page-item ${pDto.viewPage == pDto.totalPage ? 'disabled' : ''} mx-4">
	    				<a class="page-link rounded-start" href="boardList.do?viewPage=${pDto.totalPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">마지막 페이지</a>
	    			</li>
	    		
	  			</ul>

</div>

<script>

	// JQuery 문
	$("#btn-write").click( () => {
		location.href="<c:url value='/registerBoard.do'/>";
	} )
	
	// 한페이지 게시글 수 onChange
//	$("#cntPerPage").change(function(){}) // 아래 람다식으로 표현
	$("#cntPerPage").change( () => {	// #cntPerPage option:selected -> 게시글 id의 옵션이 선택되었을때의 .val() 값
		let cntVal = $("#cntPerPage option:selected").val(); // 이 값을 boardcontroller - boardList.do로 넘어가야함
		//alert(cntVal);
		location.href="<c:url value='boardList.do?viewPage=1&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage='/>"+cntVal;
	} )

	// 자바스크립트
	function delBoard(bid, viewPage, searchType, keyword, cntPerPage){
		//location.href="<c:url value='/removeBoard.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}'/>";
		location.href="./removeBoard.do?bid="+bid+"&viewPage="+viewPage+"&searchType="+searchType+"&keyword="+keyword+"&cntPerPage="+cntPerPage;
	}

	
</script>    

<%@ include file="../include/footer.jsp" %>