package kr.ezen.pwEncoder.domain;

public class PageDTO {
	
	private int viewPage = 1; //  현재 페이지 (current Page)
	private int blockSize = 5; // 블럭 사이즈?
	private int blockNum;		// 현재 블럭의 위치
	private int blockStart;		// 블럭의 시작 값
	private int blockEnd;		// 블럭의 마지막 값
	
	private int prevPage;		// 이전 페이지
	private int nextPage;		// 다음 페이지
	private int totalPage;		// 전체 페이지 수
	
	private int cntPerPage = 10; // 각 페이지별 게시글 수 (limit)
	private int startIndex;	// 각 페이지별 시작값 - offset (0, 10, 20, 30,....)
	
	///////////// search /////////////
	//private String searchForm;
	private String searchType;
	private String keyword;
	
	///////////// 검색된 게시글 수 설정, 페이징 처리를 위해 totalCnt 추가 /////////////
	private int totalCnt;

	
	// 위 멤버변수 값들을 셋팅하는 함수
	public void setValue(int totalCnt, int cntPerPage) {
		
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

	
	// 게터, 세터
	public int getViewPage() {
		return viewPage;
	}

	public void setViewPage(int viewPage) {
		this.viewPage = viewPage;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getBlockNum() {
		return blockNum;
	}

	public void setBlockNum(int blockNum) {
		this.blockNum = blockNum;
	}

	public int getBlockStart() {
		return blockStart;
	}

	public void setBlockStart(int blockStart) {
		this.blockStart = blockStart;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCntPerPage() {
		return cntPerPage;
	}

	public void setCntPerPage(int cntPerPage) {
		this.cntPerPage = cntPerPage;
	}

	public int getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}
	
	///////////// search /////////////
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	///////////// 검색된 게시글 수 설정, 페이징 처리를 위해 totalCnt 추가 /////////////
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}


	
}
