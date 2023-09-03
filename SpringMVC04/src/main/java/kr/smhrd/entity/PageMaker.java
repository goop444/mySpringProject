package kr.smhrd.entity;

import lombok.Data;

@Data
public class PageMaker {
	private Criteria cri;// 기존 클래스가 가지고 있는 정보가 필요
	private int displayPageNum=3; // 몇개의 페이지 수를 보여줄건가
	private int totalCount; // 전체 게시글의 수 : select count(*) from reply를 활용해서 전체 게시글 수를 가져올 예정 **totalCount를 세팅하고 나머지를 구할 수 있다.
	private int startPage; // 내가 선택한 페이지의 start와 end를 알아야 반복문으로 뿌릴수가 있다.
	private int endPage; 
	private boolean prev; // true,false : true인 경우에만 버튼이 활성화 false는 비활성화 
	private boolean next; // true,false
	
	
	// totalCount의 값이 세팅이 되면 makePage()호출
	public void setTotalCount(int totalCount) {
		//이미 setter가 있지만 makePage()를 호출하기 위해서 새로 만들어줌
		this.totalCount=totalCount;
		makePage();
		
	}
	
	
	//*****중요) 페이지 디스플레이에 필요한 계산 메소드
	public void makePage() {
		// 1.선택한 페이지의 화면에 보여질 마지막(end) 페이지 번호를 먼저 구해야 한다. end를 구하면 start는 자동으로 나오기 때문에
		// getpage가 4라면 displayPageNum으로 나눈 값으로 ceil을 하면 가장 가까운 정수가 나오고 다시displayPageNum을 하면 최종 마지막 값이 나온다.
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		// 2. 선택한 페이지의 화면에 보여질 시작 페이지 번호
		startPage=(endPage-displayPageNum)+1;
		// end Page의 유효성 검사 : 실제 마지막페이지 구하기
		int tempEndPage =(int)Math.ceil(totalCount/(double)cri.getPerPageNum());
		if(endPage>tempEndPage) {
			endPage = tempEndPage;
		}
		// 4. prev 존재 여부
		prev=(startPage!=1) ? true : false;
		// 5. next 존재 여부
		next=(endPage<tempEndPage) ? true : false;
		
		
	}
	
	
}
