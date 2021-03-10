package spring.project.songtalk.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import spring.project.songtalk.service.MemberService;

@RestController
public class MemberRESTController {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(MemberRESTController.class);
	
	@Autowired
	public MemberService memberService;
	
	
}
