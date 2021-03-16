package spring.project.songtalk.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("===== LoginInterceptor preHandle 호출");
		
		String url = request.getParameter("targetUrl");
		// login.jsp에서 form action="login-post"로 이동하기 전에
		// 데이터를 가로채서 세션에 그 정보를 저장
		logger.info("목적지 url : " + url);
		if (url != null && url != "") {
			request.getSession().setAttribute("dest", url);
		}
		return true;
	} // preHandle

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("===== LoginInterceptor postHandle 호출");
		// model 객체의 loginResult 속성값(userid와 동일)을 확인
		// - null이 아니면(로그인 성공) session 객체에 loingId 속성 추가, 페이지 이동
		// - null이면(로그인 실패) 메인 페이지로 이동
		
		String loginId = (String) modelAndView.getModel().get("result");
		logger.info("=== LoginInterceptor postHandle loginId = " + loginId);

		if (loginId != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginId", loginId);
			session.setAttribute("loginResult", "success");
			// 세션에서 목적 url 가져오기
			String dest = (String) session.getAttribute("dest");
			logger.info("*********** 경로 : " + dest);
			int count = dest.split("/").length;
			logger.info("count = " + count);
			
			if (count > 4) {
				
				String ip = dest.split("/")[4] + "/" + dest.split("/")[5]; 
				logger.info("ip : " + ip);
				
				// 로그인 / 회원가입 경로 제거
				if (ip.contains("member/login") || ip.contains("member/register") || ip == null) {
					logger.info("로그인 / 회원가입 커팅");
					response.sendRedirect("/songtalk/member/");
				} else if (dest != null) {
					logger.info("그 외의 경로 pass");
					response.sendRedirect(dest);
				}
				
			} else {	// 처음화면에서 로그인했을때
				response.sendRedirect("/songtalk");
			}
			
			
		} else {
			logger.info("로그인 실패");
			HttpSession session = request.getSession();
			session.setAttribute("loginResult", "fail");
			response.sendRedirect("/songtalk/member/login");
		}
		super.postHandle(request, response, handler, modelAndView);
	} // postHandle

} // LoginInterceptor
