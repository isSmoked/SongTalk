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
	
	/* ��üä�ù�, ���� ä�ù� */
	/* list, detail, update, delete */
	
	/* ä�� ���������� */
	@GetMapping("/HOME")
	public void HOMEGET() {
		logger.info("HOME() ȣ��");
		System.out.println("aaaaa");
	}
	
	/* ä�ù� ���� */
	@PostMapping("/register")
	public String registerPOST(RoomVO vo, RedirectAttributes reAttr, HttpServletRequest request ) {
		logger.info("registerPOST() ȣ��");
		logger.info(vo.toString());
		
		vo.setRoomContent(" ");
		
		int result = roomService.create(vo);
		
		if (result == 1) {
			reAttr.addFlashAttribute("create_result", "success");
			return "redirect:/songtalk/chat/roomDetail";
		} else {
			reAttr.addFlashAttribute("create_result", "fail");
			return "redirect:/songtalk/chat/HOME";
		}
	} // end registerPOST()
	
	/* ��ü ä�ù� */
	@GetMapping("/allDetail")
	public void detailALLGET(Model model) {
		logger.info("allDetailGET() ȣ��");
		
	} // end detailALL()
	
	/* Ư�� ��ȭ�� */
	@GetMapping("/roomDetail")
	public String detailROOMGET(Integer roomBno, Model model) {
		logger.info("detailROOMGET() ȣ��");
		
		RoomVO vo = roomService.read(roomBno);
		model.addAttribute("roomVO", vo);
		
		return "redirect:/chat/roomDetail?bno=" + roomBno;
	} // end detailROOMGET()
	
	/* ê���� */
	
	/* ���� */
	@GetMapping("update")
	public void updateGET(Model model, Integer roomBno) {
		logger.info("updateGET() ȣ��");
		RoomVO vo = roomService.read(roomBno);
		model.addAttribute("roomVO", vo);
	} // end updateGET()
	
	
	/* ���� GET */
	@GetMapping("/delete")
	public String delete(Integer bno, RedirectAttributes reAttr) {
		logger.info("delete() ȣ�� : bno = " + bno);
		
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