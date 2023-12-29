package kr.ezen.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.ezen.pwEncoder.domain.MemberDTO;

@Service
public interface MemberService {
	
	// 멤버 등폭폼에서 ID체크
	MemberDTO memberIdCheck(String uid);
	
	// 멤버 등폭폼에서 이메일 인증보내기
	MemberDTO memberEmailCheck(String uEmail);

	// 멤버 등록OK
	void memberInsert(MemberDTO dto);
	
	// 게시판 전체 리스트 가져오기
	List<MemberDTO> memberList();

	// 멤버 정보보기
	MemberDTO memberInfo(int no);
	
	// 멤버 수정하기 OK
	void memberUpdate(MemberDTO dto);

	// 멤버 삭제하기
	void memberDelete(int no);

	// 멤버 로그인 OK
	boolean memberLogin(MemberDTO dto, HttpServletRequest request);

	// 아이디 찾기 OK
	String findId(MemberDTO dto);

	// 비밀번호 찾기 OK // 임시비밀번호 발급 이후 임시비밀번호로 로그인
	int findPw(String uid, String uEmail, MemberDTO dto);

	// 마이프로필 폼 -> 비밀번호 변경 OK
	int modifyPw(MemberDTO dto);


}
