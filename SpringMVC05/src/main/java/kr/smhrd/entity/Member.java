package kr.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member { // table : member
	private int idx;
	private String username; // 사용자 아이디
	private String password; // 사용자 비밀번호(12345:평문/#@SDasdf@!#:암호화)
	private String name;
	private String email;
}
