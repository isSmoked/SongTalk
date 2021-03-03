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
		logger.info("===== LoginInterceptor preHandle ȣ��");
		// login.jsp���� form action="login-post"�� �̵��ϱ� ����
		// �����͸� ����ä�� ���ǿ� �� ������ ����
		String url = request.getParameter("targetUrl");
		logger.info("������ url : " + url);
		if (url != null && url != "") {
			request.getSession().setAttribute("dest", url);
		}
		return true;
	} // preHandle

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("===== LoginInterceptor postHandle ȣ��");
		// model ��ü�� loginResult �Ӽ���(userid�� ����)�� Ȯ��
		// - null�� �ƴϸ�(�α��� ����) session ��ü�� loingId �Ӽ� �߰�, ������ �̵�
		// - null�̸�(�α��� ����) ���� �������� �̵�

		String loginId = (String) modelAndView.getModel().get("result");
		String part = (String) modelAndView.getModel().get("part");
		logger.info("=== LoginInterceptor postHandle loginId = " + loginId);
		logger.info("=== LoginInterceptor postHandle part = " + part);

		if (loginId != null) {
			int blacklist = (int) modelAndView.getModel().get("blacklist");
			logger.info("=== LoginInterceptor postHandle blacklist = " + blacklist);
			logger.info("�α��� ����");
			HttpSession session = request.getSession();
			session.setAttribute("loginId", loginId);
			session.setAttribute("part", part);
			session.setAttribute("blacklist", blacklist);
			session.setAttribute("loginResult", "success");
			// ���ǿ��� ���� url ��������
			String dest = (String) session.getAttribute("dest");
			logger.info("*********** ��� : " + dest);
			int count = dest.split("/").length;
			logger.info("count = " + count);
			
			if (count > 4) {
				
				String ip = dest.split("/")[4] + "/" + dest.split("/")[5]; 
				logger.info("ip : " + ip);
				
				// �α��� / ȸ������ ��� ����
				if (ip.contains("member/login") || ip.contains("member/register") || ip == null) {
					logger.info("�α��� / ȸ������ Ŀ��");
					response.sendRedirect("/prj/RecBoard/main");
				} else if (dest != null) {
					logger.info("�� ���� ��� pass");
					response.sendRedirect(dest);
				}
				
			} else {	// ó��ȭ�鿡�� �α���������
				response.sendRedirect("/prj/RecBoard/main");
			}
			
			
		} else {
			logger.info("�α��� ����");
			HttpSession session = request.getSession();
			session.setAttribute("loginResult", "fail");
			response.sendRedirect("/prj/member/login");
		}
		super.postHandle(request, response, handler, modelAndView);
	} // postHandle

} // LoginInterceptor
