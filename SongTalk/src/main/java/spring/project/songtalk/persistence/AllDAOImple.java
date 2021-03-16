package spring.project.songtalk.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.project.songtalk.domain.AllVO;

@Repository
public class AllDAOImple implements AllDAO {
	
	private static final String NAMESPACE =
			"spring.project.songtalk.AllMapper";
	
	private static final Logger logger = 
			LoggerFactory.getLogger(AllDAOImple.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public int insert(AllVO vo) {
		logger.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public List<AllVO> select() {
		logger.info("select() called");
		return sqlSession.selectList(NAMESPACE + ".select");
	}

}
