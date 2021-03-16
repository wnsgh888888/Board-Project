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
	}//게시물 리스트 반환
	
	
	@Override
	public void register(BoardVO board){
		mapper.insertSelectKey(board);
	}//게시글 등록

	
	@Override
	public BoardVO get(Long bno){
		return mapper.read(bno);
	}//게시글 반환

	
	@Override
	public boolean modify(BoardVO board){
		return mapper.update(board) == 1;
	}//게시글 수정 
	

	@Override
	public boolean remove(Long bno) {
		return mapper.delete(bno) == 1;
	}//게시글 삭제
	

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}//게시글 수 반환
}
