package kr.smhrd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.smhrd.entity.Board;
import kr.smhrd.mapper.BoardMapper;

@Controller
@RestController //--> json용 컨트롤러  @ResponseBody
public class AjaxController {

	@Autowired
	private BoardMapper mapper;
	
	@RequestMapping("/ajaxList.do")
	public List<Board> ajaxList() {
		List<Board> list = mapper.boardList(); // 게시판 전체 가져오기
		return list; // List<Board>(Object)--> API(pom.xml에 추가) --> String(JSON)
	}
	@RequestMapping("/ajaxUpdate.do")
	public void ajaxUpdate(Board vo) {
		mapper.boardModify(vo);
		return;
	}
	@RequestMapping("/ajaxDelete.do")
	public void ajaxDelete(int num) {
		mapper.boardDelete(num);
		return;
	}
	@RequestMapping("/ajaxInsert.do")
	public void ajaxInsert(Board vo) { // title~~~~
		mapper.boardInsert(vo);
		return;
	}
}
