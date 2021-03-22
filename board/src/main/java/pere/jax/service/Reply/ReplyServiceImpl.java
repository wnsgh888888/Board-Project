package pere.jax.service.Reply;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import pere.jax.domain.Criteria;
import pere.jax.domain.ReplyPageDTO;
import pere.jax.domain.ReplyVO;
import pere.jax.mapper.Board.BoardMapper;
import pere.jax.mapper.Reply.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	//반정규화로 인한 boardMapper 추가
	
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}
	//cri는 게시판이 아닌 댓글 기준
	//매개변수로 cri,bno를 받음
	//댓글들과 그 수 반환하여 ReplyPageDTO 타입으로 반환
	
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}
	//댓글 등록
	//댓글 추가 시 게시판의 replyCnt의 갯수 1 증가

	
	@Override
	public ReplyVO get(Long rno) {
		return mapper.read(rno);
	}
	//댓글 조회
	
	
	@Override
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}
	//댓글 수정
	
	
	@Transactional
	@Override
	public int remove(Long rno) {
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}
	//댓글 삭제
	//댓글 삭제 시 게시판의 replyCnt 갯수 1 하락
}
