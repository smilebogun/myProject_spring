package kr.ezen.controller;

import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ezen.pwEncoder.domain.MemberDTO;
import kr.ezen.service.MemberService;

@Controller
public class MemberController {
	
	// 자동연결
	@Autowired // DI(Dependency Injection : 의존성 주입)
	// private MemberDAO dao;
	// DAO 대신 Mapper대신 Service 사용
	private MemberService service;
	
	@Autowired // servlet-context에서 생성된 Bean class 를 주입받기
	JavaMailSender mailSender;
	
	@Autowired	// 암호화를위해서 root 추가한 pwEncoder에서 주입받음
	private BCryptPasswordEncoder pwEncoder;
	
	// 멤버등폭 폼
	@RequestMapping("/memberRegister.do")
	public String memberRegister() {
		return "member/registerMember";
	}
	
	// 회원 등록폼에서 ID 중복체크 ajax
	@RequestMapping("/memberIdCheck.do")
	@ResponseBody
	public String memberIdCheck(@RequestParam("uid") String uid) {
		MemberDTO dto = service.memberIdCheck(uid);
		
		//아이디가 중복되거나 빈값이 넘어왔을때
		if(dto != null || "".equals(uid.trim())) {
			return "no";
		}
		// 아이디 중복이 아닌경우
		return "yes";		// 바로 View -> 자바스크립트로 yes 데이터가 넘어감
	}
	
	// 회원 등록폼에서 이메일 인증번호 발송
	@RequestMapping("/memberEmailCheck.do")
	@ResponseBody
	public String memberEmailCheck(@RequestParam("uEmail") String uEmail) {
		System.out.println(uEmail);
		// 인증코드 생성, java.util 안에 UUID를 이용
//		String uuid = UUID.randomUUID().toString(); // c5f3b7e9-4f18-4d90-9664-bc717bfc8834
//		System.out.println(uuid);
		String uuid = UUID.randomUUID().toString().substring(0,6); // 앞에서 6자리 자름
		
		// MimeMessage 객체 생성 : 데이터(Mime 타입) 전송 (예 : text/html, image/jpg)
		MimeMessage mail = mailSender.createMimeMessage();
		// 보내지는 메일내용 셋팅
		String mailContents = "<h3>이메일 주소 확인</h3><br/>"
				+"<span>사용자가 본인임을 확인하려고 합니다. 다음 확인 코드를 입력하세요.</span>"
				+"<h2>"+uuid+"</h2>";
		try {
			// 보내지는 메일제목 셋팅
			mail.setSubject("ez-아카데미 [이메일 인증코드]", "utf-8");
			// 보내지는 메일 내용셋팅
			mail.setText(mailContents, "utf-8", "html");
			// 보내지는 메일 수신자셋팅 - 인터넷 주소체계로 바꿔서 uEmail로 보냄
			mail.addRecipient(RecipientType.TO, new InternetAddress(uEmail));
			mailSender.send(mail);
			return uuid;
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return "fail";		// 바로 View -> 자바스크립트로 fail 데이터가 넘어감
	}
	
	// 멤버등록OK
	@RequestMapping("/memberInsert.do")
	public String memberInsert(MemberDTO dto) {
//		int cnt = dao.memberInsert(dto);
		service.memberInsert(dto);
		return "redirect:memberList.do"; // 바인딩을 하지 않으면 redirect:를 해줘야함
	}
	
	// 리스트 띄우기
	@RequestMapping("/memberList.do")
	public String memberList(Model model) {
//		List<MemberDTO> memberList = dao.memberList();
		List<MemberDTO> memberList = service.memberList();
		model.addAttribute("list", memberList);
		return "member/memberList";
	}
	
	//// ajaxList 띄우기 ////
	// Message Converter API : jackson
	// ==> json 형식의 데이터를 자바객체로 변환 또는 자바객체를 json 형태로 변환
	// 비동기 전송 데이터는 HTTP MSG의 body에 담아서 전송한다.
	// 어노테이션 2종류
	// @ResponseBody : 서버에서 클라이언트로 응답할때
	// @RequestBody : 클라이언트에서 서버로 응답할때
	@RequestMapping("/memberAjaxList.do")
	@ResponseBody
	// 리턴타입 memberList이기에 public List<MemberDTO> 로 적어줌
	public List<MemberDTO> memberAjaxList() {
//		List<MemberDTO> memberList = dao.memberList();
		List<MemberDTO> memberList = service.memberList();
		return memberList;		// 바로 View -> 자바스크립트로 넘어감
	}
	
	// 멤버정보 폼으로 가기
	@RequestMapping("/memberInfo.do") // Model model은 바인딩
	public String memberInfo(int no, Model model) {
//		MemberDTO dto = dao.memberInfo(no);
		MemberDTO dto = service.memberInfo(no);
		model.addAttribute("dto", dto);
		return "member/memberInfo";
	}

	// 멤버정보(인포)폼에서 수정OK 이동
	@RequestMapping("/memberUpdate.do")
	public String memberUpdate(MemberDTO dto) {
//		dao.memberUpdate(dto);
		service.memberUpdate(dto);
		return "redirect:memberList.do";
	}
	
	// 멤버리스트에서 삭제OK
	@RequestMapping("/memberDelete.do")
	public String memberDelete(int no) {
//		int cnt = dao.memberDelete(no);  // cnt는 값을가지고 추가로 어떠한 작업을 하고 싶을때 추가(유효성검사 등)
		service.memberDelete(no);  // cnt는 값을가지고 추가로 어떠한 작업을 하고 싶을때 추가(유효성검사 등)
		return "redirect:memberList.do";
	}
	
	// 멤버 로그인 폼으로 이동 - Get방식
	@GetMapping("/memberLogin.do")
	// 인터셉터 발생시, 무브url의 마지막 주소를 넘겨줌 ==> 로그인폼, 로그인폼OK로 넘겨줌
	public String memberLoginForm(String moveURL, Model model) {	// moveURL 넘길때 코드
	//public String memberLoginForm() {
		model.addAttribute("moveURL", moveURL);	// moveURL 넘길때 코드
		return "login/memberLoginForm";
	}
	
	// 멤버 로그인 OK - Post방식
	@PostMapping("/memberLogin.do")
	// 인터셉터 발생시, 무브url의 마지막 주소를 넘겨줌 ==> 로그인폼, 로그인폼OK로 넘겨줌
	public String memberLogin(MemberDTO dto, HttpServletRequest request, String moveURL, Model model) {	// moveURL 넘길때 코드
	//public String memberLogin(MemberDTO dto) {
		boolean result = service.memberLogin(dto, request);	// moveURL 넘길때 코드
		model.addAttribute("moveURL", moveURL); // moveURL 넘길때 코드
		if(!result) { 		// result 값이 false이면, (로그인이 실패하면)
			return "redirect:memberLogin.do?moveUrl"+moveURL;		 // moveURL 넘길때 코드
			//return "redirect:memberLogin.do";				// redirect: 은 GET방식
		}
		
		// https://developer-talk.tistory.com/406   // 문자열에서 특정 문자열이 포함되어 있는지 확인
		//if(moveURL.contains("null") == true) {		// contains(), indexOf(), lastIndexOf()
		if(moveURL.contains("fileUploadOk") == true) { // 포함되어 있으면 true 리턴
			return "redirect:fileUpload.do";
		} else if(!moveURL.equals("")) {		// moveURL 넘길때 코드
			return "redirect:"+moveURL;	// 인터셉터 발생시 여기로 리턴
		}
		
		return "redirect:/";
	}
	
	// 멤버 로그아웃 - Get방식
	@GetMapping("/memberLogout.do")
	public String memberLogout(HttpSession session) {
		session.invalidate();	// 세션초기화
		return "redirect:/";
	}
	
	// 멤버 아이디 비번 찾기 폼으로 이동 - Get방식
	@GetMapping("/idPwFind.do")
	public String idPwFind(String find, Model model) {
		model.addAttribute("find", find); // find는 아이디찾기인지 비밀번호찾기인지 구분해주는 것을 바인딩해서 뷰에서 뷰로 넘겨줌
		return "login/idPwFind";
	}
	
	// 아이디 찾기 OK
	@PostMapping("findId.do")
	@ResponseBody
	public String findId(MemberDTO dto) {
		String findId = service.findId(dto);
		System.out.println("findId: "+findId);
		return findId;
	}
	
	// 비밀번호 찾기 OK // 임시비밀번호 발급 이후 임시비밀번호로 로그인
	@PostMapping("findPw.do")
	@ResponseBody
	public int findPw(String uid, String uEmail, MemberDTO dto) {	
		int n = service.findPw(uid, uEmail, dto);
		return n;
	}
	
	// 로그인 이후 헤더에서 마이프로필 폼 보기 - Get방식
	@GetMapping("/myProfile.do")
	public String myProfile() {
		return "member/myProfile";
	}
	
	// 마이프로필폼 -> 현재 비밀번호 옵션들 확인
	@PostMapping("pwCheck.do")
	@ResponseBody			// 서비스 단에서 session.setAttribute("loginDTO", loginDTO); 에 DTO가 저장되어 있음 getAttribute로 가져옴
	public String pwCheck(String pw, HttpSession session) {
		// DB에서 확인할 필요없이 세션에 바인딩된 값을 가져와서 확인함 --> DB까지 갈필요가 없어 시간 절약
		// 세션에서 바인딩 된 값을 가져올때는 (Object)타입이라 (MemberDTO)로 형변환을 해준다.
		MemberDTO dto = (MemberDTO)session.getAttribute("loginDTO");
		
		String dbPw = dto.getPw();	// dbPw : DB에서 가져온 비번, pw : 사용자가 직접 입력한 비번(ajax)
		String chkResult = "";
		
		if(pwEncoder.matches(pw, dbPw) || pw.equals(dbPw)) {	// 비번일치 // 기존비번 로그인 || pw.equals(dbPw)
			chkResult = "ok";
		} else {
			chkResult = "no";
		}
		return chkResult;
	}
	
	// 마이프로필 폼 -> 비밀번호 변경 OK
	@PostMapping("pwChange.do")
	@ResponseBody // 자바객체를 클라이언트에 전송할 데이터를 http 메세지 바디에 사용하여 보냄 // 네트워크 전송을 할 수 있도록 Json으로 변환(jackson API)
	// @RequestBody는 Http 메세지의 바디에 있는 Json 데이터를 읽어오는데 자바객체로 변환까지 함께 함 (jackson lib)
	public int pwChange(@RequestBody MemberDTO dto) {
		String inputPw = dto.getPw();		// 회원가입시 입력된 비번
		String chiperPw = pwEncoder.encode(inputPw);	// 암호화된 비번으로 다시 dto에 셋팅 후 전달
		dto.setPw(chiperPw);
		int n = service.modifyPw(dto);
		
		return n;
	}
}
