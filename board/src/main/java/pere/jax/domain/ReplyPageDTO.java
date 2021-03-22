package pere.jax.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReplyPageDTO {
	private int replyCnt;
	private List<ReplyVO> list;
}
//
//페이징을 위한 댓글갯수를 컬럼으로 추가
//페이지값은 화면단에 존재함
//AJAX 리스트 관련 통신에 대한 REST 컨트롤러 결과값
//두 가지 값을 담아 보내기 위해 생성한 도메인