package pere.jax.service.Reply;

import pere.jax.domain.Criteria;
import pere.jax.domain.ReplyPageDTO;
import pere.jax.domain.ReplyVO;

public interface ReplyService3 {
	public int register(ReplyVO vo);
	public ReplyVO get(Long rno);
	public int modify(ReplyVO vo);
	public int remove(Long rno);
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
