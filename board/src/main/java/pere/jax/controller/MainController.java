package pere.jax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.Setter;
import pere.jax.domain.Criteria;
import pere.jax.service.Board.BoardService;
import pere.jax.service.Board.BoardService2;
import pere.jax.service.Board.BoardService3;

@Controller
public class MainController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService boardService;
	
	@Setter(onMethod_ = @Autowired)
	private BoardService2 boardService2;
	
	@Setter(onMethod_ = @Autowired)
	private BoardService3 boardService3;
	
	
	@GetMapping("/")
	public String introduce(Model model, Criteria cri) {
		
		cri.setPageNum(1);
		cri.setAmount(5);
		
		model.addAttribute("list",boardService.getList(cri));
		model.addAttribute("list2",boardService2.getList(cri));
		model.addAttribute("list3",boardService3.getList(cri));
		
		return "introduce";
	}


}
