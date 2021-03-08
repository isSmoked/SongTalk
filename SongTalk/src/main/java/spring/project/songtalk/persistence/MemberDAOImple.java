package spring.project.songtalk.persistence;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.project.songtalk.domain.MemberVO;

@Repository
public class MemberDAOImple implements MemberDAO {
	private static final Logger logger = 
			LoggerFactory.getLogger(MemberDAOImple.class);
	
	private static final String NAMESPACE = 
			"spring.project.songtalk.MemberMapper";

	@Autowired
	private SqlSession sqlSession;
		
	@Override
	public int insert(MemberVO vo) {
		logger.info("register() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public MemberVO login(MemberVO vo) {
		logger.info("login() CALL");
		return sqlSession.selectOne(NAMESPACE + ".login", vo);
	}

	@Override
	public int update(MemberVO vo) {
		logger.info("update() 호출");
		return sqlSession.update(NAMESPACE + ".update", vo);
	}

	@Override
	public int delete(String userid) {
		logger.info("delete() 호출");
		return sqlSession.delete(NAMESPACE + ".delete", userid);
	}
	
	@Override
	public MemberVO select(String userid) {
		logger.info("select() 호출");
		return sqlSession.selectOne(NAMESPACE + ".select", userid);
	}

}
