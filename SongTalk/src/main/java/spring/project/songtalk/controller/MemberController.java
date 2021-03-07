package spring.project.songtalk.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import spring.project.songtalk.domain.MemberVO;
import spring.project.songtalk.service.MemberService;


@Controller
@RequestMapping(value = "/member")
public class MemberController {
	private static final Logger logger =
			LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	/* ȸ������, �α���, ��������, ��������(��������) */
	
	/* ȸ������ */
	@GetMapping("/register")
	public void registerGET() {
		logger.info("registerGET() ȣ��");
	} // end registerGET()
	
	@PostMapping("/register")
	public String registerPOST(MemberVO vo, RedirectAttributes reAttr, HttpServletRequest request) {
		logger.info("registerPOST() ȣ��");
		logger.info(vo.toString());
		
		int result = memberService.create(vo);
		
		if (result == 1) {
			reAttr.addFlashAttribute("register_result", "success");
			return "redirect:/member/main";
		} else {
			reAttr.addFlashAttribute("register_result", "fail");
			return "redirect:/member/login";
		}
	} // end registerPOST()
	
	/* �α��� */
	
	/* �������� */
	
	/* �������� */
}
