<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<%@ include file="../include/header.jsp" %> <!-- 한번더 밖으로 나가서 header를 불러와야함 -->

<div class="container w-50 mt-5 p-5 shadow">

      <h4 class="text-center">글 상세보기</h4><br>
      		<div class="form-group">       
      			<label for="bid">번호</label>    
		 		 	<input class="form-control" type="text" id="bid" name="bid" value="${dto.bid}" disabled>
			</div><br> 
		
		    <div class="form-group">       
      			<label for="bid">제목</label>       
		  			<input class="form-control" type="text" id="subject" name="subject" value="${dto.subject}" disabled>      
	      	</div><br> 
	      	
	        <div class="form-group">       
      			<label for="bid">내용</label> 
	     			 <textarea class="form-control mt-2" name="contents" id="contents" disabled><c:out value="${dto.contents}"/></textarea>
	      	</div><br> 
	      	
	   	  	<div class="form-group">       
      			<label for="bid">작성자</label>
	      			<input class="form-control mt-2" type="text" id="writer" name="writer" value="${dto.writer}" disabled><br>
	      	</div><br> 
	      	
	      <div class="text-center mt-3">
	         <button id="btn-modify" class="btn btn-primary me-2">수정하기</button>   
	         <button id="btn-list" class="btn btn-primary">리스트</button>   
	      </div>
	      
	      <!---------------------- 댓글 UI START ---------------------->
	      
	      <div class="mt-5 mb-3 d-flex justify-content-between">
	      	<h6><i class="fa fa-comments-o"></i> 댓글</h6>
	      	<button id="btn-addReply" class="btn btn-sm btn-outline-secondary" data-bs-target="#replyModal" data-bs-toggle="modal">새 댓글</button>
	      </div>
	      
	      <!-- 댓글 리스트 영역 -->
	      <ul class="replyArea p-0" style="list-style:none;">		<!-- style="list-style:none; 댓글내용 앞에 -점 없앰 -->
	      	<li class="mb-2">
	      		<div class="form-control">
	      			<div class="d-flex justify-content-between">
	      				<h6>홍길동</h6><span>2023-12-05</span>
	      			</div>
	      			<p>댓글 테스트...</p>
	      		</div>
	      	</li>	      	
	      	<li class="mb-2">
	      		<div class="form-control">
	      			<div class="d-flex justify-content-between">
	      				<h6>홍길동</h6><span>2023-12-05</span>
	      			</div>
	      			<p>댓글 테스트...</p>
	      		</div>
	      	</li>	      	
	      </ul>
	      
	      <!-- Pagination Area : 댓글 페이징 처리 -->
	    <ul class="pagination justify-content-center my-5">
	         <li class="page-item">
	            <a class="page-link">이전</a>
	         </li>
	
	         <li class="page-item">
	            <a class="page-link">1</a>
	         </li>
	
	         <li class="page-item">
	            <a class="page-link">다음</a>
	         </li>
      	</ul>
	      
	      <!---------------------- 댓글 UI END ------------------------>

</div>

	<!-- The Modal -->		<!-- data-rno="" 삭제해도 수정이 됌 -->
	<div class="modal fade" id="replyModal" data-rno="">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	     <!--  Modal Header -->
	      <div class="modal-header">
	        <h5 class="modal-title">댓글 달기</h5>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body p-4">
	        <div class="mb-3">
	        	<label>댓글 내용</label>
	        		<textarea class="form-control" id="r_contents"></textarea>
	        </div>
	        <div class="mb-3">
	        	<label>댓글 작성자</label>
	        		<input type="text" class="form-control" id="replyer" name="replyer"/>
	        </div>
	        <div class="mb-3">
	        	<label>등록일</label>
	        		<input type="text" class="form-control" id="r_date" name="r_date"/>
	        </div>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" id="btn-modal-modify" class="btn btn-sm btn-success">수정</button>
	        <button type="button" id="btn-modal-remove" class="btn btn-sm btn-danger">삭제</button>
	        <button type="button" id="btn-modal-register" class="btn btn-sm btn-primary">등록</button>
	        <button type="button" id="btn-modal-close" class="btn btn-sm btn-secondary">닫기</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	
<!-- 테스트 코드라 reply.js로 이동 -->
<script src="resources/js/reply.js"></script>

<script>

	//$("#btn-list").click(function ㅇㅇㅇ(){} ) // 이름없는 함수는 람다식으로 아래처럼 표현이 가능
	//$("#btn-list").click( () => {} ) // 람다식(=화살표 연산자) -> 아래 실제 사용법
					// (파라미터) => {리턴값, 명령코드}

	// id="#btn-list".click 클릭할때 -> 리스트로 이동 // 페이징처리 현재페이지로 이동
	$("#btn-list").click( () => {
		location.href="<c:url value='/boardList.do?viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
	} )
	
	// 수정하기 클릭 -> 수정하기 폼으로 이동
	$("#btn-modify").click( () => {
		location.href="<c:url value='/modifyBoard.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
	} )

//////////////////////////////////////////////////////////////////////
/* 	// 즉시실행함수 테스트
	//let replyFunc = (function(){})(); 아래와 동일 람다식으로 표현
	//let replyFunc = (() => {})();
	
	let replyFunc = (() => {
		function register(reply){
			console.log(reply + "~~~~~");
		}
		// 매개변수는 함수, callback은 함수 // callback함수는 시스템이 호출하는 함수
		function register2(reply, callback){		
			console.log(reply + "~~~~~");
			callback();
		}
		
		// private 속성 함수들이라 리턴을 명시하여 접근이 가능하도록 함
		return {
			register:register,
			register2:register2
		}
	})();
	
	console.log(replyFunc.register("댓글 테스트"));
	// 매개변수로 함수를 전달해주는 register2
	console.log(replyFunc.register2("댓글 테스트",
				function(){console.log("콜백함수 호출")})
			); */

	// reply 매개변수 : bid, r_contents, replyer 포함하는 Json형태가 됩니다.
	// 테스트 코드라 replyFunc 함수를 reply.js로 이동
/* 	let replyFunc = (() => {
		// 댓글 등록
		function register(reply, callback){
			$.ajax({
				url: "/reply/replies/new",
				type: "post",
				data: JSON.stringify(reply),	// 문자열(텍스트) 변환 ==> 직렬화작업
				contentType: "application/json; charset=utf8",	// 직렬화 윗줄과 세트
				success: function(result){
					callback(result);
				},
				error: ()=>{alert("요청실패!!")}
			});
		}
		
		// 댓글 삭제
		function remove(rno, callback){
			$.ajax({
				url: "/reply/replies/"+rno,
				type: "delete",
				success: function(result){
					callback(result);
				},
				error: ()=>{alert("요청실패!!")}
			});
		}
		
		// 댓글 조회
		function read(rno, callback){
			$.ajax({
				url: "/reply/replies/"+rno,
				type: "get",
				success: function(result){
					// (result) => {} 람다식으로도 가능
					callback(result);
				},
				error: ()=>{alert("요청실패!!")}
			});
		}
		
		// 댓글 수정
		function update(reply, callback){
			$.ajax({
				url: "/reply/replies/"+reply.rno,
				type: "put",
				data: JSON.stringify(reply),	// 문자열(텍스트) 변환 ==> 직렬화작업
				contentType: "application/json; charset=utf8",	// 직렬화 윗줄과 세트
				success: function(result){
					// (result) => {} 람다식으로도 가능
					callback(result);
				},
				error: ()=>{alert("요청실패!!")}
			});
		}
		
		return { 		// replyFunc의 리턴
			register:register,
			remove:remove,
			read:read,
			update:update
		}
	})(); // replyFunc */
					
	// replyFunc 댓글 CRUD 함수 호출
 	$(document).ready(function(){
		// 게시글 번호 구하기
		let bidVal = "${dto.bid}";
		
/*		// 등록 테스트
	  	replyFunc.register(
	  		{bid:bidVal, r_contents:"댓글 테스트", replyer:"고길동"},		// regitster(reply,
			function(result){									// regitster( ,callback)
	  			alert("result: "+result)							
	  			}	
	  	);	*/						
			
/*		// 삭제 테스트
  		replyFunc.remove(6, function(result){
			console.log(result);
			if(result == "success") alert(result);
		});  */
		
  	// 조회 테스트
/* 		replyFunc.read(2, function(result){
			console.log(result);
			alert(result);
		});  */ 
		
 		// 수정 테스트
/* 		replyFunc.update(
			{rno:2, r_contents:"수정 123..."},
			function(result){
			console.log(result);
			alert("수정: "+result);
		}); */
		
		// 특정게시글에 대한 댓글조회(리스트) -> displayList() 함수로 만들어서 언제든지 호출할 수 있도록
		let viewPage = 1;
		let replyAre = $(".replyArea"); // 특정게시글 안에 댓글리스트 영역으로 접속 
		displayList(); // 댓글리스트출력 함수 호출
		//function displayList(){	// 페이징처리 이전코딩
		function displayList(viewPage){
			let str = "";
			//replyFunc.getList(bidVal, function(list){ // 페이징처리 이전코딩
			replyFunc.getList({bid:bidVal, viewPage:viewPage || 1}, function(data){ 
				// viewPage:viewPage || 1 뷰페이지가 널이면 1을 넣겠다. 
				// data는 자바의 rPageDto를 JSON 형태로 받은것
				let list = data.list;	// data의 리스트를 불러와서 list에 담음
  				for(let i=0; i < list.length; i++){
			      	str += '<li class="mb-2" data-rno="'+list[i].rno+'">'
					      		+'<div class="form-control">'
					      			+'<div class="d-flex justify-content-between">'
					      				+'<h6>'+list[i].replyer+'</h6><span>'+replyFunc.showDateTime(list[i].r_date)+'</span>'
					      			+'</div>'
					      			+'<p>'+list[i].r_contents+'</p>'
					      		+'</div>'
				      		+'</li>'
				}
				replyAre.html(str);
				showPageNavi(data);
			});
		} // displayList();
		
//////////댓글 PageNation 함수처리 - 페이징처리
		let pageArea = $(".pagination");
		
		function showPageNavi(data){ // data는 자바의 rPageDto를 JSON 형태로 받은것
			let viewPage = data.viewPage;
			let prevPage = data.prevPage;
			let nextPage = data.nextPage;
			let totalPage = data.totalPage;
			
			let blockStart = data.blockStart;
			let blockEnd = data.blockEnd;

			let str = "";
			
			if(prevPage){
				str += '<li class="page-item">'
					+	'<a class="page-link" href="'+prevPage+'">이전</a></li>';
			}
	        for(let i = blockStart; i<=blockEnd; i++){
	            let active = viewPage == i ? 'active' : '';   
	          
	            str +='<li class="page-item '+active+'">'            
	                +'<a class="page-link" href="'+i+'">'+i+'</a></li>';
	        }
			if(blockEnd < totalPage){
				str += '<li class="page-item">'
					+	'<a class="page-link" href="'+nextPage+'">다음</a></li>';
			}
			pageArea.html(str);
		} // showPageNavi();
		
		// 이벤트 위임 : 클릭시 존재하는 li = viewPage 1,2,3.... 을 전달해주겟다.
		pageArea.on("click", "li a", function(e){
			e.preventDefault();	// 클릭했을때 기존 li a 태그의 link href 속성(값)을 차단시키겠다.
			let viewPage = $(this).attr("href");// pageArea li a href 현재 값을 viewPage로 설정
			displayList(viewPage);	// 출력
		});
		
		// ----------------- Modal & Event 처리 -----------------
		let modal = $(".modal");
		let taReplyContents = $("#r_contents");
		let inputReplyer = $("#replyer");
		let inputReplyDate = $("#r_date");
		
		let modifyBtn = $("#btn-modal-modify");
		let removeBtn = $("#btn-modal-remove");
		let registerBtn = $("#btn-modal-register");
		
		// 닫기버튼시 닫힘
		$("#btn-modal-close").on("click", () => {
			modal.modal("hide"); 	// modal()함수 사용, 닫을땐 hide 열땐 show
		});
		
		// 새댓글 클릭시 ==> 등록버튼과 삭제버튼 안보이게
		$("#btn-addReply").on("click", () => {
			taReplyContents.val("");	// 등록버튼 클릭시 값 초기화
			inputReplyer.val("").attr("readonly", false);	// 읽고난후 등록시 readonly 풀어오기
			
			inputReplyDate.closest("div").hide(); // 등록일을 숨김(닫음)	// 부모들 중에 가장 가까운 div를 선택하여 hide(닫음)
			 // inputReplyDate는 input 본인 // inputReplyDate의 label 은 형제 
			
			//modal.find("button[id != btn-modal-close]").hide();	// 새댓글 클릭시에 모달의 .find() 모달.닫기"버튼"을 제외한 나머지 3개 버튼을 찾아서 .hide()숨기겠다.
			//registerBtn.show(); // 윗줄 상태에서 등록버튼만 show() 보이게 하겠다
			modifyBtn.hide(); // 위 두줄하고 같음 // 수정, 삭제버튼 숨기겠다.
			removeBtn.hide();
			registerBtn.show();
		});
		// ----------------- ----------------- -----------------
		
////////// modal의 새댓글 버튼 클릭시 댓글등록폼 모달 -> 댓글등록 OK
		// registerBtn.on("click".. ==>> replyFunc.register
		registerBtn.on("click", () => {
			if(taReplyContents.val().trim() == ""){
				alert("댓글 내용을 입력하세요!!")
				taReplyContents.focus(); // 커서 포커스
				return;
			}
			if(inputReplyer.val().trim() == ""){
				alert("작성자를 입력하세요!!")
				inputReplyer.focus(); // 커서 포커스
				return;
			}
			
			// 댓글등록 OK
			let reply = {bid:bidVal, r_contents:taReplyContents.val(), replyer:inputReplyer.val()}
			replyFunc.register(reply, function(result){
				modal.modal("hide"); // 모달 닫기
				displayList();	// 추가된 리스트 호출함수
			});
		}); // registerBtn.on("click"
		
////////// 댓글 상세보기			// 자기 자식인 li 한테 이벤트를 전달
		// 이벤트 위임(전달:delegation) : jquery에서는 on() 함수를 이용
		// 현재 ul(.replyArea) 태그에 이벤트를 주고 실제 이벤트 대상을 li가 되도록 위임(이벤트 전가)한다.
		// click 이벤트가 li로 전달됌
		// 댓글이 없으면 li는 존재하지 않음. 따라서 li에는 이벤트를 줄수가 없다.
		// 항상 존재하는 ul(.replyArea)태그에 이벤트를 주고 자식 li에게 전달해줌
		$(".replyArea").on("click", "li", function(){
			//console.log($(this).data("rno")); // $(this) = replyArea 
			let rno = $(this).data("rno");	// 현재 값 띄워주기, for문의 data-rno="'+list[i].rno+'"
			replyFunc.read(rno, function(reply){	// .attr("readonly", true) 읽기전용
				taReplyContents.val(reply.r_contents);
				inputReplyer.val(reply.replyer).attr("readonly", true);
				inputReplyDate.val(replyFunc.showDateTime(reply.r_date)).attr("readonly", true);
				
				inputReplyDate.closest("div").show();	// 등록일 오픈
				modifyBtn.show();						// 버튼들 오픈
				removeBtn.show();
				registerBtn.hide();
				
				// 모달창에 선택한 댓글의 rno값을 모달 뷰 id="replyModal" data-rno="" 에 저장하기
				//modal.data("rno", reply.rno); // function(reply)의 서버에서 리턴된 rno의 값
				modal.data("rno", rno); // 현재 this에서 클릭된 rno(뷰), 위와 같은말
			})
			
			modal.modal("show"); // 모달창 오픈
		}); // $(".replyArea").on("click"
		
////////// 댓글수정 OK
		modifyBtn.on("click", function(){	// 선택한 댓글의 뷰에 저장된 rno값 가져오기
			let reply = {rno:modal.data("rno"), r_contents:taReplyContents.val()};
			replyFunc.update(reply, function(result){
				modal.modal("hide"); // 모달 닫기
				displayList();	// 추가된 리스트 호출함수
			});
		}); // modifiyBtn.on("click"
		
////////// 댓글삭제 OK
		removeBtn.on("click", function(){
			let rno = modal.data("rno");
			replyFunc.remove(rno, function(result){
				modal.modal("hide"); // 모달 닫기
				displayList();	// 추가된 리스트 호출함수
			});
		}); // removeBtn.on("click"
				

	}); // document.ready
//////////////////////////////////////////////////////////////////////

</script>


<%@ include file="../include/footer.jsp" %>