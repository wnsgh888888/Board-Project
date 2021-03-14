package pere.jax.security;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import pere.jax.domain.MemberVO;
import pere.jax.mapper.MemberMapper;
import pere.jax.security.domain.CustomUser;


public class CustomUserDetailsService implements UserDetailsService {
	
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		MemberVO vo = memberMapper.read(userName);
		return vo == null ? null : new CustomUser(vo);
	}
}
