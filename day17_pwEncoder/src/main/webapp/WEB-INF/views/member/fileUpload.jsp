<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>	

<div class="container w-50 mt-5 p-5 shadow">
   <form action="<c:url value="/fileUploadOk.do"/>" method="post" enctype="multipart/form-data">
   
		<h3 class="text-center mb-4">파일 업로드</h3><br>
	        <input class="form-control mb-2" type="text" id="id" name="id" placeholder="아이디"/>
	        <input class="form-control mb-2" type="text" id="name" name="name" placeholder="이름"/>
	        
	        <div class="row mb-2">
	           <div class="col-md-6 col-sm-6"><br>
	              <input type="button" class="form-control btn btn-outline-secondary" 
	                 type="text" value="업로드파일 추가" onclick="fileAppend()"/>
	           </div>
	           <div class="col-md-6 col-sm-6"><br>
	              <input type="button" class="form-control btn btn-outline-secondary" 
	              type="text" value="업로드파일 취소" onclick="fileRemove()"/>
	           </div>
	        </div>
	        
      <div id="div-file">								<!-- this는 지금 현재 이벤트가 발생하는 객체(input) -->
<!--   	      <input type="file" class="form-control" accept="image/gif, image/png, image/jpeg, image/jpg" onchange="preView(this)" name="file"><img /><button type="button" class="btn-close border bg-danger" style="display:none; position:relative; left:100px; top:-100px;" onclick="delInput(this)"></button> --> <!-- this는 지금 현재 이벤트가 발생하는 객체(button) -->
 	      		
 	      <!-- style="position:relative" 
 	      :relative 는 좌표 자신의 기준으로부터 움직임
 	      :absolute 는 좌표 부모의 기준으로부터 움직임  -->
      </div>
      
      <div class="text-center mt-3"><br>
			<button class="btn btn-primary form-control">파일 업로드</button>
      </div>
   </form>
</div>

<script>

	var cnt = 1; // accept="image/gif, image/png, image/jpeg, image/jpg" 업로드 될때 해당파일만 선택하도록 설정
	function fileAppend(){ // 파일첨부 버튼		/* window - editor - toggle word wrap */
		var fileElement = '<input type="file" class="form-control" accept="image/gif, image/png, image/jpeg, image/jpg" onchange="preView(this)" name="file'+cnt+'"><img /><button type="button" class="btn-close border bg-danger" style="display:none; position:relative; left:100px; top:-100px;" onclick="delInput(this)"></button>'
		
		$("#div-file").append(fileElement); // 업로드 첨부파일 버튼 추가
		cnt++;
	}
	
	function fileRemove(){ // 업로드 파일 취소
		cnt = 1;	
		$("#div-file").empty();
	}
	
	function preView(obj){
		// html의 accept 속성만으로는 완벽하게 차단하지 못함
		// 다이얼 로그에서 모든 속성을 선택하면 이미지 이외에 다른파일 첨부가능
		// 따라서, 추가로 자바스크립트로 막아야 한다.
	      //------  자바스크립트로 파일 타입을 컨트롤하기 --------   
	      var point = obj.value.lastIndexOf('.');  // image.jpg 뒤에서부터 .을 찾는다   
	      console.log(point);						// .의 위치(인덱스) 5  - 한글은 utf-8로 3바이트
	      var ext = obj.value.substring(point+1);	// 잘라낸다 그 위치부터 +1 된 인덱스는 6, 그 뒤 문자열은 jpg
	      console.log(ext);							// 그 뒤 문자열은 jpg
	      var ftype = ext.toLowerCase();		// 소문자로 변환
	      
	   		// 이미지 타입으로만 파일 업로드 진행
	      if(ftype=='jpg' || ftype=='gif' || ftype=='png'){	
	         console.log("이미지 파일입니다!!");
	         imgRead(obj);		// 이미지 파일일때 이미지 불러오는 함수호출
	      }else{
	         alert("이미지 파일만 선택 가능합니다!!");
	         obj.value="";			// 선택박스 값을 공백으로 만듬
	         return false;			// 함수 종료
	      }
	      // ----------------------------------------------
	}
	      
	function imgRead(obj){
		// files : 배열객체(이미지를 다중 선택할 경우 여러개를 저장하기 위한 객체) 
		console.log(obj.files);
		// 이미지 미리보기 
		var imgTag = obj.nextSibling; // nextSibling(다음이란 뜻) : 같은줄의 <img /> 형제요소를 가져다 쓰겠다
		console.log(imgTag);
		// var btnTag = imgTag.nextSibling.nextSibling;	// 기준이 obj가 아닌 imgTag 때문에 2개도 가능
		var btnTag = obj.nextSibling.nextSibling; // 이미지 삭제버튼 // nextSibling 3개 사용해주는 이유
		// preview의 다음은 <img /> 의 다음은 엔터 의 다음은 button  // 엔터가 빠지면 2개만 넣어 도 됌
		
		// 파일의 종류를 크게 두가지로 분류
		// 1) 바이너리 파일 : 데이터를 있는 그대로 읽고 쓰는 파일
		// 2) 텍스트 바일 : 데이터를 문자로 변환한 파일 -> 읽을 수 있음
		
		// 선택한 이미지가 존재할경우 참
		if(obj.files[0]){
			var fileReader = new FileReader(); // FileReader : 자바스크립트의 라이브러리, 파일을 읽어오는 객체
			
			// fileReader.onload : 파일을 성공적으로 읽었을때 발생하는 이벤트 -> 아래함수 수행
			fileReader.onload = function(e){
				imgTag.width = 100;
				imgTag.height = 100;
				// e.target : 이벤트가 발생한 대상 =>  fileReader
				imgTag.src = e.target.result; // 파일의 읽어온 결과값을 src에 넣어줌(바이너리 데이터)
				btnTag.style.display="block"; // display none 값을 보여주겠다. // block은 생략가능 "";
			}
			
			// 바이너리 파일을 base64형식으로 변환해줌
			// base64(2^6) : binary Data를 텍스트로 변환시 손실없이 안전하게 인코딩 가능, 64비트만 가능
			// 즉, 바이너리 데이터를 훼손없이 정확하게 전달할 수 있는 방식
			fileReader.readAsDataURL(obj.files[0]);
		}
	}
	
	// delete 버튼
	function delInput(obj){		// 버튼이전은 엔터, 엔터이전은 이미지
		var imgTag = obj.previousSibling; // 이전형제요소  nextSibling과 반대 // 엔터가 빠지면 1개만 넣어도 됌
		var inputTag = imgTag.previousSibling; // 이미지 태그 이전
		
		inputTag.style.display="none";
		inputTag.value="";
		imgTag.style.display="none";
		//imgTag.value="";
		obj.style.display="none";
	}

</script>

<%@ include file="../include/footer.jsp" %>