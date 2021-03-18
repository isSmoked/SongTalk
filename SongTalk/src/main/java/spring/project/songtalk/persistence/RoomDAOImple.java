package spring.project.songtalk.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.project.songtalk.domain.RoomVO;

@Repository
public class RoomDAOImple implements RoomDAO {

	private static final Logger logger =
			LoggerFactory.getLogger(RoomDAOImple.class);
	
	private static final String NAMESPACE =
			"spring.project.songtalk.RoomMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(RoomVO vo) {
		logger.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public List<RoomVO> select(String userid) {
		logger.info("selectList() 호출");
		return sqlSession.selectList(NAMESPACE + ".selectList", userid);
	}

	@Override
	public RoomVO select(int roomBno) {
		logger.info("select() 호출");
		return sqlSession.selectOne(NAMESPACE + ".select", roomBno);
	}

	@Override
	public int updateInfo(int roomBno) {
		logger.info("updateInfo() 호출");
		return sqlSession.update(NAMESPACE + ".updateInfo", roomBno);
	}
	
	@Override
	public int updateContent(RoomVO vo) {
		logger.info("updateContent() 호출");
		return sqlSession.update(NAMESPACE + ".updateContent", vo);
	}
	
	@Override
	public int updateMember(int roomBno) {
		logger.info("updateMember() 호출");
		return sqlSession.update(NAMESPACE + ".updateMember", roomBno);
	}

	@Override
	public int delete(int roomBno) {
		logger.info("delete() 호출");
		return sqlSession.delete(NAMESPACE + ".delete", roomBno);
	}

	@Override
	public List<RoomVO> selectk(String keyword) {
		logger.info("select() 호출");
		return sqlSession.selectList(NAMESPACE + ".selectKeyword", keyword);
	}
}