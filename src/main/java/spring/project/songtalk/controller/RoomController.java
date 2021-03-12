<<<<<<< HEAD
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
	
	/* ì „ì²´ì±„íŒ…ë°©, ë‚˜ì˜ ì±„íŒ…ë°© */
	/* list, detail, update, delete */
	
	/* ì±„íŒ… ë©”ì¸í˜ì´ì§€ */
	@GetMapping("/HOME")
	public void HOMEGET() {
		logger.info("HOME() í˜¸ì¶œ");
		System.out.println("aaaaa");
	}
	
	/* ì±„íŒ…ë°© ê°œì„¤ */
	@PostMapping("/register")
	public String registerPOST(RoomVO vo, RedirectAttributes reAttr, HttpServletRequest request ) {
		logger.info("registerPOST() í˜¸ì¶œ");
		logger.info(vo.toString());
		
		vo.setRoomContent(",");
		
		int result = roomService.create(vo);
		
		if (result == 1) {
			reAttr.addFlashAttribute("create_result", "success");
			return "redirect:/songtalk/chat/roomDetail";
		} else {
			reAttr.addFlashAttribute("create_result", "fail");
			return "redirect:/songtalk/chat/HOME";
		}
	} // end registerPOST()
	
	/* ì „ì²´ ì±„íŒ…ë°© */
	@GetMapping("/allDetail")
	public void detailALLGET(Model model) {
		logger.info("allDetailGET() í˜¸ì¶œ");
		
	} // end detailALL()
	
	/* íŠ¹ì • ëŒ€í™”ë°© */
	@GetMapping("/roomDetail")
	public String detailROOMGET(Integer roomBno, Model model) {
		logger.info("detailROOMGET() í˜¸ì¶œ");
		
		RoomVO vo = roomService.read(roomBno);
		model.addAttribute("roomVO", vo);
		
		return "redirect:/chat/roomDetail?bno=" + roomBno;
	} // end detailROOMGET()
	
	/* ì±—ë´‡ë°© */
	
	/* ì‚­ì œ GET */
	@GetMapping("/delete")
	public String delete(Integer bno, RedirectAttributes reAttr) {
		logger.info("delete() í˜¸ì¶œ : bno = " + bno);
		
		int result = roomService.delete(bno);
		
		if (result == 1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/chat/HOME";
		} else {
			reAttr.addFlashAttribute("delete_result", "fail");
			return "redirect:/chat/HOME";
		}
	}
=======
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
	
	/* ÀüÃ¼Ã¤ÆÃ¹æ, ³ªÀÇ Ã¤ÆÃ¹æ */
	/* list, detail, update, delete */
	
	/* Ã¤ÆÃ ¸ŞÀÎÆäÀÌÁö */
	@GetMapping("/HOME")
	public void HOMEGET() {
		logger.info("HOME() È£Ãâ");
		System.out.println("aaaaa");
	}
	
	/* Ã¤ÆÃ¹æ °³¼³ */
	@PostMapping("/register")
	public String registerPOST(RoomVO vo, RedirectAttributes reAttr, HttpServletRequest request ) {
		logger.info("registerPOST() È£Ãâ");
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
	
	/* ÀüÃ¼ Ã¤ÆÃ¹æ */
	@GetMapping("/allDetail")
	public void detailALLGET(Model model) {
		logger.info("allDetailGET() È£Ãâ");
		
	} // end detailALL()
	
	/* Æ¯Á¤ ´ëÈ­¹æ */
	@GetMapping("/roomDetail")
	public String detailROOMGET(Integer roomBno, Model model) {
		logger.info("detailROOMGET() È£Ãâ");
		
		RoomVO vo = roomService.read(roomBno);
		model.addAttribute("roomVO", vo);
		
		return "redirect:/chat/roomDetail?bno=" + roomBno;
	} // end detailROOMGET()
	
	/* Ãªº¿¹æ */
	
	/* ¼öÁ¤ */
	@GetMapping("update")
	public void updateGET(Model model, Integer roomBno) {
		logger.info("updateGET() È£Ãâ");
		RoomVO vo = roomService.read(roomBno);
		model.addAttribute("roomVO", vo);
	} // end updateGET()
	
	
	/* »èÁ¦ GET */
	@GetMapping("/delete")
	public String delete(Integer bno, RedirectAttributes reAttr) {
		logger.info("delete() È£Ãâ : bno = " + bno);
		
		int result = roomService.delete(bno);
		
		if (result == 1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/chat/HOME";
		} else {
			reAttr.addFlashAttribute("delete_result", "fail");
			return "redirect:/chat/HOME";
		}
	}
>>>>>>> e12001fd5e87f87b59d50a0bb85c77c20def465a
}