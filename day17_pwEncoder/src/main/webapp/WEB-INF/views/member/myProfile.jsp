<%@page import="kr.ezen.pwEncoder.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>	
                                         
<div class="container w-75 mt-5 p-5 border shadow d-flex">  
	<aside class="border-end" style="width:200px">
		<h4 >My Profile</h4><br>
			<ul>
				<li><a href="">비밀번호 변경</a></li>
				<li><a href="">기타메뉴</a></li>
			</ul>         
	</aside>
	
	<div class="container w-50">
		<h4 class="text-center">비밀번호 변경</h4><br>
		<input  class="form-control mb-2" type="hidden" id="memberId" value="${sessionScope.loginDTO.id}"/>
		<input  class="form-control mb-2" type="text" value="${sessionScope.loginDTO.pw}"/>

		<input class="form-control mb-2" type="text" id="pw" name="pw" placeholder="현재 비밀번호"/>
		<input class="form-control mb-2" type="text" id="newPw" name="newPw" placeholder="새 비밀번호"/>
				<p id="pwChkMsg"></p>
		<input class="form-control mb-2" type="text" id="confirmPw" name="confirmPw" placeholder="새 비밀번호 확인"/>
				<p id="pwChkMsg2"></p>
	  
		<div class="text-center"><br>
			<button id="pwChangeBtn" class="btn btn-sm btn-success">비밀번호 변경</button>
		</div>
	</div>
	                                                            
</div>

<script>
	let pw = "";
	let currentPwChk = "";
	// 현재비밀번호
	function pwCheck(){	// ajax : 비동기 방식
		pw = $("#pw").val();
		$.ajax({		// Post방식
			url: "<c:url value='pwCheck.do'/>",
			type: "post",
			data: {"pw":pw}, 	// json 형태
			async: false,	// 동기화 처리하겠다. 기본값 true // ajax : 비동기방식으로 진행되면 안되는 상황이라, 순서대로 진행되어야되기때문에 동기방식처럼 넣어줘야함
			success: function(result){
				console.log("result :"+result);
				if(result == "ok"){
					alert("현재 비밀번호 확인 완료");
					currentPwChk = true;
				} else {
					alert("현재 비밀번호를 다시 확인하세요");
					currentPwChk = false;
				}
			},
			error: function(){alert("현재 비밀번호 체크요청 실패!!")}
		});
	}

	// 새로운 비밀번호 유효성 체크
	let newPwChk = "";
	$("#newPw").on("keyup", function(){
		let npw = $("#newPw").val();
		if(npw == ""){
			$("#pwChkMsg").text("새 비밀번호를 입력하세요");
			newPwChk = false;
		} else if(npw.length < 4){
			$("#pwChkMsg").text("4자리 이상 입력하세요");
			newPwChk = false;
		} else if($("#pw").val() == $("#newPw").val()){
			$("#pwChkMsg").text("기존 비밀번호와 다르게 입력하세요");
			newPwChk = false;
		} else {
			$("#pwChkMsg").text("정상");
             newPwChk = true;
		}
	});
	
	// 새로운 비밀번호 확인 
	let newConfirmPwChk = "";
	$("#confirmPw").on("keyup", function(){
		let cpw = $("#confirmPw").val();
		if(cpw == ""){
			$("#pwChkMsg2").text("새 비밀번호 재입력을 하세요");
			newConfirmPwChk = false;
		} else if(cpw != $("#newPw").val()){
			$("#pwChkMsg2").text("재입력한 비밀번호가 일치하지 않습니다");
			newConfirmPwChk = false;
		} else {
			$("#pwChkMsg2").text("정상");
            newConfirmPwChk = true;
		}
	});
	
	// 현재 비밀번호 확인 - 위 버튼에 클릭이벤트가 발생하면 함수수행 // html onclick 이벤트와 동일 - 키업, 온클릭 등 이벤트 발생될때 하단부에 재확인하는 로직을 넣어주어야 함
	$("#pwChangeBtn").on("click", function(){
		// 현재비밀번호 체크 함수호출
		pwCheck()	// ajax : 비동기방식으로 진행되어 순서대로 진행되어야되기때문에 동기방식처럼 넣어줘야함
		
		// 새비밀번호 재확인 - 새 비밀번호를 다시 수정했을때, 새 비밀번호 확인과 일치하지 않아도 비밀번호 변경요청이 처리되는 문제 발생
		if($("#newPw").val() != $("#confirmPw").val()){					// 새 비밀번호와 새 비밀번호 확인이 일치 하지 않을때 
			alert("중간에 변경된 데이터가 있습니다. 새 비밀번호를 재입력하세요");		// 경고문구
			$("#pwChkMsg2").text("재입력한 비밀번호가 일치하지 않습니다");		// 메세지 변경
			newConfirmPwChk = false;									// 새 비밀번호 확인 값 false로 아이디 생성방지
		}
		
		if(!currentPwChk){
			alert("현재 비밀번호를 확인하세요.");
		} else if(!newPwChk){
			alert("변경할 새 비밀번호를 확인하세요");
		} else if(!newConfirmPwChk){
			alert("새 비밀번호 재확인을 확인하세요");
		} else if(currentPwChk && newPwChk && newConfirmPwChk){
			alert("비밀번호 변경옵션 체크완료");
			console.log("비밀번호 변경 완료");
			let id = $("#memberId").val();
			let pw = $("#newPw").val();
			let member = {"id":id, "pw":pw} // member는 자바스크립트 객체, 자바스크립트 객체는 http 통신할때 바로 보내지 못함. // jackson lib 이용해서 자바객체로 변환해서 보내고 받아야함
			
			$.ajax({
				url: "<c:url value='pwChange.do'/>",
				type: "post",
				// 자바 스크립트 객체를 전송 할 수 없기 때문에
				// JSON 형태의 문자열로 변환해줌
				data: JSON.stringify(member), // member는 JSON 형태의 자바객체 문자열로 변환
				contentType: "application/json; charset=utf8", // 이게 추가 되어야 함
				success: function(result){
					if(result > 0){
						alert("비밀번호 변경완료!! 새로운 비밀번호로 로그인 하세요!!");
						location.href="<c:url value='memberLogout.do'/>";
					}
				},
				error: function(){alert("비밀번호 변경 요청실패")}
			});
		}
	
	});

</script>    
                               
<%@ include file="../include/footer.jsp" %>