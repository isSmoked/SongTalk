package spring.project.songtalk.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.project.songtalk.domain.MSGVO;
import spring.project.songtalk.persistence.MSGDAO;

@Service
public class MSGServiceImple implements MSGService {

	private static final Logger logger = 
			LoggerFactory.getLogger(MSGServiceImple.class);
	
	@Autowired
	private MSGDAO dao;
	
	@Override
	public int create(MSGVO vo) {
		logger.info("create() 호출");
		return dao.insert(vo);
	}

	@Override
	public MSGVO read(int msgBno) {
		logger.info("read() 호출");
		return dao.select(msgBno);
	}
	
	@Override
	public List<MSGVO> read() {
		logger.info("read() 호출");
		return dao.select();
	}

	@Override
	public int delete(int msgBno) {
		logger.info("delete() 호출");
		return dao.delete(msgBno);
	}

	@Override
	public MSGVO readNew() {
		logger.info("selectNew() 호출");
		return dao.selectNew();
				
	}
}
