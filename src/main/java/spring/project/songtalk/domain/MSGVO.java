package spring.project.songtalk.domain;

import java.util.Date;

public class MSGVO {
	private String msgSender;
	private String msgReceiver;
	private String msgContent;
	private Date msgDate;
	private int msgBno;
	private int msgRoom;		// 방 번호 저장용
	
	public MSGVO () {}

	public MSGVO(String msgSender, String msgReceiver, String msgContent, Date msgDate, int msgBno, int msgRoom) {
		super();
		this.msgSender = msgSender;
		this.msgReceiver = msgReceiver;
		this.msgContent = msgContent;
		this.msgDate = msgDate;
		this.msgBno = msgBno;
		this.msgRoom = msgRoom;
	}

	public String getMsgSender() {
		return msgSender;
	}

	public void setMsgSender(String msgSender) {
		this.msgSender = msgSender;
	}

	public String getMsgReceiver() {
		return msgReceiver;
	}

	public void setMsgReceiver(String msgReceiver) {
		this.msgReceiver = msgReceiver;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public Date getMsgDate() {
		return msgDate;
	}

	public void setMsgDate(Date msgDate) {
		this.msgDate = msgDate;
	}

	public int getMsgBno() {
		return msgBno;
	}

	public void setMsgBno(int msgBno) {
		this.msgBno = msgBno;
	}

	public int getMsgRoom() {
		return msgRoom;
	}

	public void setMsgRoom(int msgRoom) {
		this.msgRoom = msgRoom;
	}

	@Override
	public String toString() {
		return "MSGVO [msgSender=" + msgSender + ", msgReceiver=" + msgReceiver + ", msgContent=" + msgContent
				+ ", msgDate=" + msgDate + ", msgBno=" + msgBno + ", msgRoom=" + msgRoom + "]";
	};
	
}
