<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ include file="../include/header.jsp" %>	

<div class="container w-50 mt-5 p-5 shadow">
   <form action="memberInsert.do" method="post" onSubmit="return submitChk()">
      <h4 class="text-center">회원가입</h4><br>            
      <div class="row">		<!-- 모달 중복체크 버튼 -->
<!--     <div class="col-md-8 pe-0"> 
            <input class="form-control mb-2" type="text" id="id" name="id" placeholder="아이디">
         </div>
        <div class="col-md-4">
           <a class="btn btn-outline-info w-100" onclick="idCheck()">중복체크</a>
        </div> -->
      </div>			<!-- 모달 중복체크 버튼대신 실시간으로 확인하는 것 -->
	      <input class="form-control mb-3" type="text" id="id" name="id" placeholder="아이디" onkeyup="idCheck()">
	     	 <p id="chkMsg" class="mb-2"></p>
	      <input type="hidden" id="isIdCheck" value="no"> <!-- 아이디 중복체크 submit 기본값 no, 자바스크립트에서 활용 -->
      
      <input class="form-control mb-3" type="text" name="pw" placeholder="비밀번호">
      <input class="form-control mb-3" type="text" name="name" placeholder="이름">
      <input class="form-control mb-3" type="text" name="age" placeholder="나이">
      
      <!-- 이메일 인증을 보내기 위한 내용 // 부트스트랩은 12개의 row로 나뉘어 있음 -->
      <div class="row">
      	<div class="col-md-8 pe-0"> <!-- pe-0 안쪽여백 제로 -->
      		<input class="form-control mb-1" type="text" id="email" name="email" placeholder="이메일">
      	</div>
      	<div class="col-md-4">
      		<input id="code-send" class="btn btn-outline-secondary w-100" type="button" onclick="emailCheck()" value="인증번호 발송">
      	</div>
      </div>
      
      <!-- 이메일 인증을 확인하기 위한 내용 -->
      <div class="row" id="confirmEmail"> 
	      	<!-- div 내용은 밑에 자바 스크립트 html('')에 붙여넣기 함, 다시 돌리고 style display:block none 사용 -->
<!-- 	주석은 폼컨트롤 이용, 밑에는 CSS 이용	      	
			<div class="col-md-6 pe-0">
	      		<input class="input-code form-control mb-2" type="text" id="confirmUUID" placeholder="인증코드 입력">
	      	</div>
	      	<div class="col-md-2 pe-0">	
	      		<input class="time form-control" value="03:00" readonly>
	      	</div>
	        <div class="col-md-4">
	      		<span class="btn btn-outline-secondary w-100" onclick="emailConfirm()">인증코드 확인</span>
	      	</div> -->
	      	<div class="col-md-8 pe-0">
	      		<input class="input-code" type="text" id="confirmUUID" placeholder="인증코드 입력"><input class="time" value="" readonly>
	      	</div>
	        <div class="col-md-4">
	      		<span id="confirm-btn" class="btn btn-outline-secondary w-100" onclick="emailConfirm()">인증코드 확인</span>
	      	</div>
	      	<p class="code-msg mt-1"></p>
      </div>
      

      <input class="form-control mt-3 mb-3" type="text" name="tel" placeholder="전화번호">
      
      <div class="text-center mt-3"><br>
         <input type="submit" class="btn btn-primary" value="가입">
         <input type="reset" class="btn btn-info" value="취소">
      </div>
      
   </form>
</div>

<!-- The Modal -->
<!-- <div class="modal fade" id="chkModal">
  <div class="modal-dialog">
    <div class="modal-content">

      Modal Header
      <div class="modal-header">
        <h4 class="modal-title">중복체크 확인</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      Modal body
      <div class="modal-body" id="chkMsg">
        
      </div>

      Modal footer
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div> -->

<script>
	
	// 아이디 중복체크
	function idCheck(){
		let uid = $("#id").val(); // 사용자 입력 아이디 가져오기
		
		if(uid.length<4){
			$("#chkMsg").text("아이디 길이는 4자리 이상이어야 합니다!!");
			$("#chkMsg").css({"color":"red", "font-size":"13px"})
			$("#isIdCheck").val("no");		// submitChk()에서 사용
			$("id").select();
			return;
		}
		
		$.ajax({
			url : "<c:url value='/memberIdCheck.do'/>", // 접속할 요청주소
			type : "get", // 전송방식(get, post)
			data : {"uid":uid}, // 서버에 전송할 데이터
			//dataType : "json", // 서버에서 응답하는 데이터 형식
			success : function(responseData){
				//console.log(responseData);
				if(responseData == "yes"){
					//alert("사용 가능한 아이디 입니다!!");
					$("#chkMsg").text("사용 가능한 아이디 입니다!!");
					$("#chkMsg").css({"color":"blue", "font-size":"13px"})
					$("#isIdCheck").val("yes");		// submitChk()에서 사용
				} else {
					//alert("이미 존재하는 아이디 입니다!!");
					$("#chkMsg").text("사용할 수 없는 아이디 입니다!!");
					$("#chkMsg").css({"color":"red", "font-size":"13px"})
					$("#isIdCheck").val("no");		// submitChk()에서 사용
					$("id").select();
				}
				//$("#chkModal").modal("show");
			}, // 서버에서 성공적으로 요청이 수행되었을때 호출되는 함수(콜백함수)를 지정
			error : function(){alert("Server Error")} // 서버에서 요청처리를 실패했을때 처리되는 함수를 지정
		});
	}
	
	let time_display;
	let timer;
	// timer 동작 함수
	function timer_start(){
		timer_stop();
		
		let count = 20;
		time_display = $('.time');
		time_display.val("03:00");
		
		// 타이머 설정시 사용하는 함수 
		// timer = setInterval(function, 1000) : 1초마다 function을 주기적으로 호출
		// clearInterval(timer) : timer 함수를 종료시켜주는 역할
		timer = setInterval(()=>{
			let minutes = parseInt(count / 60);	// count/60, 10진수로 변경 // 뒤에 , 10은 생략가능
			let seconds = parseInt(count % 60);
			
			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds;
			
			time_display.val(minutes + ":" + seconds);
			
			// timer 종료
			if(--count < 0){
				timer_stop();
				time_display.val("시간초과");
				$(".code-msg").css({"display": "block", "color" :"red"});// main.css에서도 사용되기때문에 여러개 중복으로 css가 사용될땐 {} 사용
				$(".code-msg").text("인증코드가 만료되었습니다!!");
				$("#code-send").removeClass("disabled");
				$("#code-send").val("코드 재발송");
				$("#confirm-btn").addClass("disabled");
				$(".input-code").val("");
				$(".input-code").attr("readonly", true);
				$("#email").attr("readonly", false);

			}
		}, 1000)
		
	}
	// timer 종료
	function timer_stop(){
		isEmailCheck = false;
		clearInterval(timer);
	}
	
	// 이메일 인증코드 보내기
	// 모든함수에서 사용하도록 responseUUID를 전역변수로 설정
	let responseUUID = "";
	let isEmailCheck = false; // submitChk()에서 사용, 이메일 체크확인, 기본값 false
	
	function emailCheck(){
		let uEmail = $("#email").val(); // 사용자가 입력한 이메일 id="email"
		$("#code-send").addClass("disabled");
		$("#confirm-btn").removeClass("disabled");
		$("#email").attr("readonly", true);
		
		
		$.ajax({
			url : "<c:url value='/memberEmailCheck.do'/>",
			type : "get",
			data : {"uEmail":uEmail},
			success: function(UUID){	// responseEmail 서버에서 전달된 값(return uuid 또는 return fail)
				responseUUID = UUID
				if(responseUUID != "fail"){
					//console.log("인증코드:"+ responseUUID);
/* 						$("#confirmEmail").html('<div class="col-md-8 pe-0">'
					      		+ '<input class="form-control mb-2" type="text" id="confirmUUID" placeholder="인증코드 입력"></div>'
					          	+ '<div class="col-md-4">'
					      		+ '<span class="btn btn-outline-secondary w-100" onclick="emailConfirm()">인증코드 확인</span></div>'); */
					      		
					// 인증코드 이메일이 보내지고나서 타이머 시작
					$(".input-code").attr("readonly", false);
					$("#confirmEmail").css({"visibility":"visible", "height":"auto"})
					$(".code-msg").css({"display": "block", "color" :"green"});	// main.css에서도 사용되기때문에 여러개 중복으로 css가 사용될땐 {} 사용
					$(".code-msg").text("인증코드가 발송되었습니다!!");
					timer_start();
					
				} else {
					alert("이메일을 다시 확인하세요!! 다시 처음부터 진행하세요.");
					$("#email").select();
				}
			},
			error : function(){
				alert("메일발송 실패!! 다시 처음부터 진행하세요.");
				$("#email").select(); // 실패시 다시 이메일을 입력 할 수 있게 포커스를 주기
			}
		})
	}

	// 이메일 인증코드 일치하는지 확인
	function emailConfirm(){
		let confirmUUID = $("#confirmUUID").val();
		
		if(confirmUUID == null || confirmUUID.trim() == ""){
			alert("이메일 인증코드를 입력하세요");
			$(".code-msg").css({"display": "block", "color" :"red"});
			$(".code-msg").text("이메일 인증코드를 입력하세요");
			$("#confirmUUID").select(); // 실패시 다시 코드를 입력 할 수 있게 포커스를 주기
			isEmailCheck = false;	// submitChk()에서 사용
			return;
		} else if(responseUUID == confirmUUID){ // 서버에서 전송된 uuid(responseUUID)값과 입력한 uuid(confirmUUID)이 같은경우
			alert("이메일 인증 성공!!");
			timer_stop();
			$("#confirm-btn").addClass("disabled");
			$("#code-send").addClass("disabled");
			time_display.val("인증완료");
			$(".code-msg").css({"display": "block", "color" :"green"});
			$(".code-msg").text("이메일 인증이 완료되었습니다.");
			$(".input-code").attr("readonly", true);
			// javaScript의 readonly 속성 제어하기
			// document.querySelector(".input-code").readOnly=true;  단, O가 대문자
			
			isEmailCheck = true;	// submitChk()에서 사용
			return;
		} else {	// 인증코드를 잘못 입력한 경우
			alert("이메일 인증코드를 다시 확인하세요!!");
			$(".code-msg").css({"display": "block", "color" :"red"});
			$(".code-msg").text("이메일 인증코드를 다시 확인하세요!!");
			$("#confirmUUID").select(); // 실패시 다시 코드를 입력 할 수 있게 포커스를 주기
			isEmailCheck = false;	// submitChk()에서 사용
			return;
		}
	}
	
	// 가입버튼 누를시 onSubmit 진행
	function submitChk(){
		let isIdCheck = $("#isIdCheck").val();

		if(isIdCheck == "no"){
			alert("아이디 중복체크를 확인해주세요!!")
			$("#id").select();
			return false;
		}
		
		if(!isEmailCheck){
			alert("이메일 인증을 해주세요!!");
			$("#email").select();
			return false;
		}
		return true;
	}
	
</script>

<%@ include file="../include/footer.jsp" %>