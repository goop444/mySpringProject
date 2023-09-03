package kr.smhrd.entity;

import lombok.Data;

@Data
public class Member { //table : member
	// User로는 만들지 말자 스프링 내부에 user라는 클래스가 있기 때문에 Member로 만드는게 좋다.
	private int idx;
	private String username;
	private String password; 
	private String name;
	private String email;
	
}
