package kr.smhrd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.smhrd.entity.Member;
import kr.smhrd.mapper.LoginMapper;


@Controller
public class LoginController {
	@Autowired
	private LoginMapper mapper;
	//1. 로그인 요청을 처리
	@RequestMapping("/login.do")// form에서 username, password 파라미터를 수집해야 한다. vo로
	public String login(Member vo, HttpSession session) { // HttpSession session=requet.getSession(); 세션을 request에서 만드는 이유 세션이 있는지 없는지 체킹을 위해서~
		Member mvo =mapper.login(vo);
		// 성공,실패 여부 파악
		if(mvo!=null) { // 성공 -> VIEW(JSP,,,) 뷰페이지들이 인증여부를 알아야 함. 메모리에 객체를 바인딩 하면 된다. 모든 페이지에서 알아야 하기 때문에 Session에 해야한다.
			session.setAttribute("mvo", mvo); // ${!empty mvo}<<화면에서 쓸거
		}
		
		return "redirect:/list.do";//메인페이지로 돌아가기
	}
	//2. 로그아웃 요청을 처리
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/list.do";
	}
	
}
