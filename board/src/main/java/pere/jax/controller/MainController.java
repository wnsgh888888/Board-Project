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
	
	@GetMapping("/")
	public String main() {
		
		return "main";
	}


}
