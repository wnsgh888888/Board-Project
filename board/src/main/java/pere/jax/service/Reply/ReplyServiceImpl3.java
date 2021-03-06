package pere.jax.service.Reply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import pere.jax.domain.Criteria;
import pere.jax.domain.ReplyPageDTO;
import pere.jax.domain.ReplyVO;
import pere.jax.mapper.Board.BoardMapper3;
import pere.jax.mapper.Reply.ReplyMapper3;

@Service
public class ReplyServiceImpl3 implements ReplyService3{
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper3 mapper;	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper3 boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}
	
	@Override
	public ReplyVO get(Long rno) {
		return mapper.read(rno);
	}
	
	@Override
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}
}