package kr.ezen.service;

import java.util.List;

import kr.ezen.pwEncoder.domain.ReplyDTO;
import kr.ezen.pwEncoder.domain.ReplyPageDTO;

public interface ReplyService {
	
	// 서비스쪽에서는 비즈니스 냄새가 나게 이름을 변경
	
	// 댓글등록
	int register(ReplyDTO rDto);
	
	// 댓글삭제
	int remove(int rno);

	// 댓글조회
	ReplyDTO read(int rno);

	// 댓글수정
	int modify(ReplyDTO rDto);

	// 특정게시글에 대한 댓글조회(리스트)
	//List<ReplyDTO> getList(int bid, int viewPage); // 페이징처리 이전코딩
	ReplyPageDTO getList(int bid, int viewPage);
	
	// 특정 게시글 int bid 에 댓글수를 구해오는 작업
	int replyCnt(int bid);
	
}
