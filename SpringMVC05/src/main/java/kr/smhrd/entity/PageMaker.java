package kr.smhrd.entity;

import lombok.Data;

@Data
public class PageMaker {
	private Criteria cri;
	private int displayPageNum=5;
	private int totalCount; // 전체 게시글 수 : select count(*) from reply
	private int startPage;
	private int endPage;
	private boolean prev; // true, false
	private boolean next; // true, false
	// totalCount의 값이 세팅이 되면 makePage()를 호출
	public void setTotalCount(int totalCount) {
		this.totalCount=totalCount;
		makePage();
	}
	
	
	// 페이지 디스플레이에 필요한 계산 메서드
	public void makePage() {
		// 1. 선택한 페이지의 화면에 보여질 마지막 페이지 번호
												// 4/10.0=>0.4=>1.0*10=10.0
		endPage= (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		// 2. 선택한 페이지의 화면에 보여질 싲가 페이지 번호
		startPage=(endPage-displayPageNum)+1;
		// 3. endPage의 유효성 검사 : 실제마지막페이지를 구하기
		int tempEndPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
		if(tempEndPage<endPage) {
			endPage=tempEndPage;
		}
		// 4. prev
		prev = (startPage!=1) ? true : false;
		// 5. next
		next = (endPage<tempEndPage) ? true : false; 
	}
}
