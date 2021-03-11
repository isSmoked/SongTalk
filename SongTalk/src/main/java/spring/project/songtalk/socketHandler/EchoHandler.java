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
	// 로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	// 대화방
	// ???
	
	private static final Logger logger =
			LoggerFactory.getLogger(EchoHandler.class);
	
	// 1 대 1
	Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	
	// 클라이언트가 서버로 연결시
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			logger.info("afterConnectionEstablished() 호출");
			
			String userid = getMemberId(session); // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
			if (userid != null) {	// 로그인 값이 있는 경우만
				logger.info("�α��� ���� �־ �α��ε�! userid = " + userid);
				users.put(userid, session);   // 로그인중 개별유저 저장
				sessions.add(session);
			}
		} // end afterConnectionEstablished()
		
		// 클라이언트가 Data 전송 시
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			logger.info("***** handleTextMessage() 호출 message : " + message.getPayload());
			// protocol : cmd , 발신인, 수신인, 대화방 이름
			String msg = message.getPayload(); // �޾ƿ� �޽���
			
			// 들어오는 메시지 > ???
			String[] strs = msg.split("[*]");

			for (int i = 0; i < strs.length; i++) {
				logger.info("strs[" + i + "] = " + strs[i]);
			}
			
			if (strs != null && strs.length == 5) {
				String cmd = strs[0];		// 명령어 - 나중에 다른 경로에서 다른 기능의 알림을 추가할때, 구분의 용도
				String caller = strs[1];	// 수신하는 이용자의 id 
				String receiver = strs[2];	// 발신하는 이용자의 id 
				String title = strs[3];		// 대화방 이름
				String content = strs[4];	// 대화 내용
				
				// 초대 Alert
				if (cmd.equals("invite")) {				// 대화방에 초대될 때 (cmd = invite)
					logger.info("invite() 호출");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div>"
								+ "<a type='external' href='songtalk/???/???'>"
								+ title + " 대화방의 " + caller + "님이 초대하였습니다."
								+ "</a></div>"
								);
						
						logger.info("보내려는 메시지 : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(receiver + " - 로그아웃");
					}
					
				// 대화방 채팅
					// 어느 대화방의 대화인지 여기서 걸러야한다.!!
				} else if (cmd.equals("roomCHAT")) {
					// caller, receiver[], title(roomName), content
					logger.info("roomCHAT() 호출");
					
					String[] roomReceiver = receiver.split("[*]"); // 받는 사람
					
					for (int i = 0; i < roomReceiver.length; i++) {
						WebSocketSession boardWriterSession = users.get(roomReceiver[i]);
						
						TextMessage tmpMsg = new TextMessage("roomCHAT*" + caller + "*" + roomReceiver 
								+ "*" + title + "*" + content);
						boardWriterSession.sendMessage(tmpMsg);
						logger.info("chatMsg(roomCHAT) 정상적으로 전송 완료!");
					}
					/* onmessage로 출력하지말고 여기서 controller로 저장시키고, jsp에서 ajax로 데이터 불러오자 */
					
				} else if (cmd.equals("allCHAT")) {
					/* 로그인중인 모든 유저에게 보낼 때 > allCHAT */
					// caller , receiver
					logger.info("allCHAT() 호출");
					
					for (WebSocketSession sess : sessions) {
//						
						// message handle
						String chatMsg = receiver;
						
						sess.sendMessage(new TextMessage("allCHAT," + caller + " ^ " + chatMsg));
						logger.info("chatMsg(allCHAT) 정상적으로 전송 완료!!");
					}
				} 
				
			} // end str == 4
			
			
			
		} // end handleTextMessage()
		
		// 연결 해제될 때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			logger.info("afterConnectionClosed " + session + ", " + status);
			String senderId = getMemberId(session);
			if(senderId != null) {	// 로그인 값이 있는 경우만
				logger.info("로그인 값이 있어서 로그아웃가능 ! senderId : \" + senderId + \" 연결 종료됨");
				users.remove(senderId);
			}
			sessions.remove(session);
		} // end afterConnectionClosed()
		
		// 에러 발생시
		@Override
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
			logger.info("error 발생! : " + session.getId() + "익셉션 발생" + exception.getMessage());

		} // end handleTramsportError()
		
		// 웹소켓에 id 가져오기
	    // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
		private String getMemberId(WebSocketSession session) {
			Map<String, Object> httpSession = session.getAttributes();
			String userid = (String) httpSession.get("loginId"); // 세션에 저장된 m_id 기준 조회
			return userid == null? null: userid;
		} // end getMemberId()
		
		
}
