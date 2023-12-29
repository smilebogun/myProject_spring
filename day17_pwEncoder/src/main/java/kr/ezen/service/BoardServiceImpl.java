package kr.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ezen.pwEncoder.domain.BoardDTO;
import kr.ezen.pwEncoder.domain.PageDTO;
import kr.ezen.pwEncoder.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper mapper;
	
	@Override
	public void registerBoard(BoardDTO dto) {
		mapper.insertBoard(dto);
	}

//	@Override  // 아래 페이징처리 추가된 리스트
//	public List<BoardDTO> listBoard() {
////		List<BoardDTO> list = mapper.listBoard();
////		return list;
//		
//		return mapper.listBoard(); 
//		// 위에 두라인과 동일
//	}
	
	@Override // 페이징처리
	public List<BoardDTO> listBoard(PageDTO pDto) {

		// 페이징 처리
		//int totalCnt = mapper.totalCnt(); // 검색어 없을경우
		int totalCnt = mapper.totalCnt(pDto);	// 검색어 있을경우
		pDto.setValue(totalCnt, pDto.getCntPerPage());
		
		return mapper.listBoard(pDto); 
	}

	@Override // public "BoardDTO" 뒤에는 리턴값 // 즉, 리턴은 BoardDTO 값
	public BoardDTO viewBoard(int bid, String mode) {
		// 글 상세보이길 경우만 hitAdd호출
		if(mode.equals("y")) {
			mapper.hitAdd(bid);
		}
		return mapper.viewBoard(bid);
	}

	@Override
	public void modifyBoard(BoardDTO dto) {
		mapper.updateBoard(dto);
	}

	@Override
	public void removeBoard(int bid) {
		mapper.deleteBoard(bid);
	}

//	@Override
//	public void hitAdd(int bid) {
//		mapper.hitAdd(bid);
//	}
	

}
