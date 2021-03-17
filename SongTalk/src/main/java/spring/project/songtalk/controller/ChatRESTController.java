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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import spring.project.songtalk.domain.MSGVO;
import spring.project.songtalk.domain.RoomVO;
import spring.project.songtalk.service.MSGService;
import spring.project.songtalk.service.RoomService;

@RestController
@RequestMapping(value = "*/tchat")
public class ChatRESTController {
	
	public static final Logger logger = 
			LoggerFactory.getLogger(ChatRESTController.class);
	
	@Autowired
	private RoomService roomService;
	
	@Autowired
	private MSGService msgService;
	
	
	// MSG > create / select
	// Room > update / select
	
	// **********************************************************************************
	// MsgTable
	
	// Create
	@PostMapping()
	public ResponseEntity<Integer> saveMsg(@RequestBody MSGVO vo, HttpServletRequest request) {
		logger.info("saveMsg : " + vo.toString());
		int result;
		
		try {
			result = msgService.create(vo);
			logger.info("create() call :" + vo.toString());
			
			// if 'message' is inserted, make 'bno' session
			HttpSession session = request.getSession();
			MSGVO mvo = msgService.readNew();
			session.setAttribute("msgBno", mvo.getMsgBno());
		
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<Integer>(0, HttpStatus.OK);
		}
	}// end saveMsg()
	
	// Select
	@GetMapping("/msgall/{msgBno}")
	public ResponseEntity<MSGVO> readMsg (@PathVariable("msgBno") int msgBno,
			HttpServletRequest request) {
		MSGVO vo = msgService.read(msgBno);
		logger.info("readMsg call");
		
		logger.info("msgBno = " + msgBno + " , msgVO = " + vo);
		return new ResponseEntity<MSGVO>(vo, HttpStatus.OK);
	} // end readMsg()
	
	// **************************************************************************************
	// RoomTable
	
	// Update
	@PutMapping()
	public ResponseEntity<String> updateRoom (@PathVariable("roomBno")int roomBno,
				@RequestBody RoomVO vo, HttpServletRequest request) {
		logger.info("updateRoom call bno = " + roomBno);
		logger.info("vo = " + vo.toString());
		
		HttpSession session = request.getSession();
		int msgBno = (Integer)session.getAttribute("msgBno");
		// insert 'bno' into chatRoom
		vo.setRoomContent(vo.getRoomContent() + "," + msgBno);
		logger.info("updated vo = " + vo.toString());
		
		try {
			roomService.updateContent(vo);
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e){
			return new ResponseEntity<String>("fail", HttpStatus.OK);
		}
	} // end updateMsg()
	
	
	// Select
	@GetMapping("/roomall/{roomBno}")
	public ResponseEntity<RoomVO> readRoom (@PathVariable("roomBno") int roomBno,
					HttpServletRequest request) {
		logger.info("readRoom call");
		RoomVO vo = roomService.read(roomBno);
		
		logger.info("roomBno = " + roomBno + ",roomVO" + vo);
		return new ResponseEntity<RoomVO>(vo, HttpStatus.OK);
	} // end readRoom
	
	
	
}