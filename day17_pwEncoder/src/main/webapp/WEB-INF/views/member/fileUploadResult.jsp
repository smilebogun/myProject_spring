<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>	

<div class="container w-50 mt-5 p-5 shadow">
   <form action="" method="post">
   
	<h3 class="text-center mb-4">파일 업로드 확인</h3><br>
       <input class="form-control mb-2" type="text" id="id" name="id" placeholder="${map.id}" disabled/>
       <input class="form-control mb-2" type="text" id="name" name="name" placeholder="${map.name}" disabled/>
   
		<table>
			<c:forEach var="fname" items="${map.fileList}">
				<tr>
					<td class="col-md-9 border"> <!-- 구역나누기 총 합 12 중 9 -->
						<img class="fileUpload-img-top" 
						  src="<c:url value="/resources/fileRepository/${fname}"/>" 
						  alt="fileUpload image" style="width:100px">${fname}
				  	</td>
				  	<td class="col-md-3 border"> <!-- 구역나누기 총 합 12 중 3 -->
				  		<a href="javascript:downloadFile('${fname}')" 
				  		class="btn btn-sm btn-outline-success w-100">다운로드 <i class="far fa-save"></i></a>
				  	</td>
				</tr>
			</c:forEach>
			<tr>
				<td class="text-center" colspan="2"><br>
					<a href="fileUpload.do" class="btn btn-primary">다시 업로드하기</a>
				</td>
			</tr>
		</table>
   </form>
</div>

<script>
	function downloadFile(fName){
		location.href="<c:url value='fileDownload.do'/>?fName="+fName;
	}

</script>

<%@ include file="../include/footer.jsp" %>