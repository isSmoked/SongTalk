package spring.project.songtalk.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	/* 회원가입, 로그인, 정보수정, 정보삭제(개인정보) */
	
	
	/* 회원가입 */ // ---------------------------------------------
	@GetMapping("/register")
	public void registerGET() {
		logger.info("registerGET() 호출");
	} // end registerGET()
	
	@PostMapping("/register")
	public String registerPOST(MemberVO vo, RedirectAttributes reAttr, HttpServletRequest request) {
		logger.info("registerPOST() 호출");
		logger.info(vo.toString());
		
		int result = memberService.create(vo);
		
		if (result == 1) {
			reAttr.addFlashAttribute("register_result", "success");
			return "redirect:/";
		} else {
			reAttr.addFlashAttribute("register_result", "fail");
			return "redirect:/member/login";
		}
	} // end registerPOST()
	// -----------------------------------------------------------
	
	/* 로그인 */ // -----------------------------------------------
	@GetMapping("/login")
	public void loginGET(Model model, HttpServletRequest request) {
		logger.info("loginGET() 호출");
		String referer = request.getHeader("referer");
		logger.info("loginGET() - referer : " + referer);
		
		model.addAttribute("targetUrl", referer);
		model.addAttribute("loginResult", null);
	} // end loginGET()
	
	@PostMapping("/login-post")
	public void loginPOST (MemberVO vo, Model model, HttpServletRequest request) {
		logger.info("loginPOST() 호출");
		MemberVO mvo = memberService.login(vo);
		logger.info("mvo : " + mvo);
		
		String result = null;
		
		if (mvo != null) {
			result = mvo.getMemberUserid();
			logger.info("loginID : " + result);
			model.addAttribute("result", result);
			
		}
	} // end loginPOST()
	// ----------------------------------------------------------
	
	/* 정보수정 */ // ---------------------------------------------
	@GetMapping("/update")
	public void updateGET(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("userid");
		logger.info("updateGET() 호출 userid : " + userid);
		
		MemberVO vo = memberService.read(userid);
		model.addAttribute("memberVO", vo);
	} // end updateGET()
	
	@PostMapping("/update-post")
	public String updatePOST(MemberVO vo, HttpServletRequest request, RedirectAttributes reAttr) {
		logger.info("updatePOST() 호출");
		int result = memberService.update(vo);
		
		if (result == 1) {
			reAttr.addFlashAttribute("update_result", "success");
			return "redirect:/member/main";
		} else {
			logger.info("update 실패");
			reAttr.addAttribute("update_result", "success");
			// TODO : 메인에서 toast 알림처리
			return "redirect:/member/main";
		}
	} // end updatePOST()
	// ----------------------------------------------------------
	
	
	/* 정보삭제 */ // ---------------------------------------------
	public String delete(RedirectAttributes reAttr, HttpServletRequest request) {
		logger.info("delete() 호출");
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("userid");
		
		int result = memberService.delete(userid);
		if (result == 1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/member/main";
		} else {
			reAttr.addFlashAttribute("delete_result", "fail");
			return "redirect:/member/main";
		}
	} // end delete()
	// -----------------------------------------------------------
	
}