package pere.jax.controller;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import pere.jax.domain.MemberVO;
import pere.jax.service.MemberService;

@Controller
public class CommonController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	

	
	@GetMapping("/accessError")
	public void accessDenied(Model model) {
		model.addAttribute("msg","접근 오류");
	}
		
	//반드시 get방식으로 로그인을 지정한다.
	//error와 logout 파라미터는 시큐리티 컨텍스트에서 자동매핑해준다.
	//post방식이 존재하지 않는다.
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		if(error != null)
			model.addAttribute("error", "로그인 오류");
		if(logout != null)
			model.addAttribute("logout", "로그아웃");
	}
		
	@GetMapping("/includes/header")
	public void logoutGET() {}
	
	@PostMapping("/includes/header")
	public void logoutPOST() {}
	
	@GetMapping("/register")
	public void registerGET() {}
	
	@PostMapping("/register")
	public String registerPOST(MemberVO vo, RedirectAttributes rttr) {
		
		int result = service.register(vo);
		
		if(result == 1)
			rttr.addFlashAttribute("result", "success");
		else
			rttr.addFlashAttribute("result", "failure");
		
		return "redirect:/customLogin";
	}

	
}


