package pere.jax.service.Board;

import java.util.List;  

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import pere.jax.domain.BoardVO;
import pere.jax.domain.Criteria;
import pere.jax.mapper.Board.BoardMapper;

@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;

	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPage(cri);
	}
	
	@Override
	public void register(BoardVO board){
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno){
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board){
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		return mapper.delete(bno) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
}
