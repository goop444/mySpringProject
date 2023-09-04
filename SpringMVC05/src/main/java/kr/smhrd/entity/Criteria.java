package kr.smhrd.entity;

import lombok.Data;

@Data
// 페이징 처리의 기준클래스
public class Criteria {
	private int page;
	private int perPageNum;
	// 검색에 필요한 변수 추가
	private String type;
	private String keyword;
	
	public Criteria() {
		this.page=1;
		this.perPageNum=3; //=3
	}
	// 3. 선택한 페이지에 해당하는 게시글의 시작번호 구하기
	// 1page : 1~perPageNum, 2page : 11~perPageNum, 3page : 21~perPageNum
	// select * from reply order by bgroup desc, bseq asc
	// LIMIT offset, 10
	public int getPageStart() {
		
		return ((page-1)*perPageNum);
	}
	
}
