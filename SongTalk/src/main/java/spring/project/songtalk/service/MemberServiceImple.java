package spring.project.songtalk.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.project.songtalk.domain.MemberVO;
import spring.project.songtalk.persistence.MemberDAO;

@Service
public class MemberServiceImple implements MemberService {

	private static final Logger logger = 
			LoggerFactory.getLogger(MemberServiceImple.class);

	@Autowired
	private MemberDAO dao;
	
	@Override
	public int create(MemberVO vo) {
		logger.info("create() 호출");
		return dao.insert(vo);
	}

	@Override
	public MemberVO login(MemberVO vo) {
		logger.info("login() 호출");
		return dao.login(vo);
	}

	@Override
	public int update(int memberBno) {
		logger.info("update() 호출");
		return dao.update(memberBno);
	}

	@Override
	public int delete(int memberBno) {
		logger.info("delete() 호출");
		return dao.delete(memberBno);
	}

}
