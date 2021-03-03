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
	// ·Î±×ÀÎ ÇÑ ÀüÃ¼
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	/* TODO : ¿©±â¼­ ÇØ´ç ¸ğÀÓ¿¡ °ü·ÃµÈ »ç¶÷µé¸¸ °Ë»öÇØ¼­ ¸Ş½ÃÁö¸¦ º¸³»¾ß ÇÑ´Ù. */
	
	private static final Logger logger =
			LoggerFactory.getLogger(EchoHandler.class);
	
	// 1 ´ë 1
	Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	
	// Å¬¶óÀÌ¾ğÆ®°¡ ¼­¹ö·Î ¿¬°á½Ã
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			logger.info("afterConnectionEstablished() È£Ãâ");
			
			String userid = getMemberId(session); // Á¢¼ÓÇÑ À¯ÀúÀÇ http¼¼¼ÇÀ» Á¶È¸ÇÏ¿© id¸¦ ¾ò´Â ÇÔ¼ö
			if (userid != null) {	// ·Î±×ÀÎ °ªÀÌ ÀÖ´Â °æ¿ì¸¸
				logger.info("·Î±×ÀÎ °ªÀÌ ÀÖ¾î¼­ ·Î±×ÀÎµÊ! userid = " + userid);
				users.put(userid, session);   // ·Î±×ÀÎÁß °³º°À¯Àú ÀúÀå
				sessions.add(session);
			}
		} // end afterConnectionEstablished()
		
		// Å¬¶óÀÌ¾ğÆ®°¡ Data Àü¼Û ½Ã
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			logger.info("***** handleTextMessage() È£­Œ message : " + message.getPayload());
			// protocol : cmd , ´ñ±ÛÀÛ¼ºÀÚ, °Ô½Ã±Û ÀÛ¼ºÀÚ , seq (reply , user2 , user1 , 12)
			String msg = message.getPayload();
			
			// µé¾î¿À´Â ¸Ş½ÃÁö > attend,zz,aaa,42,1
			String[] strs = msg.split("[*]");

			for (int i = 0; i < strs.length; i++) {
				logger.info("strs[" + i + "] = " + strs[i]);
			}
			
			if (strs != null && strs.length == 5) {
				String cmd = strs[0];		// ¸í·É¾î - ³ªÁß¿¡ ´Ù¸¥ °æ·Î¿¡¼­ ´Ù¸¥ ±â´ÉÀÇ ¾Ë¸²À» Ãß°¡ÇÒ¶§, ±¸ºĞÀÇ ¿ëµµ
				String receiver = strs[1];	// ¼ö½ÅÇÏ´Â ÀÌ¿ëÀÚÀÇ id 
				String waiter[] = receiver.split(",");
				
				
				String caller = strs[2];	// È£ÃâÇÏ´Â ÀÌ¿ëÀÚÀÇ id
				
				// ¾Ë¸²À» ´©¸£¸é ÇØ´çÆäÀÌÁö·Î Á¢±ÙÇÏ±âÀ§ÇØ ÇÊ¿äÇÑ ¸Å°³º¯¼öµéÀ» Ãß°¡ -> detail-admin.jsp
				/* bno, page Àü¼Û! */
				String bno_seq = strs[3];
				String page_seq = strs[4];
				
				// Âü¼® Alert
				if (cmd.equals("attend")) {				// ÀÌ¿ëÀÚ°¡ ¸ğÀÓ¿¡ Âü¼®ÇÒ ¶§ (cmd = attend)
					for (int i = 0; i < waiter.length; i++) {
						logger.info("attend - for()");
						// ÀÛ¼ºÀÚ°¡ ·Î±×ÀÎ ÇØ¼­ ÀÖ´Ù¸é
						WebSocketSession boardWriterSession = users.get(waiter[i]);
						
						// ¿©±â ½ÇÇà°úÁ¤¿¡¼­ ¿À·ù
						if (boardWriterSession != null) {
							TextMessage tmpMsg = new TextMessage(caller + "´ÔÀÌ " + 
									"<div><a type='external' href='/prj/studyBoard/detail-admin?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "¹ø ¸ğÀÓ¿¡ Âü°¡½ÅÃ»À» ÇÏ¿´½À´Ï´Ù. </a></div>");
							logger.info("******** º¸³»·Á´Â ¸Ş¼¼Áö : " + tmpMsg);
							boardWriterSession.sendMessage(tmpMsg);
						} else {
							logger.info(waiter[i] + "´ÔÀº ·Î±×¾Æ¿ô Áß ÀÔ´Ï´Ù."); // ·Î±×¾Æ¿ô ÁßÀÌ¸é ÂÊÁöÇÔ¿¡ ½×ÀÌµµ·Ï ¼³Á¤!
						}
					}
				} else if (cmd.equals("attendOK")) {	// ÀÌ¿ëÀÚ¸¦ ¸ğÀÓ¿¡ Âü¼® ½ÃÅ³¶§ (cmd = attendOK)
					
					logger.info("attend**OK - for()");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div><a type='external' href='/prj/studyBoard/detail?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "¹ø ¸ğÀÓ¿¡ Âü°¡ µÇ¾ú½À´Ï´Ù. </a></div>");
						logger.info("********* º¸³»·Á´Â ¸Ş¼¼Áö : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(waiter + "´ÔÀº ·Î±×¾Æ¿ô ÁßÀÔ´Ï´Ù.");
					}
					
				} else if (cmd.equals("chatMsg")) {
					
					logger.info("chatMsg - for()");
					
					/* ·Î±×ÀÎÁßÀÎ ¸ğµç À¯Àú¿¡°Ô º¸³¾ ¶§ > chatMsg */
					
					for (WebSocketSession sess : sessions) {
//						
						// message handle
						String chatMsg = receiver;
						
						sess.sendMessage(new TextMessage("chatMsg," + caller + " ^ " + chatMsg));
						logger.info("chatMsg Á¤»óÀûÀ¸·Î Àü¼Û ¿Ï·á!");
					}
					
				} else if (cmd.equals("deleteNO")) {
					
					logger.info("deleteNO - for()");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div><a type='external' href='/prj/studyBoard/detail?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "¹ø ¸ğÀÓ¿¡¼­ ÂÑ°Ü³ª°Ô µÇ¾ú½À´Ï´Ù. </a></div>");
						logger.info("********* º¸³»·Á´Â ¸Ş¼¼Áö : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(waiter + "´ÔÀº ·Î±×¾Æ¿ô ÁßÀÔ´Ï´Ù.");
					}
				}
				
			} // end str == 5
			
			if (strs != null && strs.length == 6) {
				
				String cmd = strs[0];		// ¸í·É¾î - ³ªÁß¿¡ ´Ù¸¥ °æ·Î¿¡¼­ ´Ù¸¥ ±â´ÉÀÇ ¾Ë¸²À» Ãß°¡ÇÒ¶§, ±¸ºĞÀÇ ¿ëµµ
				String receiver = strs[1];	// ¼ö½ÅÇÏ´Â ÀÌ¿ëÀÚÀÇ id 
				String waiter[] = receiver.split(",");
				
				
				String caller = strs[2];	// È£ÃâÇÏ´Â ÀÌ¿ëÀÚÀÇ id
				
				// ¾Ë¸²À» ´©¸£¸é ÇØ´çÆäÀÌÁö·Î Á¢±ÙÇÏ±âÀ§ÇØ ÇÊ¿äÇÑ ¸Å°³º¯¼öµéÀ» Ãß°¡ -> detail-admin.jsp
				/* bno, page Àü¼Û! */
				String bno_seq = strs[3];
				String page_seq = strs[4];
				String rejectMessage = strs[5]; 
				
				
				if (cmd.equals("attendNO")) { 	// ÀÌ¿ëÀÚ¸¦ ¸ğÀÓ¿¡¼­ Á¦°ÅÇÒ ¶§ (cmd = attendNO)
					
					logger.info("attend**NO - for()");
					WebSocketSession boardWriterSession = users.get(receiver);
					
					if (boardWriterSession != null) {
						TextMessage tmpMsg = new TextMessage(
								"<div><a type='external' href='/prj/studyBoard/detail?bno=" + bno_seq + "&page=" + page_seq + "'>" + bno_seq + "¹ø ¸ğÀÓ¿¡ [" + rejectMessage + "] »çÀ¯·Î Âü°¡ ½ÇÆĞÇÏ¿´½À´Ï´Ù. </a></div>");
						logger.info("********* º¸³»·Á´Â ¸Ş¼¼Áö : " + tmpMsg);
						boardWriterSession.sendMessage(tmpMsg);
					} else {
						logger.info(waiter + "´ÔÀº ·Î±×¾Æ¿ô ÁßÀÔ´Ï´Ù.");
					}
				} 
			}
			
		} // end handleTextMessage()
		
		// ¿¬°á ÇØÁ¦µÉ ¶§
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			logger.info("afterConnectionClosed " + session + ", " + status);
			String senderId = getMemberId(session);
			if(senderId != null) {	// ·Î±×ÀÎ °ªÀÌ ÀÖ´Â °æ¿ì¸¸
				logger.info("·Î±×ÀÎ °ªÀÌ ÀÖ¾î¼­ ·Î±×¾Æ¿ô°¡´É ! senderId : " + senderId + " ¿¬°á Á¾·áµÊ");
				users.remove(senderId);
			}
			sessions.remove(session);
		} // end afterConnectionClosed()
		
		// ¿¡·¯ ¹ß»ı½Ã
		@Override
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
			logger.info("error ¹ß»ı! : " + session.getId() + " ÀÍ¼Á¼Ç ¹ß»ı: " + exception.getMessage());

		} // end handleTramsportError()
		
		// À¥¼ÒÄÏ¿¡ id °¡Á®¿À±â
	    // Á¢¼ÓÇÑ À¯ÀúÀÇ http¼¼¼ÇÀ» Á¶È¸ÇÏ¿© id¸¦ ¾ò´Â ÇÔ¼ö
		private String getMemberId(WebSocketSession session) {
			Map<String, Object> httpSession = session.getAttributes();
			String userid = (String) httpSession.get("loginId"); // ¼¼¼Ç¿¡ ÀúÀåµÈ m_id ±âÁØ Á¶È¸
			return userid == null? null: userid;
		} // end getMemberId()
		
		
}
