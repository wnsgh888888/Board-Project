package pere.jax.mapper;

import pere.jax.domain.AuthVO;
import pere.jax.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	public int addMember(MemberVO vo);
	public int addAuth(AuthVO vo);
}
