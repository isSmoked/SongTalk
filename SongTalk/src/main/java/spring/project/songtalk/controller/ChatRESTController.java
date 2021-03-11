package spring.project.songtalk.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import spring.project.songtalk.domain.RoomVO;
import spring.project.songtalk.service.RoomService;

@RestController
@RequestMapping(value = "*/chat")
public class ChatRESTController {
	
	public static final Logger logger = 
			LoggerFactory.getLogger(ChatRESTController.class);
	
	@Autowired
	private RoomService roomService;
	
	// 대화방 채팅내역 수정
	@PutMapping()
	public ResponseEntity<String> updateMsg(@PathVariable("roomBno")int roomBno,
				@RequestBody RoomVO vo) {
		logger.info("bno = " + roomBno);
		vo.setRoomBno(roomBno);
		logger.info("update vo = " + vo.toString());
		
		try {
			roomService.updateContent(vo);
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e){
			return new ResponseEntity<String>("fail", HttpStatus.OK);
		}
	} // end updateMsg()
	
	
	// 대화방 불러오기
	@GetMapping("/all/{roomBno}")
	public ResponseEntity<RoomVO> readMsg (@PathVariable("roomBno") int roomBno,
					HttpServletRequest request) {
		RoomVO vo = roomService.read(roomBno);
		
		logger.info("roomBno = " + roomBno + ",roomVO" + vo);
		return new ResponseEntity<RoomVO>(vo, HttpStatus.OK);
	}
}
