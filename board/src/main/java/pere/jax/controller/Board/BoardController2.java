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
import pere.jax.service.Board.BoardService2;

@Controller
@AllArgsConstructor
@RequestMapping("/board2/*")
public class BoardController2 {
	
	private BoardService2 service;	
	
	@GetMapping("/list")
	public void list(Model model,Criteria cri) {
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker",new pageDTO(cri,total));
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board2/list";
	}

	
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,Model model) {

		model.addAttribute("board", service.get(bno));
	}

	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if (service.modify(board))
			rttr.addFlashAttribute("result", "success");
		
		return "redirect:/board2/list" + cri.getListLink();
	}

	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr, String writer){
		if (service.remove(bno))
			rttr.addFlashAttribute("result", "success");
		
		return "redirect:/board2/list" + cri.getListLink();
	}
}
