package spring.project.songtalk.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import spring.project.songtalk.domain.RoomVO;
import spring.project.songtalk.service.RoomService;

@RestController
@RequestMapping(value = "*/list")
public class RoomListController {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(RoomListController.class);
	
	@Autowired
	private RoomService roomService;
	
	
	@GetMapping("/all/{loginId}")
	public ResponseEntity<List<RoomVO>> list (@PathVariable("loginId") String userid) {
		logger.info("MENU LIST() 호출");
		logger.info(userid);
		
		List<RoomVO> list = roomService.read(userid);
		logger.info(list.toString());

		return new ResponseEntity<List<RoomVO>>(list, HttpStatus.OK);
	} // end list()
	
	@PostMapping("/menu")
	public void listSearch (String keyword, RedirectAttributes reAttr, Model model,
			HttpServletRequest request) {
		logger.info("listSearchPOST() 호출 keyword : " + keyword);
		
		List<RoomVO> list = roomService.select(keyword);
		
		model.addAttribute("roomList", list);
		logger.info(list.toString());
	}
}
