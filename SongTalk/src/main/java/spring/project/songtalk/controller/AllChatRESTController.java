package spring.project.songtalk.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import spring.project.songtalk.domain.AllVO;
import spring.project.songtalk.service.AllService;

@RestController
@RequestMapping(value = "*/achat")
public class AllChatRESTController {
	
	public static final Logger logger = 
			LoggerFactory.getLogger(AllChatRESTController.class);
	
	@Autowired
	private AllService allService;
	
	// **************************************************************************************
		// AllTable
		
		// Create
		@PostMapping()
		public ResponseEntity<Integer> saveAllMsg(@RequestBody AllVO vo) {
			int result;
			logger.info("saveAllMsg() called");
			
			try {
				result = allService.create(vo);
				logger.info("create() called : " + vo.toString());
				
				return new ResponseEntity<Integer>(result, HttpStatus.OK);
			} catch (Exception e) {
				return new ResponseEntity<Integer>(0, HttpStatus.OK);
			}
		} // end saveAllMsg()
		
		@GetMapping("/all/{allCount}")
		public ResponseEntity<List<AllVO>> readAll (@PathVariable("allCount") int allCount) {
			logger.info("readAllMsg called");
			List<AllVO> list = allService.read(allCount); // 여기에 bno 추가
			
			logger.info("allVO : " + list.toString());
			return new ResponseEntity<List<AllVO>>(list, HttpStatus.OK);
		} // end readAll()
}
