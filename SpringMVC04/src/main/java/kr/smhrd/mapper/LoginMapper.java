package kr.smhrd.mapper;
// JDBC(java+SQL) -> MyBatis Framework(Java <--->SQL(xml))



import kr.smhrd.entity.Member;
public interface LoginMapper {

	// 1. 로그인 처리 메서드; 성공한 회원의 정보를 리턴해야 하니까 Member entity로 리턴하자, null체크로 성공 여부 판단.
	public Member login(Member mvo);
	
	
}

