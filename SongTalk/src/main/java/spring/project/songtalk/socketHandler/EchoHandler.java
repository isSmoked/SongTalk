package spring.project.songtalk.socketHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class EchoHandler extends TextWebSocketHandler{
	// �α��� �� ��ü
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	/* TODO : ���⼭ �ش� ���ӿ� ���õ� ����鸸 �˻��ؼ� �޽����� ������ �Ѵ�. */
	
	private static final Logger logger =
			LoggerFactory.getLogger(EchoHandler.class);
	
	// 1 �� 1
	Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	
	// Ŭ���̾�Ʈ�� ������ �����
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			logger.info("afterConnectionEstablished() ȣ��");
			
			String userid = getMemberId(session); // ������ ������ http������ ��ȸ�Ͽ� id�� ��� �Լ�
			if (userid != null) {	// �α��� ���� �ִ� ��츸
				logger.info("�α��� ���� �־ �α��ε�! userid = " + userid);
				users.put(userid, session);   // �α����� �������� ����
				sessions.add(session);
			}
		} // end afterConnectionEstablished()
		
		// Ŭ���̾�Ʈ�� Data ���� ��
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			logger.info("***** handleTextMessage() ȣ�� message : " + message.getPayload());
			// protocol : cmd , ����ۼ���, �Խñ� �ۼ��� , seq (reply , user2 , user1 , 12)
			String msg = message.getPayload();
			
			// ������ �޽��� > attend,zz,aaa,42,1
			String[] strs = msg.split("[*]");

			for (int i = 0; i < strs.length; i++) {
				logger.info("strs[" + i + "] = " + strs[i]);
			}
			
			if (strs != null && strs.length == 5) {
				String cmd = strs[0];		// ��ɾ� - ���߿� �ٸ� ��ο��� �ٸ� ����� �˸��� �߰��Ҷ�, ������ �뵵
				String receiver = strs[1];	// �����ϴ� �̿����� id 
				String waiter[] = receiver.split(",");
				
				
				String caller = strs[2];	// ȣ���ϴ� �̿����� id
				
				// �˸��� ������ �ش��������� �����ϱ����� �ʿ��� �Ű��������� �߰� -> detail-admin.jsp
				/* bno, page ����! */
				String bno_seq = strs[3];
				String page_seq = strs[4];
				
				// ���� Alert
				if (cmd.equals("attend")) {				// �̿��ڰ� ���ӿ� ������ �� (cmd = attend)
					for (int i = 0; i < waiter.length; i++) {
						logger.info("attend - for()");
						// �ۼ��ڰ� �α��� �ؼ� �ִٸ�
						WebSocketSession boardWriterSession = users.get(waiter[i]);
						
						// ���� ����������� ����
						if (boardWriterSession != null) {
							TextMessage tmpMsg = new TextMessage(caller + "���� " + 
									"<div><a type='external' href='/prj/studyBoard/detail-admin?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "�� ���ӿ� ������û�� �Ͽ����ϴ�. </a></div>");
							logger.info("******** �������� �޼��� : " + tmpMsg);
							boardWriterSession.sendMessage(tmpMsg);
						} else {
							logger.info(waiter[i] + "���� �α׾ƿ� �� �Դϴ�."); // �α׾ƿ� ���̸� �����Կ� ���̵��� ����!
						}
					}
				} else if (cmd.equals("attendOK")) {	// �̿��ڸ� ���ӿ� ���� ��ų�� (cmd = attendOK)
					
					logger.info("attend**OK - for()");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div><a type='external' href='/prj/studyBoard/detail?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "�� ���ӿ� ���� �Ǿ����ϴ�. </a></div>");
						logger.info("********* �������� �޼��� : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(waiter + "���� �α׾ƿ� ���Դϴ�.");
					}
					
				} else if (cmd.equals("chatMsg")) {
					
					logger.info("chatMsg - for()");
					
					/* �α������� ��� �������� ���� �� > chatMsg */
					
					for (WebSocketSession sess : sessions) {
//						
						// message handle
						String chatMsg = receiver;
						
						sess.sendMessage(new TextMessage("chatMsg," + caller + " ^ " + chatMsg));
						logger.info("chatMsg ���������� ���� �Ϸ�!");
					}
					
				} else if (cmd.equals("deleteNO")) {
					
					logger.info("deleteNO - for()");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div><a type='external' href='/prj/studyBoard/detail?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "�� ���ӿ��� �Ѱܳ��� �Ǿ����ϴ�. </a></div>");
						logger.info("********* �������� �޼��� : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(waiter + "���� �α׾ƿ� ���Դϴ�.");
					}
				}
				
			} // end str == 5
			
			if (strs != null && strs.length == 6) {
				
				String cmd = strs[0];		// ��ɾ� - ���߿� �ٸ� ��ο��� �ٸ� ����� �˸��� �߰��Ҷ�, ������ �뵵
				String receiver = strs[1];	// �����ϴ� �̿����� id 
				String waiter[] = receiver.split(",");
				
				
				String caller = strs[2];	// ȣ���ϴ� �̿����� id
				
				// �˸��� ������ �ش��������� �����ϱ����� �ʿ��� �Ű��������� �߰� -> detail-admin.jsp
				/* bno, page ����! */
				String bno_seq = strs[3];
				String page_seq = strs[4];
				String rejectMessage = strs[5]; 
				
				
				if (cmd.equals("attendNO")) { 	// �̿��ڸ� ���ӿ��� ������ �� (cmd = attendNO)
					
					logger.info("attend**NO - for()");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div><a type='external' href='/prj/studyBoard/detail?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "�� ���ӿ� [" + rejectMessage + "] ������ ���� �����Ͽ����ϴ�. </a></div>");
						logger.info("********* �������� �޼��� : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(waiter + "���� �α׾ƿ� ���Դϴ�.");
					}
				} 
			}
			
		} // end handleTextMessage()
		
		// ���� ������ ��
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			logger.info("afterConnectionClosed " + session + ", " + status);
			String senderId = getMemberId(session);
			if(senderId != null) {	// �α��� ���� �ִ� ��츸
				logger.info("�α��� ���� �־ �α׾ƿ����� ! senderId : " + senderId + " ���� �����");
				users.remove(senderId);
			}
			sessions.remove(session);
		} // end afterConnectionClosed()
		
		// ���� �߻���
		@Override
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
			logger.info("error �߻�! : " + session.getId() + " �ͼ��� �߻�: " + exception.getMessage());

		} // end handleTramsportError()
		
		// �����Ͽ� id ��������
	    // ������ ������ http������ ��ȸ�Ͽ� id�� ��� �Լ�
		private String getMemberId(WebSocketSession session) {
			Map<String, Object> httpSession = session.getAttributes();
			String userid = (String) httpSession.get("loginId"); // ���ǿ� ����� m_id ���� ��ȸ
			return userid == null? null: userid;
		} // end getMemberId()
		
		
}
