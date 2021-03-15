package spring.project.songtalk.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		logger.info("MENU LIST() 호출");
		
		List<RoomVO> list = roomService.read();
		logger.info(list.toString());
		
		model.addAttribute("roomList", list);
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
