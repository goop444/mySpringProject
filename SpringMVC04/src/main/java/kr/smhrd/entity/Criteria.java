package kr.smhrd.entity;

import lombok.Data;

@Data
// 페이징 처리에서 기준 클래스
public class Criteria {
	private int page; // 만약 page가 3이면 3페이지를 보는거 1이면 1페이지
	private int perPageNum; // 한페이지당 몇개의 게시글이 필요한가.
	// 검색에 필요한 멤버 변수 만들기
	private String type;
	private String keyword;
	
	
	// 초기화
	public Criteria() {
		this.page=1;
		this.perPageNum=3;
	}
	
	// 3. 선택한 페이지에 해당하는 게시글의 시작번호 구하기
	// 1페이지 시작 번호는 0~perPageNum, 2page :10~perPageNum, 3page : 20~perPageNum까지
	// select * from reply order by bgroup desc, bseq asc
	// LIMIT offset, 10개수
	public int getPageStart() {
		return ((page-1)*perPageNum);
	}

}
