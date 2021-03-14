package pere.jax.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import pere.jax.domain.AuthVO;
import pere.jax.domain.MemberVO;
import pere.jax.mapper.MemberMapper;

@Log4j
@Service
public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Transactional
	@Override
	public int register(MemberVO vo) {
		
		log.info(vo.getUserid());
		log.info(vo.getUserpw());
		log.info(vo.getUserName());
		
		String pw = pwencoder.encode(vo.getUserpw());
		vo.setUserpw(pw);
		int result1 = mapper.addMember(vo);
		
		
		AuthVO auth = new AuthVO();
		auth.setUserid(vo.getUserid());
		auth.setAuth("ROLE_USER");
		int result2 = mapper.addAuth(auth);
		
		return result1 == result2 ? 1 : 0 ;
	}
}
