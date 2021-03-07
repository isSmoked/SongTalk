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
		logger.info("insert() ȣ��");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public List<RoomVO> select() {
		logger.info("selectList() ȣ��");
		return sqlSession.selectList(NAMESPACE + ".selectList");
	}

	@Override
	public RoomVO select(int roomBno) {
		logger.info("select() ȣ��");
		return sqlSession.selectOne(NAMESPACE + ".select", roomBno);
	}

	@Override
	public int updateInfo(int roomBno) {
		logger.info("updateInfo() ȣ��");
		return sqlSession.update(NAMESPACE + ".updateInfo", roomBno);
	}
	
	@Override
	public int updateContent(int roomBno) {
		logger.info("updateContent() ȣ��");
		return sqlSession.update(NAMESPACE + ".updateContent", roomBno);
	}
	
	@Override
	public int updateMember(int roomBno) {
		logger.info("updateMember() ȣ��");
		return sqlSession.update(NAMESPACE + ".updateMember", roomBno);
	}

	@Override
	public int delete(int roomBno) {
		logger.info("delete() ȣ��");
		return sqlSession.delete(NAMESPACE + ".delete", roomBno);
	}

}
