package pere.jax.mapper.Board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pere.jax.domain.BoardVO;
import pere.jax.domain.Criteria;

public interface BoardMapper {
	
	public List<BoardVO> getListWithPage(Criteria cri);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int update(BoardVO board);
	
	public int delete(Long bno);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
