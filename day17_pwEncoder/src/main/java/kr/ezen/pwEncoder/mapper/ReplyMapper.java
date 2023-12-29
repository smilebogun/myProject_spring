package kr.ezen.pwEncoder.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.ezen.pwEncoder.domain.ReplyDTO;
import kr.ezen.pwEncoder.domain.ReplyPageDTO;

public interface ReplyMapper {
	
	// 매퍼쪽에서는 SQL 냄새가 나게 이름을 변경
	
	// 댓글등록
	int insert(ReplyDTO rDto);
	
	// 댓글삭제
	int delete(int rno);

	// 댓글조회
	ReplyDTO select(int rno);

	// 댓글수정
	int update(ReplyDTO rDto);

	// 특정게시글에 대한 댓글조회(리스트)
	// List<ReplyDTO> getListByBid(int bid); // 페이징처리 이전코딩
	// DTO가 아닌 기본형 같은경우 @Param("bid") 을 적어줘야함
	List<ReplyDTO> getListByBid(@Param("bid") int bid, 
				@Param("startIndex") int startIndex, @Param("cntPerPage") int cntPerPage);
	
	// 특정 게시글 int bid 에 댓글수를 구해오는 작업
	int replyCnt(int bid);
	
}
