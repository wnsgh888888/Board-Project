package pere.jax.mapper.Reply;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pere.jax.domain.Criteria;
import pere.jax.domain.ReplyVO;

public interface ReplyMapper2 {
	
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long bno);
	
	public int update(ReplyVO reply);
	
	public int delete(Long bno);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri,@Param("bno") Long bno);
	
	public int getCountByBno(Long bno);
}
