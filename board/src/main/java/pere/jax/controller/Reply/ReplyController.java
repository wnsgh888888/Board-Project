package pere.jax.controller.Reply;

import org.springframework.http.HttpStatus; 
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import pere.jax.domain.Criteria;
import pere.jax.domain.ReplyPageDTO;
import pere.jax.domain.ReplyVO;
import pere.jax.service.Reply.ReplyService;


@RequestMapping("/replies/")
@RestController
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;
	// 서비스 인터페이스 추가
	
	
	@GetMapping(value = "/pages/{bno}/{page}", 
			produces = {MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno){
		Criteria cri = new Criteria(page, 10);
		return new ResponseEntity<>(service.getListPage(cri,bno), HttpStatus.OK);
	}
	// ajax 통신에 의한 댓글 리스트 페이지 반환
	// bno와 page를 주소자원으로 받음
	// consumes x, produces json/xml
	// criteria 객체를 만들어 amount 값을 주고 서비스에 넣어 리스트 페이지 반환
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		int insertCount = service.register(vo);
		return insertCount == 1 ? new ResponseEntity<>("success",HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	// ajax 통신에 의한 댓글 추가
	// 매개변수로 댓글 데이터를 받음
	// consumes json/xml, produces text
	// 서비스 값에 따른 성공 / 에러
	
	
	@GetMapping(value = "/{rno}", 
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	// ajax 통신에 의한 댓글 조회
	// 따라서 주소자원 rno를 매개변수로 받음
	// consumes는 x produces는 xml/jsno
	// 서비스를 통해 댓글 반환
	
	
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, 
			value = "/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable ("rno") Long rno){
		vo.setRno(rno);
		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	// ajax 통신에 의한 댓글 수정
	// 주소자원으로 rno를 받고 데이터로 ReplyVo를 받음
	// consumes는 json/xml produces는 text
	// 서비스 결과값에 따라 성공/에러 보냄
	
	
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	// ajax 통신에 의한 댓글 삭제
	// 주소자원으로 rno를 매개변수로 받음
	// consumes x, produces text
	// 서비스 결과값에 따라 성공 / 에러
}
