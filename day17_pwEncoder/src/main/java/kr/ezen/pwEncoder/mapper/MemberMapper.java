package kr.ezen.pwEncoder.mapper;

import java.util.List;

import kr.ezen.pwEncoder.domain.MemberDTO;

// @Mapper 
// DAO대신 Mapper 인터페이스로 사용하기 @Mapper 생략가능
public interface MemberMapper {
	
	// 회원 등록(가입)
	void memberInsert(MemberDTO dto);
	
	// 회원 전체 리스트 가져오기 (조회하는게 dto랑 resultType="MemberDTO" 이 쓰임)
	List<MemberDTO> memberList();
	
	// 회원정보 조회 (조회하는게 dto랑 resultType="MemberDTO" 이 쓰임)
	MemberDTO memberInfo(int no);
	
	// 회원정보 수정OK
	void memberUpdate(MemberDTO dto);
	
	// 회원 삭제
	void memberDelete(int no);
 
	// 회원가입시 중복체크
	MemberDTO memberIdCheck(String uid);

	// 회원가입시 인증메일 발송
	MemberDTO memberEmailCheck(String uEmail);

	// 멤버 로그인 OK
	MemberDTO memberLogin(MemberDTO dto);

	// 아이디 찾기 OK
	String findId(MemberDTO dto);

	// 비밀번호 찾기 OK // 임시비밀번호 발급 이후 임시비밀번호로 로그인
	int findPw(String uid, String uEmail, String chiperPw);

	// 마이프로필 폼 -> 비밀번호 변경 OK
	int updatePw(MemberDTO dto);
}
