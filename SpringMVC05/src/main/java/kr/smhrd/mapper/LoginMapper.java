package kr.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Update;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Member;


public interface LoginMapper {
	
	// 1. 로그인 처리 메서드
	public Member login(Member mvo);
}

