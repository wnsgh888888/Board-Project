package pere.jax.controller.Board;

import org.springframework.security.access.prepost.PreAuthorize; 
import org.springframework.stereotype.Controller; 
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import pere.jax.domain.BoardVO;
import pere.jax.domain.Criteria;
import pere.jax.domain.pageDTO;
import pere.jax.service.Board.BoardService;

@Controller
@AllArgsConstructor
@RequestMapping("/board/*")
public class BoardController {
	
	
	private BoardService service;	
	
	
	@GetMapping("/list")
	public void list(Model model,Criteria cri) {
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker",new pageDTO(cri,total));
	}
	//기준을 매개변수로, 매핑된 값이 없다면 기본 생성자 생성
	//게시글 리스트, 페이지 내용을 뷰에 전달

	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {}
	//새 글 등록이라 받을 내용도 전달할 내용도 없음
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
	//게시글 객체를 매개변수로 받아 서비스를 통해 등록
	//결과를 일회성으로 리다이렉트

	
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,Model model) {

		model.addAttribute("board", service.get(bno));
	}
	//조회와 수정은 같은 내용을 보여주므로 같이 다룸
	//번호,원게시글의 기준 전달을 위해 매개변수로 받음
	//서비스를 통해 게시글을 반환받아 뷰에 전달
	
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if (service.modify(board))
			rttr.addFlashAttribute("result", "success");
		
		return "redirect:/board/list" + cri.getListLink();
	}
	//게시글,원게시글로 돌아갈 기준을 매개변수로 받음
	//서비스를 통해 결과값에 따라 일회성 리다이렉트
	//리다이렉트 시 list에서 필요한 criteria 전달
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr, String writer){
		if (service.remove(bno))
			rttr.addFlashAttribute("result", "success");
		
		return "redirect:/board/list" + cri.getListLink();
	}
	//번호,원게시글로 돌아갈 기준을 매개변수로 받음
	//서비스를 통해 결과값에 따라 일회성 리다이렉트
	//리다이렉트 시 list에서 필요한 criteria 전달
}	
