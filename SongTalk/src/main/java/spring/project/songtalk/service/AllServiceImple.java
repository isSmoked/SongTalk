package spring.project.songtalk.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.project.songtalk.domain.AllVO;
import spring.project.songtalk.persistence.AllDAO;

@Service
public class AllServiceImple implements AllService {
	
	private static final Logger logger =
			LoggerFactory.getLogger(AllServiceImple.class);
	
	@Autowired
	private AllDAO dao;
	
	@Override
	public int create(AllVO vo) {
		logger.info("create() called");
		return dao.insert(vo);
	}

	@Override
	public List<AllVO> read() {
		logger.info("read() called");
		return dao.select();
	}

}
