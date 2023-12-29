package kr.ezen.service;

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
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ezen.pwEncoder.domain.MemberDTO;
import kr.ezen.pwEncoder.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired // root-context에서 생성된 Bean class 를 주입받기 // servlet에서 생성된건 받지 못함
	JavaMailSender mailSender;
	
	@Autowired	// 암호화를위해서 root 추가한 pwEncoder에서 주입받음
	private BCryptPasswordEncoder pwEncoder;
	
	// 멤버 등록OK
	@Override
	public void memberInsert(MemberDTO dto) {
		String inputPw = dto.getPw();		// 회원가입시 입력된 비번
		String chiperPw = pwEncoder.encode(inputPw);	// 암호화된 비번으로 다시 dto에 셋팅 후 전달
		dto.setPw(chiperPw);
		mapper.memberInsert(dto);
	}

	// 멤버 리스트
	@Override // 페이징처리
	public List<MemberDTO> memberList() {
		return mapper.memberList(); 
	}

	// 멤버 정보
	@Override // public "BoardDTO" 뒤에는 리턴값 // 즉, 리턴은 BoardDTO 값
	public MemberDTO memberInfo(int no) {
		return mapper.memberInfo(no);
	}

	// 멤버 업데이트
	@Override
	public void memberUpdate(MemberDTO dto) {
		mapper.memberUpdate(dto);
	}

	// 멤버 삭제
	@Override
	public void memberDelete(int no) {
		mapper.memberDelete(no);
	}

	// 멤버 ID 중복체크
	@Override
	public MemberDTO memberIdCheck(String uid) {
		return mapper.memberIdCheck(uid);
	}
	
	// 멤버 이메일 인증번호 발송
	@Override
	public MemberDTO memberEmailCheck(String uEmail) {
		return mapper.memberEmailCheck(uEmail);
	}

	// 멤버 로그인 OK
	@Override
	public boolean memberLogin(MemberDTO dto, HttpServletRequest request) {
		HttpSession session = request.getSession(); // 서비스계층에서 세션객체를 불러온다
		
		// 입력아이디와 일치하는 회원정보를 dto에 담아서
		MemberDTO loginDTO = mapper.memberLogin(dto);

/////////////////////////// 암호화 하기 전
//		if(loginDTO != null) {				// 일치하는 아이디가 있는 경우
//			String inputPw = dto.getPw();	// dto.getPw() 사용자가 입력한 비번
//			String dbPw = loginDTO.getPw();	// loginDTO.getPw() DB에서 가져온 비번
//			
//			if(inputPw.equals(dbPw)) {		// 비번일치
//				session.setAttribute("loginDTO", loginDTO);
//				return true;
//			} else { 						// 비번 불일치
//				return false;
//			}
//		}
///////////////////////////	
		
		if(loginDTO != null) {				// 일치하는 아이디가 있는 경우
		String inputPw = dto.getPw();	// dto.getPw() 사용자가 입력한 비번
		String dbPw = loginDTO.getPw();	// loginDTO.getPw() DB에서 가져온 비번
		
		if(pwEncoder.matches(inputPw, dbPw) || inputPw.equals(dbPw)) {		// 비번일치 // 기존비번 로그인 || inputPw.equals(dbPw)
			session.setAttribute("loginDTO", loginDTO);
			return true;
		} else { 						// 비번 불일치
			return false;
		}
	}
		
		return false;
	}

	// 아이디 찾기 OK
	@Override
	public String findId(MemberDTO dto) {
		String findId = mapper.findId(dto);
		System.out.println("##findId: "+findId);
		return findId;
	}

	// 비밀번호 찾기 OK // 임시비밀번호 발급 이후 임시비밀번호로 로그인
	@Override
	public int findPw(String uid, String uEmail, MemberDTO dto) {
		// 임시비밀번호 생성, java.util 안에 UUID를 이용
//		String uuid = UUID.randomUUID().toString(); // c5f3b7e9-4f18-4d90-9664-bc717bfc8834
//		System.out.println(uuid);
		String tempPw = UUID.randomUUID().toString().substring(0,8); // 앞에서 6자리 자름
		
		String chiperPw = pwEncoder.encode(tempPw);	// 암호화된 비번으로 다시 dto에 셋팅 후 전달
		dto.setPw(chiperPw);
		
		// MimeMessage 객체 생성 : 데이터(Mime 타입) 전송 (예 : text/html, image/jpg)
		MimeMessage mail = mailSender.createMimeMessage();
		// 보내지는 메일내용 셋팅
		String mailContents = "<h3>임시 비밀번호 발급</h3><br/>"
				+"<h2>"+tempPw+"</h2>"
				+"<p>임시 비밀번호가 발급되었습니다. 로그인 이후에 비밀번호를 재설정 해주세요.</p>";
				
		try {
			// 보내지는 메일제목 셋팅
			mail.setSubject("ez-아카데미 [임시 비밀번호]", "utf-8");
			// 보내지는 메일 내용셋팅
			mail.setText(mailContents, "utf-8", "html");
			// 보내지는 메일 수신자셋팅 - 인터넷 주소체계로 바꿔서 uEmail로 보냄
			mail.addRecipient(RecipientType.TO, new InternetAddress(uEmail));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		int n = mapper.findPw(uid, uEmail, chiperPw);
		return n;
	}

	// 마이프로필 폼 -> 비밀번호 변경 OK
	@Override
	public int modifyPw(MemberDTO dto) {
		int n = mapper.updatePw(dto);
		return n;
	}

}
