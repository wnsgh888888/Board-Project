package pere.jax.mapper.Reply;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pere.jax.domain.Criteria;
import pere.jax.domain.ReplyVO;

public interface ReplyMapper {
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri,@Param("bno") Long bno);	//cri는 게시판이 아닌 댓글 기준
	
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long bno);
	
	public int update(ReplyVO reply);
	
	public int delete(Long bno);
	
	public int getCountByBno(Long bno);   //댓글 페이징에서 사용
}
