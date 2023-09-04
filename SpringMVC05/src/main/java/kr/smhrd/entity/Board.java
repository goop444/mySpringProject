package kr.smhrd.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
// 게시판(object) : 번호, 제목, 내용, 작성자, 작성일, 조회수 ...
public class Board {
	
	//property(속성)프로퍼티
	private int num;
	private String username; // 사용자아이디
	private String title;
	private String content;
	private String writer;
	private String indate;
	private int count;
	
	// setter, getter 자동 생성 -> Lombok API
	// 답변형 게시판에 추가
	private int bgroup;
	private int bseq;
	private int blevel;
	private int bdelete; //0(정상), 1( )
}
