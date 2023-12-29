package kr.ezen.pwEncoder.domain;

import java.util.List;

import lombok.Data;

@Data
public class ReplyPageDTO {
	
	private int viewPage = 1; //  현재 페이지 (current Page)
	private int blockSize = 5; // 블럭 사이즈?
	private int blockNum;		// 현재 블럭의 위치
	private int blockStart;		// 블럭의 시작 값
	private int blockEnd;		// 블럭의 마지막 값
	
	private int prevPage;		// 이전 페이지
	private int nextPage;		// 다음 페이지
	private int totalPage;		// 전체 페이지 수
	
	private int cntPerPage = 5; // 각 페이지별 게시글 수 (limit)
	private int startIndex;	// 각 페이지별 시작값 - offset (0, 10, 20, 30,....)
	
	///////////// 검색된 게시글 수 설정, 페이징 처리를 위해 totalCnt 추가 /////////////
	private int totalCnt;

	// List에 페이징처리, Page정보를 담기위해 추가 ==> 게시판리스트 + 페이징리스트
	private List<ReplyDTO> list;
	
	
	// 위 멤버변수 값들을 셋팅하는 함수
	public void setValue(int totalCnt) {
		
		// 검색된 게시글 수 설정, 검색처리를 위해 전체 게시글 수 설정
		this.totalCnt = totalCnt;
		
		// 전체 페이지 수					// 최종 게시글 수 / 각 페이지별 게시글 수
		this.totalPage = (int)Math.ceil((double)totalCnt/cntPerPage);
									
		// 각 페이지별 시작 값 0,10,20,30,....
		this.startIndex = (viewPage - 1) * cntPerPage;
		
		// 현재 페이지 블럭의 위치, 0부터 시작
		this.blockNum = (viewPage - 1) / blockSize;
		
		// 블럭의 시작값, 1,6,11,16....
		this.blockStart = (blockSize * blockNum) + 1;
		
		// 블럭의 마지막 값
		this.blockEnd = blockStart + (blockSize - 1);
		if(blockEnd > totalPage) { 
			this.blockEnd = totalPage;
		}
		
		// 이전, 다음페이지
		this.prevPage = blockStart -1;
		this.nextPage = blockEnd +1;		
	}

	// 1. 전체 게시글 수 구해오기
	// 2. totalPage 전체 페이지 수 구하기
	
	///////////// 검색된 게시글 수 설정, 페이징 처리를 위해 totalCnt 추가 /////////////
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	
}
