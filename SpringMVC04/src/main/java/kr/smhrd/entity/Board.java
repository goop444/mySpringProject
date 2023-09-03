package kr.smhrd.entity;
// 게시판(Object) : 번호, 제목, 내용, 작성자, 작성일, 조회수,.....<<<Modeling ; class == 모델링 도구

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	// proprety(속성)
	private int num;
	private String username;
	private String title;
	private String content;
	private String writer;
	private Date indate;
	private int count;
	//setter, getter 자동 생성 -> Lombok API(코드 다이어트 API)
	// 답변할 게시판에 추가
	private int bgroup; // 부모와 답글을 하나로 묶는 역할 내림차순
	private int bseq; // 답글의 순서 오름차순
	private int blevel; // 답글 들여쓰기
	private int bdelete; // 게시글의 삭제 여부 0: 정상글 1:삭제된 글
}
