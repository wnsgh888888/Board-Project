package pere.jax.service.Board;

import java.util.List;

import pere.jax.domain.BoardVO;
import pere.jax.domain.Criteria;

public interface BoardService {
	public List<BoardVO> getList(Criteria cri);
	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
	public int getTotal(Criteria cri);
}
