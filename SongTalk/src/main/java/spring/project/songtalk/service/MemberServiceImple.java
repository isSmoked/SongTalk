package spring.project.songtalk.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import spring.project.songtalk.domain.MemberVO;
import spring.project.songtalk.persistence.MemberDAO;

public class MemberServiceImple implements MemberService {

	private static final Logger logger = 
			LoggerFactory.getLogger(MemberServiceImple.class);

	@Autowired
	private MemberDAO dao;
	
	@Override
	public int create(MemberVO vo) {
		logger.info("create() ȣ��");
		return dao.insert(vo);
	}

	@Override
	public MemberVO login(MemberVO vo) {
		logger.info("login() ȣ��");
		return dao.login(vo);
	}

	@Override
	public int update(MemberVO vo) {
		logger.info("update() ȣ��");
		return dao.update(vo);
	}

	@Override
	public int delete(MemberVO vo) {
		logger.info("delete() ȣ��");
		return dao.delete(vo);
	}

}
