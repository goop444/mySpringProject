package kr.smhrd.mapper;
// JDBC(java+SQL) -> MyBatis Framework(Java <--->SQL(xml))

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Criteria;
//@Mapper // <<<<< @Mapper가 붙어 있는 애들만 마이바티스가 구현 인터페이스만 넣으면 생략 가능
public interface BoardMapper {
	
	// 데이터베이스 접속(Connection) -> config.xml(jdbc url, username, password)
	
	// 1. 전체게시판 리스 가져오기
	public List<Board> boardList(Criteria cri);// 추상 메서드
	
	public void boardInsert(Board vo);
	
	public Board boardGet(int num);
	@Update("update reply set bdelete=1 where num =#{num}") //삭제는 이제 update로 해야한다.
	public void boardDelete(int num);
	@Update("update reply set title=#{title}, content=#{content} where num=#{num}")
	public void boardModify(Board vo);
	
	// 조회수 누적 메서드
	@Update("update reply set count=count+1 where num = #{num}")
	public void count(int num);
	// 답글의 bseq+1
	public void replySeqUpdate(Board pvo);
	// 답글 저장 메서드
	public void replyInsert(Board vo);
	
	//게시글의 total count를 구하는 매서드
	public int totalCount(Criteria cri);
}

