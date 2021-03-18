package pere.jax.mapper.Board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import pere.jax.domain.BoardVO;
import pere.jax.domain.Criteria;

public interface BoardMapper {
	
	public List<BoardVO> getListWithPage(Criteria cri);
		
	public void insertSelectKey(BoardVO board);   //결과값이 항상 1
	
	public BoardVO read(Long bno);
	
	public int update(BoardVO board);   //업데이트된 행의 갯수가 결과값
	
	public int delete(Long bno);   //삭제된 행의 갯수가 결과값
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
