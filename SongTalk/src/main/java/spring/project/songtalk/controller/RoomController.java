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
@RequestMapping(value = "/chat")
public class RoomController {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(RoomController.class);
	
	@Autowired
	private RoomService roomService;
	
	/* 전체채팅방, 나의 채팅방 */
	/* list, detail, update, delete */
	
	
	/* 채팅방 개설 */
	@PostMapping("/register")
	public String registerPOST(RoomVO vo, RedirectAttributes reAttr, HttpServletRequest request0 ) {
		logger.info("registerPOST() 호출");
		logger.info(vo.toString());
		
		vo.setRoomContent(" ");
		
		int result = roomService.create(vo);
		
		if (result == 1) {
			reAttr.addFlashAttribute("create_result", "success");
			return "redirect:/songtalk/chat";
		} else {
			reAttr.addFlashAttribute("create_result", "fail");
			return "redirect:/songtalk/";
		}
	} // end registerPOST()
	
	/* 전체 채팅방 */
	@GetMapping("/detailALL")
	public void detailALLGET(Model model) {
		logger.info("detailAllGET() 호출");
		
	} // end detailALL()
	
	/* 특정 대화방 */
	@GetMapping("/detailRoom")
	public String detailROOMGET(Integer roomBno, Model model) {
		logger.info("detailROOMGET() 호출");
		
		RoomVO vo = roomService.read(roomBno);
		model.addAttribute("roomVO", vo);
		
		return "redirect:/songtalk/chat/room?bno=" + roomBno;
	} // end detailROOMGET()
	
	/* 챗봇방 */
	
	/* 수정 */
	@GetMapping("update")
	public void updateGET(Model model, Integer roomBno) {
		logger.info("updateGET() 호출");
		RoomVO vo = roomService.read(roomBno);
		model.addAttribute("roomVO", vo);
	} // end updateGET()
	
	/* 수정 POST */
	@PostMapping("/update")
	public String updatePOST(RoomVO vo, RedirectAttributes reAttr) {
		logger.info("update() 호출");
		int result = roomService.updateInfo(vo.getRoomBno());
		
		if (result == 1) {
			reAttr.addFlashAttribute("update_result", "success");
			return "redirect:/chat/room?bno=" + vo.getRoomBno();
		} else {
			reAttr.addFlashAttribute("update_result", "fail");
			return "redirect:/chat/room?bno=" + vo.getRoomBno();
		}
	} // end updatePOST()
	
	/* 삭제 GET */
	@GetMapping("/delete")
	public String delete(Integer bno, RedirectAttributes reAttr) {
		logger.info("delete() 호출 : bno = " + bno);
		
		int result = roomService.delete(bno);
		
		if (result == 1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/chat/list";
		} else {
			reAttr.addFlashAttribute("delete_result", "fail");
			return "redirect:/chat/list";
		}
	}
}
