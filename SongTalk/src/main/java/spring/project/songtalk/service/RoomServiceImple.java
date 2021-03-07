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
		logger.info("create() ȣ��");
		return dao.insert(vo);
	}

	@Override
	public RoomVO read(int roomBno) {
		logger.info("read() ȣ��");
		return dao.select(roomBno);
	}

	@Override
	public List<RoomVO> read() {
		logger.info("readList() ȣ��");
		return dao.select();
	}

	@Override
	public int updateInfo(int roomBno) {
		logger.info("updateInfo() ȣ��");
		return dao.updateInfo(roomBno);
	}
	
	@Override
	public int updateContent(int roomBno) {
		logger.info("updateContent() ȣ��");
		return dao.updateContent(roomBno);
	}
	
	@Override
	public int updateMember(int roomBno) {
		logger.info("updateMember() ȣ��");
		return dao.updateMember(roomBno);
	}

	@Override
	public int delete(int roomBno) {
		logger.info("delete() ȣ��");
		return dao.delete(roomBno);
	}

}
