package pere.jax.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class pageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	public pageDTO(Criteria cri,int total) {
		
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;   //현재 페이지를 10.0으로 나누고 올림 * 10 ( 5,15 -> 10,20 )
		this.startPage = this.endPage - 9;
		
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));   //총 게시글 수에 1.0을 곱하고 페이지 당 게시글로 나눈 뒤 올림 ( 65,178 -> 7,18 )
		if (realEnd < this.endPage)
			this.endPage = realEnd;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
