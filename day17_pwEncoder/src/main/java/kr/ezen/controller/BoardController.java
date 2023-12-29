package kr.ezen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ezen.pwEncoder.domain.BoardDTO;
import kr.ezen.pwEncoder.domain.PageDTO;
import kr.ezen.service.BoardService;

@Controller
// @RequestMapping("/board") // 아래 .do의 별칭이용 
// 이걸 사용하면 redirect:/board/boardList.do 이렇게 사용해야 함
public class BoardController {

	@Autowired
	private BoardService service;
	
	// 게시글 등록폼 뷰  // GET
	@GetMapping("/registerBoard.do")
	public String registerBoard() {
		return "board/registerBoard";
	}
	
	// 게시글 등록 OK  // POST
	@PostMapping("/registerBoard.do")
	public String registerBoard(BoardDTO dto) { // PageDTO pDto 페이징처리 현재페이지로 이동
		// 수동으로 값넣기
//		for(int i=1; i<=113; i++) {
//			BoardDTO bDto = new BoardDTO();
//			bDto.setSubject(i + "번째 제목");
//			bDto.setContents(i + "번째 내용.");
//			bDto.setWriter("작성자" + (i%10));
//			service.registerBoard(bDto);
//		}
		
		service.registerBoard(dto);
		return "redirect:boardList.do"; 
		// 재호출이라 포워딩 즉, 바인딩을 할 필요가 없음
		// 바인딩을 하지 않으면 redirect:를 해줘야함
	}
	
	// 리스트  // @RequestMapping = Get, Post 둘다 지원
	@RequestMapping("/boardList.do")  // Stirng searchType, keyword
	public String boardList(PageDTO pDto, Model model) {
		List<BoardDTO> boardList = service.listBoard(pDto);
		model.addAttribute("list", boardList);
		model.addAttribute("pDto", pDto);	// 바인딩되는 pDto는 serviceImpl에서 셋팅된 pDto

		return "board/boardList";
	}
	
	// 게시판 게시글 인포 -> 수정 또는 삭제로 들어감
	@GetMapping("/viewBoard.do") // Model model은 바인딩
	public String viewBoard(int bid, PageDTO pDto, Model model) {	// PageDTO pDto 페이징처리 현재페이지로 이동
		// service.hitAdd(bid);  // 뷰 클릭시 조회수 추가 // 밑에 modifyBoard.do 수정폼 이동시에는 추가 안됌
								// 하지만 뷰쪽에서만 역할을 해야함 그래서 Service쪽에서 hitAdd를 주석처리 하고 mode를 넣어줌
		BoardDTO dto = service.viewBoard(bid, "y");
		model.addAttribute("dto", dto);
		model.addAttribute("pDto", pDto);	// 페이징처리 현재페이지로 이동, 바인딩
		return "board/viewBoard";
	}
	
	// 수정하기 클릭 -> 수정폼으로 이동 // GET
	@GetMapping("/modifyBoard.do") // PageDTO pDto 페이징처리 현재페이지로 이동
	public String modifyBoard(int bid, PageDTO pDto, Model model) {
		System.out.println("@@@@@@@@@@@@@@@");
		BoardDTO dto = service.viewBoard(bid, "n");
		model.addAttribute("dto", dto);
		model.addAttribute("pDto", pDto);	// 페이징처리 현재페이지로 이동, 바인딩
		return "board/modifyBoard";
	}
	
	// 게시글 수정하기 OK // POST
	@PostMapping("/modifyBoard.do")
	public String modifyBoard(BoardDTO dto, PageDTO pDto, Model model) {
		System.out.println("###########@@@@@@@@@@@@@@@@");
		service.modifyBoard(dto);
		
		int viewPage= pDto.getViewPage();			// 두줄로 페이징처리 현재페이지로 이동, 바인딩
		model.addAttribute("viewPage", viewPage);	// 두줄로 페이징처리 현재페이지로 이동, 바인딩
		model.addAttribute("searchType", pDto.getSearchType());	// 한줄로 페이징처리 현재페이지로 이동, 바인딩
		model.addAttribute("keyword", pDto.getKeyword());	// 한줄로 페이징처리 현재페이지로 이동, 바인딩
		model.addAttribute("cntPerPage", pDto.getCntPerPage());	// 한줄로 페이징처리 현재페이지로 이동, 바인딩
		return "redirect:boardList.do";				// redirect:시에 model을 바인딩을 할 경우 자바객체는 퀘리스트링으로 전달이 안된다.
	}												// 단, int, String인 경우에는 쿼리스트링으로 전달가능
	
	@GetMapping("/removeBoard.do")
	public String removeBoard(int bid, PageDTO pDto, Model model) {
		service.removeBoard(bid);  // cnt는 값을가지고 추가로 어떠한 작업을 하고 싶을때 추가(유효성검사 등)
		model.addAttribute("bid", bid);
		
		int viewPage= pDto.getViewPage();			// 두줄로 페이징처리 현재페이지로 이동, 바인딩
		model.addAttribute("viewPage", viewPage);	// 두줄로 페이징처리 현재페이지로 이동, 바인딩
		model.addAttribute("searchType", pDto.getSearchType());	// 한줄로 페이징처리 현재페이지로 이동, 바인딩
		model.addAttribute("keyword", pDto.getKeyword());	// 한줄로 페이징처리 현재페이지로 이동, 바인딩
		model.addAttribute("cntPerPage", pDto.getCntPerPage());	// 한줄로 페이징처리 현재페이지로 이동, 바인딩
		return "redirect:boardList.do";				// redirect:시에 model을 바인딩을 할 경우 자바객체는 퀘리스트링으로 전달이 안된다.
	}												// 단, int, String인 경우에는 쿼리스트링으로 전달가능
	
}
