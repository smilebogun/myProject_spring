package kr.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ezen.pwEncoder.domain.ReplyDTO;
import kr.ezen.pwEncoder.domain.ReplyPageDTO;
import kr.ezen.pwEncoder.mapper.BoardMapper;
import kr.ezen.pwEncoder.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired		// 주입이 한줄에 하나 먹음.
	private ReplyMapper mapper;
	
	@Autowired		// 주입이 한줄에 하나 먹음.
	private BoardMapper boardMapper;

	// 댓글등록
	@Transactional	// 트렌잭션처리
	@Override
	public int register(ReplyDTO rDto) {
		boardMapper.updateReplyCnt(rDto.getBid(), 1);	// bid를 가져오는게 관건
		int n = mapper.insert(rDto);
		return n;
	}

	// 댓글삭제
	@Transactional	// 트렌잭션처리
	@Override
	public int remove(int rno) {
		ReplyDTO rDto = mapper.select(rno);		// bid를 가져오는게 관건
		boardMapper.updateReplyCnt(rDto.getBid(), -1);
		return mapper.delete(rno);
	}

	// 댓글조회
	@Override
	public ReplyDTO read(int rno) {
		return mapper.select(rno);
	}

	// 댓글수정
	@Override
	public int modify(ReplyDTO rDto) {
		int n = mapper.update(rDto);
		return n;
	}

	// 특정게시글에 대한 댓글조회(리스트)
	@Override
//	public List<ReplyDTO> getList(int bid) { // 페이징처리 이전코딩
//		return mapper.getListByBid(bid);
//	}
	//public List<ReplyDTO> getList(int bid, int viewPage) { // 페이징처리 이전코딩
	public ReplyPageDTO getList(int bid, int viewPage) {	// 서비스 Impl에서 ReplyPageDTO에 List<ReplyDTO>를 넣어버림
		int replyCnt = mapper.replyCnt(bid);
		ReplyPageDTO rPageDTO = new ReplyPageDTO();
		
		rPageDTO.setViewPage(viewPage);	// 뷰페이지가 바뀔때마다 새롭게 값을 셋팅해줌
		rPageDTO.setValue(replyCnt);	// 뷰페이지가 윗줄에서 넘어왔기때문에 DTO에서 여러 값들이 계산이 됌
		List<ReplyDTO> list = mapper.getListByBid(bid, rPageDTO.getStartIndex(), rPageDTO.getCntPerPage());
		rPageDTO.setList(list);
		return rPageDTO;
	}

	// 특정 게시글 int bid 에 댓글수를 구해오는 작업
	@Override
	public int replyCnt(int bid) {
		return mapper.replyCnt(bid);
	}

}
