package spring.project.songtalk.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.project.songtalk.domain.RoomVO;
import spring.project.songtalk.service.RoomService;

@Controller
@RequestMapping(value = "/layout")
public class RoomListController {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(RoomListController.class);
	
	@Autowired
	private RoomService roomService;
	
	@GetMapping("/menu")
	public void list (Model model) {
		logger.info("listI() 호출");
		
		List<RoomVO> list = roomService.read();
		
		model.addAttribute("roomList", list);
		logger.info(list.toString());
	} // end list()
}
