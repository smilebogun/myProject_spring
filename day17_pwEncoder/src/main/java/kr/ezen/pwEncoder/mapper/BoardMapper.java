package kr.ezen.pwEncoder.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.ezen.pwEncoder.domain.BoardDTO;
import kr.ezen.pwEncoder.domain.PageDTO;

public interface BoardMapper {
	
	// 게시글 등록
	void insertBoard(BoardDTO dto);

	// 게시판 전체 리스트 가져오기 (조회하는게 dto랑 resultType="BoardDTO" 이 쓰임)
	List<BoardDTO> listBoard(PageDTO pDto);
	
	// 게시글 상세보기 (조회하는게 dto랑 resultType="BoardDTO" 이 쓰임)
	BoardDTO viewBoard(int bid);

	// 게시글 수정하기 OK
	void updateBoard(BoardDTO dto);

	// 게시글 삭제하기
	void deleteBoard(int bid);
	
	// 조회수 추가
	void hitAdd(int bid);
	
	// 전체 게시글 수 구해오는 작업
	//int totalCnt(); // 검색어 없을경우
	int totalCnt(PageDTO pDto); // 검색어 있을경우
	
	// 댓글 추가, 삭제시 replyCnt 수정
	// DTO가 아닌 기본형 같은경우 @Param("bid") 을 적어줘야함
	void updateReplyCnt(@Param("bid") int bid, @Param("n") int n);
	
}
