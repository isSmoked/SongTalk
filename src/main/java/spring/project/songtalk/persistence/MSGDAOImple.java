package spring.project.songtalk.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.project.songtalk.domain.MSGVO;

@Repository
public class MSGDAOImple implements MSGDAO {

	private static final Logger logger = 
			LoggerFactory.getLogger(MSGDAOImple.class);

	private static final String NAMESPACE = 
			"spring.project.songtalk.MSGMapper";

	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(MSGVO vo) {
		logger.info("register() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public MSGVO select(int msgBno) {
		logger.info("select() 호출");
		return sqlSession.selectOne(NAMESPACE + ".select", msgBno);
	}
	
	@Override
	public List<MSGVO> select() {
		logger.info("selectList() 호출");
		return sqlSession.selectList(NAMESPACE + ".select");
	}

	@Override
	public int delete(int msgBno) {
		logger.info("delete() 호출");
		return sqlSession.delete(NAMESPACE + ".delete", msgBno);
	}

}
