
package spring.project.songtalk.controller;

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
	
	/* 채팅 메인페이지 */
	@GetMapping("/HOME")
	public void HOMEGET() {
		logger.info("HOME() 호출");
	}
	
	/* 채팅방 입력창 */
	@GetMapping("/register")
	public void registerGET() {
		logger.info("registerGET() 호출");
	}
	
	/* 채팅방 개설 */
	@PostMapping("/register")
	public String registerPOST(RoomVO vo, RedirectAttributes reAttr, HttpServletRequest request ) {
		logger.info("registerPOST() 호출");
		logger.info(vo.toString());
		
		vo.setRoomContent(",");
		
		int result = roomService.create(vo);
		
		if (result == 1) {
			reAttr.addFlashAttribute("create_result", "success");
			return "redirect:/chat/HOME";
		} else {
			reAttr.addFlashAttribute("create_result", "fail");
			return "redirect:/chat/HOME";
		}
	} // end registerPOST()
	
	/* 전체 채팅방 */
	@GetMapping("/allDetail")
	public void detailALLGET(Model model) {
		logger.info("allDetailGET() 호출");
		
	} // end detailALL()
	
	/* 특정 대화방 */
	@GetMapping("/roomDetail")
	public String detailROOMGET(Integer roomBno, Model model) {
		logger.info("detailROOMGET() 호출");
		
		RoomVO vo = roomService.read(roomBno);
		model.addAttribute("roomVO", vo);
		
		return "redirect:/chat/roomDetail?bno=" + roomBno;
	} // end detailROOMGET()
	
	/* 챗봇방 */
	
	/* 삭제 GET */
	@GetMapping("/delete")
	public String delete(Integer bno, RedirectAttributes reAttr) {
		logger.info("delete() 호출 : bno = " + bno);
		
		int result = roomService.delete(bno);
		
		if (result == 1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/chat/HOME";
		} else {
			reAttr.addFlashAttribute("delete_result", "fail");
			return "redirect:/chat/HOME";
		}
	}
}