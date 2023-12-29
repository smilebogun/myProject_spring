package kr.ezen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.ezen.pwEncoder.domain.ReplyDTO;
import kr.ezen.pwEncoder.domain.ReplyPageDTO;
import kr.ezen.service.ReplyService;

@RestController	// Rest API : @Controller + @ResponseBody
@RequestMapping("/replies")		// 기존에는 사용안했는데, 댓글 컨트롤러에서는 사용해봄
public class ReplyController {

	@Autowired
	private ReplyService service;
	
	// 댓글등록
	@PostMapping("/new") // 매핑방식 post // DTO에 댓글을 추가하는거라 @RequestBody가 필요하다?
	public String create(@RequestBody ReplyDTO rDto) {
		
		int n = service.register(rDto);
		return n == 1 ? "success" : "fail";
	}
	
	// 댓글삭제 // ("/{rno}") {} 는 값만적는 가변인자라서 @PathVariable // @RequestParam ?name=홍길동 ?변수=이름을 같이 적는다.
	// reply/replies/3		--> @PathVariable
	// reply/replies?rno=5	--> @RequestParam	
	@DeleteMapping("/{rno}")	// 삭제할때 DB에서 번호를 가져와야되서 @PathVariable가 필요하다?
	public String remove(@PathVariable("rno") int rno) {
		int n = service.remove(rno);
		return n == 1 ? "success" : "fail";
	};
	
	// 댓글조회
	@GetMapping("/{rno}")
	public ReplyDTO read(@PathVariable("rno") int rno) {
		ReplyDTO rDto = service.read(rno);
		return rDto;
		//return service.read(rno); //위 두줄과 동일
	}
	
	// 댓글수정
	@PutMapping("/{rno}")
	public String modify(@RequestBody ReplyDTO rDto) {
	//public String modify(@PathVariable("rno") int rno, @RequestBody ReplyDTO rDto) {
		//rDto.setRno(rno);
		int n = service.modify(rDto);
		return n == 1 ? "success" : "fail";
	}
	
	// 특정게시글에 대한 댓글조회(리스트) - 댓글조회 1개 조회하는것과 구분하기 위해서 앞에 /list를 붙임
	
//	@GetMapping("/list/{bid}") // 페이징처리 이전코딩
//	public List<ReplyDTO> getList(@PathVariable("bid") int bid){
//		List<ReplyDTO> list = service.getList(bid);
//		return list;
//	}
	//GetMapping("/list/{bid}")  // 페이징처리 이전코딩 2번째
	//public List<ReplyDTO> getList(@PathVariable("bid") int bid, @PathVariable("viewPage") int viewPage){
	//	List<ReplyDTO> list = service.getList(bid, viewPage);
	//	return list;
	//}
	
	@GetMapping("/list/{bid}/{viewPage}")
	public ReplyPageDTO getList(@PathVariable("bid") int bid, @PathVariable("viewPage") int viewPage){
		ReplyPageDTO rPageDto = service.getList(bid, viewPage);
		return rPageDto;
	}
	
}


