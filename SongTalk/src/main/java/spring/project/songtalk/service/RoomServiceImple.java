package spring.project.songtalk.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.project.songtalk.domain.RoomVO;
import spring.project.songtalk.persistence.RoomDAO;

@Service
public class RoomServiceImple implements RoomService {

	private static final Logger logger = 
			LoggerFactory.getLogger(RoomServiceImple.class);
	
	@Autowired
	private RoomDAO dao;
	
	@Override
	public int create(RoomVO vo) {
		logger.info("create() 호출");
		return dao.insert(vo);
	}

	@Override
	public RoomVO read(int roomBno) {
		logger.info("read() 호출");
		return dao.select(roomBno);
	}

	@Override
	public List<RoomVO> read(String userid) {
		logger.info("readList() 호출");
		return dao.select(userid);
	}

	@Override
	public int updateInfo(int roomBno) {
		logger.info("updateInfo() 호출");
		return dao.updateInfo(roomBno);
	}
	
	@Override
	public int updateContent(RoomVO vo) {
		logger.info("updateContent() 호출");
		return dao.updateContent(vo);
	}
	
	@Override
	public int updateMember(int roomBno) {
		logger.info("updateMember() 호출");
		return dao.updateMember(roomBno);
	}

	@Override
	public int delete(int roomBno) {
		logger.info("delete() 호출");
		return dao.delete(roomBno);
	}
	
	@Override
	public List<RoomVO> select (String keyword) {
		logger.info("select() 호출");
		return dao.select(keyword);
	}

}
