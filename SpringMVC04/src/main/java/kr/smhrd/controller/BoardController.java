package kr.smhrd.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Criteria;
import kr.smhrd.entity.PageMaker;
import kr.smhrd.mapper.BoardMapper;

@Controller //POJO
public class BoardController {
	//@Inject
	@Autowired//설명
	private BoardMapper mapper;
	// 1. 리스트 요청 처리: /list.do 요청이 오면 --> boardList() 메서드를 처리 하도록(handler mapping)핸들러 매핑
	@RequestMapping("/list.do")
	public String list(Criteria cri, Model request) { // 게시판의 소스코드
		// 게시판 리스트 가져오기(DB) -> Mapper(DAO와 연동) ; 과일목록
		List<Board> list = mapper.boardList(cri);
		
		request.addAttribute("list",list);// 객체 바인딩
		
		// 페이징 처리 객체 생성하기
		PageMaker pm = new PageMaker();
		// Criteria 정보를 넣어줘야 한다.
		pm.setCri(cri);
		// TotalCount를 넣어줘야 한다. 따라서 전체 TotalCount를 구하는 매퍼를 만들어야 한다.
	
		pm.setTotalCount(mapper.totalCount(cri));
		request.addAttribute("pm",pm);
		
		return "boardList"; //1.forward방식(jsp로만 감) 2.컨트롤러로 가는건 Redirect방식을 사용
		//VIEW의 논리적인 이름--> 물리적인 위치로 변경(ViewResolver)
	}
	
	// 2. 게시글 등록 UI요청 처리
	@GetMapping("/register.do")
	public String register() {
		return "register"; // 접두사랑 접미사가 붙어서 포워딩이 됨
	}
	
	
	// 2. 게시글 등록 요청 처리
	@PostMapping("/register.do")// register.jsp(등록화면) : title, content, writer
	public String register(Board vo) {
		mapper.boardInsert(vo);
		// 여기선 입력하고 보여줘야 하기 때문에 list.do로 다시 보내줘야 한다.
		// 즉 포워딩이 아닌 리다이렉트를 해야한다.
		// 그때 쓰는게 redirect:를 써야 한다. 
		// 저걸 F.C가 보고 리다이랙트인걸 안다.
		return "redirect:/list.do";
	}
	
	// 3.상세보기 요청 처리
	@RequestMapping("/get.do") // ? ex) num=10
	public String get(@ModelAttribute("cri") Criteria cri, int num, Model model) {
		
		Board vo = mapper.boardGet(num);
		model.addAttribute("vo",vo);
		//페이지 정보는 써먹진 않는다 들고만 있는즁
		//model.addAttribute("cri",cri);
		// 조회수 누적
		mapper.count(num);
		return "get";
	}
	
	// 4. 게시판 삭제
	@RequestMapping("/remove.do")
	public String remove(Criteria cri, int num, RedirectAttributes rttr) {
		mapper.boardDelete(num);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/list.do";
	}
	// 5. 수정화면 요청 처리
	@GetMapping("/modify.do")
	public String modify(@ModelAttribute("cri") Criteria cri, int num, Model model ) {
		Board vo = mapper.boardGet(num);
		model.addAttribute("vo",vo);
		return "modify";
	}
	@PostMapping("/modify.do")
	public String modify(Criteria cri,Board vo, RedirectAttributes rttr) {
		mapper.boardModify(vo);
		//return "redirect:/list.do";
		rttr.addAttribute("num",vo.getNum());
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/get.do";
		
	}
	
	// 6. 답글 UI 요청처리
	@GetMapping("/reply.do")
	public String reply(@ModelAttribute("cri") Criteria cri, int num, Model model) {
		Board pvo = mapper.boardGet(num); // 부모글 
		model.addAttribute("pvo",pvo);
		return "reply"; // reply.jsp
		
	}
	@PostMapping("/reply.do") // 부모 게시글 번호가 넘어옴, [username, title, content , writer까지 넘어온다.] bgroup, bseq, blevel을 만들어 줘야 한다. 
							  // 부모의 num을 알기 때문에 부모의 정보를 가지고 만들어 줘야 한다.
	public String reply(Criteria cri,Board vo, RedirectAttributes rttr) {
		//1. 부모글의 정보 가져오기
		Board pvo = mapper.boardGet(vo.getNum());
		//2. 답글의 bgroup 설정
		vo.setBgroup(pvo.getBgroup());
		vo.setBseq(pvo.getBseq()+1);
		vo.setBlevel(pvo.getBlevel()+1);
		//3. 부모의 bgroup과 같고 부모의 bseq보다 큰 답글의 bseq를 모두 1씩 증가 
		mapper.replySeqUpdate(pvo);
		//4. 답글을 저장 , 답글을 저장해야 하니까 vo를 넣어야 한다.
		mapper.replyInsert(vo);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/list.do";
	}

}
